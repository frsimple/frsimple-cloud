package org.simple.grant.exception;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;

@JsonSerialize(using = CustomOAuth2ExceptionSerializer.class)
public class CustomOAuth2Exception extends OAuth2Exception {

    @Getter
    private String errorCode;

    public CustomOAuth2Exception(String msg) {
        super(msg);
    }

    public CustomOAuth2Exception(String msg, Throwable t) {
        super(msg, t);
    }

    public CustomOAuth2Exception(String msg, String errorCode) {
        super(msg);
        this.errorCode = errorCode;
    }

}