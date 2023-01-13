package org.simple.security.interceptor;


import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;

@Component
public class FeignInterceptor implements RequestInterceptor {

    /**
     * feign调用之前进行拦截
     * 获取用户的令牌,再将令牌封装到请求头中传递到下个微服务
     */
    @Override
    public void apply(RequestTemplate requestTemplate) {
        HttpServletRequest request = getHttpServletRequest();

        if (Objects.isNull(request)) {
            return;
        }
        //requestTemplate.header()
        Map<String, String> headers = getHeaders(request);
        if (headers.size() > 0) {
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                // 把请求过来的header请求头 原样设置到feign请求头中
                // 包括token
                requestTemplate.header(entry.getKey(), entry.getValue());
                //System.out.println("请求"+entry.getKey()+":"+ entry.getValue());
            }
            requestTemplate.header("inward","1");
        }
    }


    /**
     * ServletRequestAttributes 记录了当前用户请求的所有数据,包括请求头和请求参数等
     * 用户当前请求的时候对应,如果开启了feign的熔断后会用新的线程,需要将熔断策略换成信号量,此时不会开启新的线程
     *
     */
    private HttpServletRequest getHttpServletRequest() {

        try {
            // 这种方式获取的HttpServletRequest是线程安全的
            return ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest();
        } catch (Exception e) {

            return null;
        }
    }

    private Map<String, String> getHeaders(HttpServletRequest request) {

        Map<String, String> map = new LinkedHashMap<>();

        Enumeration<String> enums = request.getHeaderNames();
        while (enums.hasMoreElements()) {
            String key = enums.nextElement();
            String value = request.getHeader(key);
            map.put(key, value);
        }

        return map;

    }
}