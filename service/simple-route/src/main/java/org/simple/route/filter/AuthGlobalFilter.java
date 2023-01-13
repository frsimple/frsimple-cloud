package org.simple.route.filter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.simple.common.utils.CommonResult;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.util.List;

@Slf4j
@Component
@ConfigurationProperties(prefix = "auth")
public class AuthGlobalFilter implements GlobalFilter, Ordered {

    @Getter
    @Setter
    private List<String> whiteUrls;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        String requestUrl = exchange.getRequest().getPath().value();
        AntPathMatcher pathMatcher = new AntPathMatcher();
        //授权服务方形所有接口
        if (pathMatcher.match("/auth/**", requestUrl)) {
            return chain.filter(exchange);
        }
        //白名单路径进行放行
        if (CollectionUtils.isNotEmpty(whiteUrls)) {
            for (int i = 0; i < whiteUrls.size(); i++) {
                if (pathMatcher.match(whiteUrls.get(i), requestUrl)) {
                    return chain.filter(exchange);
                }
            }
        }
        //2 检查token是否存在
        String token = getToken(exchange);
        if (StringUtils.isBlank(token)) {
            return buildReturnMono(JSONObject.parseObject(
                    JSON.toJSONString(CommonResult.unauthorized("无效的token"))), exchange);
        }
        return  chain.filter(exchange);
    }


    /**
     * 获取token
     */
    private String getToken(ServerWebExchange exchange) {
        String tokenStr = exchange.getRequest().getHeaders().getFirst("Authorization");
        if (StringUtils.isBlank(tokenStr)) {
            return null;
        }
        String token = tokenStr.split(" ")[1];
        if (StringUtils.isBlank(token)) {
            return null;
        }
        return token;
    }


    private Mono<Void> buildReturnMono(JSONObject json, ServerWebExchange exchange) {
        ServerHttpResponse response = exchange.getResponse();
        byte[] bits = json.toJSONString().getBytes(StandardCharsets.UTF_8);
        DataBuffer buffer = response.bufferFactory().wrap(bits);
        response.setStatusCode(HttpStatus.UNAUTHORIZED);
        //指定编码，否则在浏览器中会中文乱码
        response.getHeaders().add("Content-Type", "text/plain;charset=UTF-8");
        return response.writeWith(Mono.just(buffer));
    }


    @Override
    public int getOrder() {
        return -10000;
    }
}
