package org.simple.grant.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;
import org.springframework.security.oauth2.provider.error.WebResponseExceptionTranslator;


public class WebResponseTranslator implements WebResponseExceptionTranslator {

    @Override
    public ResponseEntity<OAuth2Exception> translate(Exception exception) throws Exception {
        if (exception instanceof InternalAuthenticationServiceException) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new CustomOAuth2Exception("用户名或密码错误"));
        }
        if(exception instanceof BadCredentialsException){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).
                    body(new CustomOAuth2Exception(exception.getMessage()));
        }
        if(exception instanceof InvalidGrantException){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).
                    body(new CustomOAuth2Exception(exception.getMessage()));
        }

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new CustomOAuth2Exception(exception.getMessage()));
    }
}
