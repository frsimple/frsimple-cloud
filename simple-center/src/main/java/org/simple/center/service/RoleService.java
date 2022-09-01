package org.simple.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.simple.center.entity.Role;
import org.simple.center.entity.RoleMenu;
import org.simple.common.utils.CommonResult;

public interface RoleService extends IService<Role> {

    //删除角色
    CommonResult delRole(String id);

    CommonResult queryRoleMenu(String roleId);

    CommonResult insertRoleMenus(RoleMenu roleMenu);
}
