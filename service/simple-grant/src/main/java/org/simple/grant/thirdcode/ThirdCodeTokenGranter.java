package org.simple.grant.thirdcode;


import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AccountStatusException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.security.oauth2.provider.*;
import org.springframework.security.oauth2.provider.token.AbstractTokenGranter;
import org.springframework.security.oauth2.provider.token.AuthorizationServerTokenServices;

import java.util.LinkedHashMap;
import java.util.Map;

public class ThirdCodeTokenGranter extends AbstractTokenGranter {

    private static final String GRANT_TYPE = "third_code";

    private final AuthenticationManager authenticationManager;

    public ThirdCodeTokenGranter(AuthenticationManager authenticationManager, AuthorizationServerTokenServices tokenServices, ClientDetailsService clientDetailsService, OAuth2RequestFactory requestFactory) {
        this(authenticationManager, tokenServices, clientDetailsService, requestFactory, GRANT_TYPE);
    }

    protected ThirdCodeTokenGranter(AuthenticationManager authenticationManager, AuthorizationServerTokenServices tokenServices, ClientDetailsService clientDetailsService, OAuth2RequestFactory requestFactory, String grantType) {
        super(tokenServices, clientDetailsService, requestFactory, grantType);
        this.authenticationManager = authenticationManager;
    }

    @Override
    protected OAuth2Authentication getOAuth2Authentication(ClientDetails client, TokenRequest tokenRequest) {
        Map<String, String> parameters = new LinkedHashMap(tokenRequest.getRequestParameters());
        String openId = parameters.get("openId");
        String authCode = parameters.get("authCode");
        String type = parameters.get("type");
        String avatar = parameters.get("avatar");
        String nickName = parameters.get("nickName");
        Authentication userAuth = new ThirdCodeAuthenticationToken(openId,type,authCode,avatar,nickName);
        ((AbstractAuthenticationToken)userAuth).setDetails(parameters);
        try {
            userAuth = this.authenticationManager.authenticate(userAuth);
        } catch (AccountStatusException ex) {
            throw new InvalidGrantException(ex.getMessage());
        } catch (BadCredentialsException ex) {
            throw new InvalidGrantException(ex.getMessage());
        }

        if (userAuth != null && userAuth.isAuthenticated()) {
            OAuth2Request storedOAuth2Request = this.getRequestFactory().createOAuth2Request(client, tokenRequest);
            return new OAuth2Authentication(storedOAuth2Request, userAuth);
        } else {
            throw new InvalidGrantException("Could not authenticate openId: " + openId);
        }
    }
}
