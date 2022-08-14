package org.simple.common.dto;

import lombok.Data;

@Data
public class EmailDto {

    private String host;
    private String port;
    private String username;
    private String password;
    private String sitename;
    private Integer isssl;
}
