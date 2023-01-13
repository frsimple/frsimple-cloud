package org.simple.grant.thirdcode;


import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.simple.common.dto.SimpleUser;
import org.simple.common.utils.CommonResult;
import org.simple.grant.entity.PermissionEntry;
import org.simple.grant.entity.UserEntity;
import org.simple.grant.feign.FeignPlanServer;
import org.simple.grant.service.PermissionService;
import org.simple.grant.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Configuration
public class ThirdCodeAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private FeignPlanServer feignPlanServer;

    @Value("${spring.application.name}")
    private String resource;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        ThirdCodeAuthenticationToken thirdCodeAuthenticationToken = (ThirdCodeAuthenticationToken) authentication;
        Map<String,Object> linkedMap = (Map<String,Object>)thirdCodeAuthenticationToken.getDetails();
        JSONObject queryObj = (JSONObject) thirdCodeAuthenticationToken.getPrincipal();

        String openId = queryObj.getString("openId");

        SimpleUser simpleUser = new SimpleUser();
        Set<GrantedAuthority> userAuthotities = new HashSet<>();

        //PC端-小程序二维码扫码登录方式判断判断是否已授权的登录
        if(queryObj.getString("type").equals("01")){
            if(StringUtils.isEmpty(openId)){
                 openId = userService.queryOpenIdByCode(queryObj.getString("authCode"));
            }
           if(0 == userService.confirmLogin(queryObj.getString("authCode"),
                   openId)){
               throw new BadCredentialsException("未授权登录!");
           }
            UserEntity user = userService.getUserByThird(queryObj.getString("type"),
                    openId);
            if(null == user){
                throw new BadCredentialsException("第三方账号未绑定!");
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
            if (CollectionUtils.isNotEmpty(codes)) {
                codes.forEach(str -> {
                    userAuthotities.add(new SimpleGrantedAuthority(str));
                });
            }
            //授权通过
            simpleUser.setId(user.getId());
            simpleUser.setTenantId(user.getTenant());
            simpleUser.setClientId(linkedMap.get("client_id").toString());
        }else if("02".equals(queryObj.getString("type"))){
            cn.hutool.json.JSONObject userObj = new cn.hutool.json.JSONObject();
            userObj.set("avatar",queryObj.getString("avatar"));
            userObj.set("username",queryObj.getString("nickName"));
            userObj.set("authcode",queryObj.getString("authCode"));
            CommonResult result;
            try{
                 result =  feignPlanServer.info(userObj);
            }catch (Exception ex){
                throw new InvalidGrantException("登录失败");
            }
            Map r = (Map)result.getData();
            simpleUser.setId(r.get("userid").toString());
            simpleUser.setTenantId("-1");
            simpleUser.setClientId(linkedMap.get("client_id").toString());
        }
        return new ThirdCodeAuthenticationToken(simpleUser, userAuthotities);
    }

    /**
     * ProviderManager 选择具体Provider时根据此方法判断
     * 判断 authentication 是不是 SmsCodeAuthenticationToken 的子类或子接口
     */
    @Override
    public boolean supports(Class<?> authentication) {
        return ThirdCodeAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
