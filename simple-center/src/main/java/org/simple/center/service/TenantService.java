package org.simple.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.simple.center.entity.Tenant;

public interface TenantService extends IService<Tenant> {

    Integer  selectCount(String id);
}
