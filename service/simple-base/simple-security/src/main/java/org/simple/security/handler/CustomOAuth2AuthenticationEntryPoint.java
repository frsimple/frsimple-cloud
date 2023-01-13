package org.simple.security.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.simple.common.utils.CommonResult;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.client.resource.OAuth2AccessDeniedException;
import org.springframework.security.oauth2.common.exceptions.InvalidTokenException;
import org.springframework.security.oauth2.provider.error.OAuth2AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Component
public class CustomOAuth2AuthenticationEntryPoint extends OAuth2AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException {
        response.setStatus(HttpStatus.OK.value());
        response.setCharacterEncoding("utf-8");
        response.setStatus(403);
        response.setHeader("Content-Type", "application/json;charset=UTF-8");
        PrintWriter printWriter = response.getWriter();
        Throwable cause = authException.getCause();
        if (cause instanceof OAuth2AccessDeniedException) {
            printWriter.append(new ObjectMapper().writeValueAsString(CommonResult.unauthorized("无权访问该资源服务")));
        }  else if (cause instanceof InvalidTokenException) {
            printWriter.append(new ObjectMapper().writeValueAsString(CommonResult.unauthorized("无效的token")));
        }else if (authException instanceof InsufficientAuthenticationException) {
            printWriter.append(new ObjectMapper().writeValueAsString(CommonResult.unauthorized("无效的token")));
        }else{
            printWriter.append(new ObjectMapper().writeValueAsString(CommonResult.unauthorized("未知错误")));
        }
    }
}
