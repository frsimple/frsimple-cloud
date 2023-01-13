package org.simple.center.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.simple.center.entity.User;

@Data
public class UserDto extends User {

    private String tenantName;
    private String roles;
    private String roleIds;

    @JsonProperty("nPassword")
    private String nPassword;
}
