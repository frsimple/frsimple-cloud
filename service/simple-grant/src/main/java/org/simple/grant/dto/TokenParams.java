package org.simple.grant.dto;

import lombok.Data;

import java.util.List;

@Data
public class TokenParams {
    private String name;
    private String token;
    private Integer current;
    private Integer size;
    private long total;
    private List<TokenDto> tokenDtos;
}
