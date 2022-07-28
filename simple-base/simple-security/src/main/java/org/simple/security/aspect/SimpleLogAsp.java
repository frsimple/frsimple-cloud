package org.simple.security.aspect;


import cn.hutool.core.util.URLUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.http.HttpUtil;
import lombok.SneakyThrows;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.simple.common.dto.Logs;
import org.simple.security.annotation.SimpleLog;
import org.simple.security.event.LogsEvent;
import org.simple.security.feign.FeignCenterServer;
import org.simple.security.utils.AuthUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

@Aspect
@Component
public class SimpleLogAsp {

    /**
     * 资源ID
     */
    @Value("${spring.application.name}")
    private String resource;

    @Autowired
    private ApplicationEventPublisher applicationEventPublisher;

    @Resource
    private FeignCenterServer feignCenterServer;

    @SneakyThrows
    @Around("@annotation(simpleLog)")
    public Object around(ProceedingJoinPoint point, SimpleLog simpleLog) {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request =
                ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes()))
                        .getRequest();
        Logs centerLogs = new Logs();
        centerLogs.setRecource(resource);
        centerLogs.setServicename(simpleLog.value());
        centerLogs.setMethod(point.getTarget().getClass().getName()+"."
                +point.getSignature().getName());
        centerLogs.setIp(ServletUtil.getClientIP(request));
        centerLogs.setParams(HttpUtil.toParams(request.getParameterMap()));
        centerLogs.setPath(URLUtil.getPath(request.getRequestURI()));
        centerLogs.setCreatetime(LocalDateTime.now());
        centerLogs.setUsername(AuthUtils.getUser() == null ?"白名单接口":AuthUtils.getUser().getId());
        centerLogs.setUseragent(request.getHeader("user-agent"));
        Long startTime = System.currentTimeMillis();
        Object obj = null;
        try{
             obj = point.proceed();
        }catch (Exception ex){
            centerLogs.setStatus("1");
            centerLogs.setError(ex.getMessage());
            applicationEventPublisher.publishEvent(new LogsEvent(requestAttributes,centerLogs));
            System.out.println("-----异步调用------");
            throw new Exception(ex.getMessage());
        }
        centerLogs.setStatus("0");
        Long endTime = System.currentTimeMillis();
        centerLogs.setTime(String.valueOf(endTime - startTime));
//        CompletableFuture.runAsync(() -> {
//            RequestContextHolder.setRequestAttributes((RequestAttributes)requestAttributes);
//            feignCenterServer.saveLogs(centerLogs);
//        });
        applicationEventPublisher.publishEvent(new LogsEvent(requestAttributes,centerLogs));
        System.out.println("-----异步调用------");
        return obj;
    }

}
