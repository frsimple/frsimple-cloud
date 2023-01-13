package org.simple.grant.smscode;


import cn.hutool.core.util.URLUtil;
import cn.hutool.extra.servlet.ServletUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.simple.common.constant.RedisConstant;
import org.simple.common.dto.Logs;
import org.simple.common.dto.SimpleUser;
import org.simple.common.utils.RedomUtil;
import org.simple.grant.entity.PermissionEntry;
import org.simple.grant.entity.UserEntity;
import org.simple.grant.service.PermissionService;
import org.simple.grant.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

@Slf4j
@Configuration
public class SmsCodeAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private RedisTemplate redisTemplate;

    @Value("${spring.application.name}")
    private String resource;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        SmsCodeAuthenticationToken smsCodeAuthenticationToken = (SmsCodeAuthenticationToken) authentication;
        Map<String,Object> linkedMap = (Map<String,Object>)smsCodeAuthenticationToken.getDetails();
        String mobile = (String) smsCodeAuthenticationToken.getPrincipal();

        UserEntity user = userService.getUserBPhone(mobile);
        if(null == user){
            throw new BadCredentialsException("该手机号未注册或未绑定账号!");
        }
        if (user.getError() >= 5) {
            throw new InvalidGrantException("用户已被锁定，等待5分钟之后在进行登录");
        }
        if(user.getStatus().equals("1")){
            throw new InvalidGrantException("账号已被锁定");
        }
        if(user.getStatus().equals("2")){
            throw new InvalidGrantException("账号已被注销");
        }
        if(userService.selectRoles(user.getId()) == 0){
            throw new InvalidGrantException("用户未绑定角色");
        }
        List<String> codes = permissionService.getPermissionsByUserId(user.getId())
                .stream().map(PermissionEntry::getAuthcode).collect(Collectors.toList());
        Set<GrantedAuthority> userAuthotities = new HashSet<>();
        if (CollectionUtils.isNotEmpty(codes)) {
            codes.forEach(str -> {
                userAuthotities.add(new SimpleGrantedAuthority(str));
            });
        }
        //校验手机收到的验证码和rediss中的验证码是否一致
        //checkSmsCode(mobile);
        //授权通过
        SimpleUser simpleUser = new SimpleUser();
        simpleUser.setId(user.getId());
        //simpleUser.setNickname(user.getNickname());
        //simpleUser.setUsername(user.getUsername());
        simpleUser.setTenantId(user.getTenant());
        simpleUser.setClientId(linkedMap.get("client_id").toString());
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
            centerLogs.setUsername(user.getId());
            centerLogs.setUseragent(request.getHeader("user-agent"));
            centerLogs.setStatus("0");
            userService.insertLogs(centerLogs);
        });
        return new SmsCodeAuthenticationToken(simpleUser, userAuthotities);
    }

    /**
     * 校验手机号与验证码的绑定关系是否正确
     * 在调用短信验证码认之前我们需要先生成验证码，接口需要自己实现
     * Redis的存储风格按照自己的习惯，能够保证唯一即可
     * 然后根据手机号信息去Redis中查询对应的验证码是否正确
     * @param mobile 手机号码
     */
    private void checkSmsCode(String mobile) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //获取验证码
        String smsCode = request.getParameter("code");
        //从redis中获取只当key的值
        Object smsStr = redisTemplate.opsForValue().get(RedisConstant.PHONE_CODE_STR +mobile);
        if(null == smsStr){
            throw new BadCredentialsException("验证码错误!");
        }
        if( !smsCode.equals(smsStr)){
            throw new BadCredentialsException("验证码错误!");
        }
    }

    /**
     * ProviderManager 选择具体Provider时根据此方法判断
     * 判断 authentication 是不是 SmsCodeAuthenticationToken 的子类或子接口
     */
    @Override
    public boolean supports(Class<?> authentication) {
        return SmsCodeAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
