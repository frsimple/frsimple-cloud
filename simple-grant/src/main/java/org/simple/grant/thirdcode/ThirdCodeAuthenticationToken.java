package org.simple.grant.thirdcode;


import com.alibaba.fastjson.JSONObject;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class ThirdCodeAuthenticationToken extends AbstractAuthenticationToken {
    private static final long serialVersionUID = 520L;

    //请求信息
    private final Object principal;


    //构建未授权的 SmsCodeAuthenticationToken
    public ThirdCodeAuthenticationToken(String openId,String type,String authCode,String avatar,String nickName) {
        super(null);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("openId",openId);
        jsonObject.put("type",type);
        jsonObject.put("authCode",authCode);
        jsonObject.put("avatar",avatar);
        jsonObject.put("nickName",nickName);
        this.principal = jsonObject;
        setAuthenticated(false);
    }

    //构建已经授权的 SmsCodeAuthenticationToke
    public ThirdCodeAuthenticationToken(Object principal, Collection<? extends GrantedAuthority> authorities){
        super(authorities);
        this.principal = principal;
        super.setAuthenticated(true);
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getPrincipal() {
        return this.principal;
    }

    @Override
    public void setAuthenticated(boolean isAuthenticated) {
        if(isAuthenticated){
            throw new IllegalArgumentException("Cannot set this token to trusted - use constructor which takes a GrantedAuthority list instead");
        }else{
            super.setAuthenticated(false);
        }
    }

    @Override
    public void eraseCredentials() {
        super.eraseCredentials();
    }
}
