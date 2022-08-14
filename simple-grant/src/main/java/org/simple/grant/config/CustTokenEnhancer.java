package org.simple.grant.config;

import org.simple.common.dto.SimpleUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class CustTokenEnhancer implements TokenEnhancer {


    @Override
    public OAuth2AccessToken enhance(OAuth2AccessToken oAuth2AccessToken, OAuth2Authentication authentication) {
        Map<String, Object> additionalInformation = new HashMap<>();
        Authentication userAuthentication = authentication.getUserAuthentication();
        Object principal = userAuthentication.getPrincipal();
        if (principal instanceof SimpleUser){
            SimpleUser user= (SimpleUser) principal;
            additionalInformation.put("id", user.getId());
            //additionalInformation.put("username", user.getUsername());
            //additionalInformation.put("nickname", user.getNickname());
            //additionalInformation.put("logindate", user.getLoginDate());
            additionalInformation.put("clientId",user.getClientId());
            additionalInformation.put("tenantId",user.getTenantId());
        }
        ((DefaultOAuth2AccessToken) oAuth2AccessToken).setAdditionalInformation(additionalInformation);
        return oAuth2AccessToken;
    }
}
