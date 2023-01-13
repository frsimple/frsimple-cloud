package org.simple.grant.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.grant.entity.PermissionEntry;
import org.simple.grant.mapper.PermissionMapper;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class PermissionService extends ServiceImpl<PermissionMapper, PermissionEntry> {


    public List<PermissionEntry> getPermissionsByUserId(String userId){
        return baseMapper.selectPermissionsByUserId(userId);
    }

}
