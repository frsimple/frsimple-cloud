package org.simple.grant.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 权限对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PermissionEntry {

    private String id;

    private String role;

    private String menu;

    private String authcode;

}
