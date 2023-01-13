package org.simple.grant.config;

import cn.hutool.core.util.URLUtil;
import cn.hutool.extra.servlet.ServletUtil;
import org.apache.commons.collections4.CollectionUtils;
import org.simple.common.dto.Logs;
import org.simple.common.dto.SimpleUser;
import org.simple.common.utils.RedomUtil;
import org.simple.grant.entity.PermissionEntry;
import org.simple.grant.entity.UserEntity;
import org.simple.grant.service.PermissionService;
import org.simple.grant.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 自定义账号密码登录方法
 */
@Component
public class PwdAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionService permissionService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RedisTemplate redisTemplate;

    @Value("${spring.application.name}")
    private String resource;

    /**
     * 认证逻辑
     *
     * @param authentication 认证信息
     */
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;
        Map<String,Object> linkedMap = (Map<String,Object>)token.getDetails();
        // 查询数据库中用户信息
        UserEntity userDetails = userService.getUserByUsername(token.getName());
        if (null == userDetails) {
            throw new InvalidGrantException("用户名或密码错误");
        }
        if (userDetails.getError() >= 5) {
            throw new InvalidGrantException("用户已被锁定，等待5分钟之后在进行登录");
        }
        if(userDetails.getStatus().equals("1")){
            throw new InvalidGrantException("账号已被锁定");
        }
        if(userDetails.getStatus().equals("2")){
            throw new InvalidGrantException("账号已被注销");
        }
        if(userService.selectRoles(userDetails.getId()) == 0){
            throw new InvalidGrantException("用户未绑定角色");
        }
        List<String> codes = permissionService.getPermissionsByUserId(userDetails.getId())
                .stream().map(PermissionEntry::getAuthcode).collect(Collectors.toList());
        Set<GrantedAuthority> userAuthotities = new HashSet<>();
        if (CollectionUtils.isNotEmpty(codes)) {
            codes.forEach(str -> {
                userAuthotities.add(new SimpleGrantedAuthority(str));
            });
        }
        SimpleUser simpleUser = new SimpleUser();
        simpleUser.setId(userDetails.getId());
        //simpleUser.setNickname(userDetails.getNickname());
        //simpleUser.setUsername(userDetails.getUsername());
        //simpleUser.setLoginDate(userDetails.getLogindate());
        simpleUser.setTenantId(userDetails.getTenant());
        simpleUser.setClientId(linkedMap.get("client_id").toString());
        // 密码验证
        if (passwordEncoder.matches(authentication.getCredentials().toString(), userDetails.getPassword())) {
            //登录成功修改最后登录时间和错误次数
            userService.uptLoginDate(userDetails.getId());
            if (userDetails.getError() != 0) {
                userService.resetError(userDetails.getId());
            }
            //异步记录登录日志
            HttpServletRequest request = ((ServletRequestAttributes)
                    RequestContextHolder.getRequestAttributes()).getRequest();
            CompletableFuture.runAsync(() -> {
                Logs centerLogs = new Logs();
                centerLogs.setId(RedomUtil.getLogsId());
                centerLogs.setRecource(resource);
                centerLogs.setServicename("系统登录");
                centerLogs.setIp(ServletUtil.getClientIP(request));
                centerLogs.setParams("");
                centerLogs.setPath(URLUtil.getPath(request.getRequestURI()));
                centerLogs.setUsername(userDetails.getId());
                centerLogs.setUseragent(request.getHeader("user-agent"));
                centerLogs.setStatus("0");
                userService.insertLogs(centerLogs);
            });
            return new UsernamePasswordAuthenticationToken(simpleUser, userDetails.getPassword(),
                    userAuthotities);
        }
        //增加密码错误次数
        userService.updatPwdError(userDetails.getId());
        if (userDetails.getError() == 4) {
            //增加redis过期事件
            redisTemplate.opsForValue().set("user_passwrod_error:" + userDetails.getId(), 5
                    , 5, TimeUnit.MINUTES);
        }
        throw new InvalidGrantException("用户名或密码错误");
    }

    /**
     * 验证授权token类型
     *
     * @param authentication token类型
     * @return
     */
    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
