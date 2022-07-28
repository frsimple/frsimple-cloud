package org.simple.security.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.simple.common.utils.CommonResult;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

@Component
@ConfigurationProperties(prefix = "auth")
public class AuthenticationFilter extends OncePerRequestFilter {

    @Getter
    @Setter
    private List<String> whiteUrls;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        //白名单直接放行
        if(CollectionUtils.isNotEmpty(whiteUrls)){
            AntPathMatcher pathMatcher = new AntPathMatcher();
            for(int i=0;i< whiteUrls.size() ;i++){
                String wUrl = whiteUrls.get(i);
                LinkedList list = new LinkedList<String>(Arrays.asList(
                        wUrl.split("/")));
                list.remove(1);
                String cUrl = StringUtils.join(list, "/");
                if (pathMatcher.match(cUrl, request.getRequestURI())) {
                    filterChain.doFilter(request,response);
                    return;
                }
            }
        }
        //内部调用放行通过
        if(StringUtils.isNotEmpty(request.getHeader("inward"))
                && request.getRequestURI().startsWith("/inward")){
            filterChain.doFilter(request,response);
            return;
        }
        if(StringUtils.isEmpty(request.getHeader("Authorization"))){
            response.setStatus(HttpStatus.OK.value());
            response.setCharacterEncoding("utf-8");
            response.setStatus(403);
            response.setHeader("Content-Type", "application/json;charset=UTF-8");
            PrintWriter printWriter = response.getWriter();
            printWriter.append(new ObjectMapper().writeValueAsString(CommonResult.unauthorized("无效的token")));
            return;
        }
        filterChain.doFilter(request,response);
    }


}
