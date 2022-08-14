package org.simple.center.dto;

import lombok.Data;
import org.simple.center.entity.Logs;

@Data
public class LogsDto extends Logs {

    private String nickName;

}
