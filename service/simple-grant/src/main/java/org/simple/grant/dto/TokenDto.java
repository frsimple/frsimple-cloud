package org.simple.grant.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class TokenDto {
    private String username;
    private String nickname;
    private LocalDateTime loginDate;
    private String tiems;
    private String token;
    private String tenantId;
    private String clientId;
}
