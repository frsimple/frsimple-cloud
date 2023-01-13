package org.simple.security.utils;


import lombok.experimental.UtilityClass;
import org.simple.common.dto.SimpleUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@UtilityClass
public class AuthUtils {

    /**
     * 获取用户
     */
    public SimpleUser getUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        try{
            return (SimpleUser)authentication.getPrincipal();
        }catch (Exception ex){
            return null;
        }
    }

    public List<String> getAuthoritys() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        List<String> authoritys = new ArrayList<>();
        authorities.stream()
                .forEach(granted -> {
                    authoritys.add(granted.getAuthority());
                });
        return authoritys;
    }

}
