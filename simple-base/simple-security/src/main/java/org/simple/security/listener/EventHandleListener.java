package org.simple.security.listener;


import org.simple.security.event.LogsEvent;
import org.simple.security.feign.FeignCenterServer;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import javax.annotation.Resource;

@Component
public class EventHandleListener {

    @Resource
    private FeignCenterServer feignCenterServer;

    @EventListener
    @Async
    public void handleEvent(LogsEvent event) throws Exception {
        System.out.println("------监听到了------开始执行");
        RequestContextHolder.setRequestAttributes((RequestAttributes)event.getSource());
        feignCenterServer.saveLogs(event.getCenterLogs());
    }

}