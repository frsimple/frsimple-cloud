package org.simple.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.entity.Tenant;
import org.simple.center.mapper.TenantMapper;
import org.simple.center.service.TenantService;
import org.springframework.stereotype.Service;

@Service
public class TenantServiceImpl
        extends ServiceImpl<TenantMapper, Tenant>
        implements TenantService {
    @Override
    public Integer selectCount(String id) {
        return baseMapper.selectCount(id);
    }
}
