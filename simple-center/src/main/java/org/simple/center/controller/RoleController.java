package org.simple.center.controller;


import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.simple.center.entity.Role;
import org.simple.center.entity.RoleMenu;
import org.simple.center.service.RoleService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.security.annotation.SimpleLog;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/role")
@AllArgsConstructor
public class RoleController {


    private final RoleService roleService;

    @GetMapping("list")
    @SimpleLog("查询角色列表")
    @PreAuthorize("hasAnyAuthority('system:role:query')")
    public CommonResult list(Page page, Role role){
        String r = StringUtils.isEmpty(role.getName()) ? "": role.getName();
        role.setName(null);
      return CommonResult.success(roleService.page(page, Wrappers.query(role).like("name",r)));
    }


    @PostMapping("addRole")
    @SimpleLog("新增角色信息")
    @PreAuthorize("hasAnyAuthority('system:role:add')")
    public CommonResult addRole(@RequestBody Role role){
        //清洗重新定义对象
        Role r = new Role();
        r.setId(RedomUtil.getRoleId());
        r.setCreatetime(LocalDateTime.now());
        r.setRemark(role.getRemark());
        r.setName(role.getName());
        r.setStatus("0");
        r.setType("01");
        roleService.save(r);
        return CommonResult.successNodata("新增成功");
    }

    @PostMapping("editRole")
    @SimpleLog("修改角色信息")
    @PreAuthorize("hasAnyAuthority('system:role:edit')")
    public CommonResult editRole(@RequestBody Role role){
        //清洗重新定义对象
        Role r = new Role();
        r.setId(role.getId());
        r.setRemark(role.getRemark());
        r.setName(role.getName());
        roleService.save(r);
        return CommonResult.successNodata("修改成功");
    }

    @DeleteMapping("delRole")
    @SimpleLog("删除角色信息")
    @PreAuthorize("hasAnyAuthority('system:role:del')")
    public CommonResult delRole(@RequestParam("id")String id){
        return roleService.delRole(id);
    }


    @GetMapping("roleMenu")
    @SimpleLog("查询角色列表")
    public CommonResult roleMenu(@RequestParam("role")String role){
        return roleService.queryRoleMenu(role);
    }

    @PostMapping("saveRoleMenu")
    @SimpleLog("保存角色菜单权限信息")
    @PreAuthorize("hasAnyAuthority('system:role:edit')")
    public CommonResult saveRoleMenu(@RequestBody RoleMenu roleMenu){
        return roleService.insertRoleMenus(roleMenu);
    }


}
