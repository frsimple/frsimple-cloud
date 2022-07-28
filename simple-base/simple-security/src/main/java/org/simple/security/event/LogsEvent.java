package org.simple.security.event;

import lombok.Getter;
import org.simple.common.dto.Logs;
import org.springframework.context.ApplicationEvent;

@Getter
public class LogsEvent extends ApplicationEvent {
    private Logs centerLogs;
    public LogsEvent(Object source, Logs centerLogs) {
        super(source);
        this.centerLogs = centerLogs;
    }
}