package org.simple.center.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.simple.center.entity.Tenant;
import org.simple.center.service.TenantService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.security.annotation.SimpleLog;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/tenant")
@AllArgsConstructor
public class TenantController {

    private final TenantService tenantService;

    @GetMapping("list")
    @SimpleLog("查询机构信息列表")
    @PreAuthorize("hasAnyAuthority('system:tenant:query')")
    public CommonResult list(Page page, Tenant tenant){
        String  name = "";
        if(StringUtils.isNotEmpty(tenant.getName())){
            name = tenant.getName();
        }
        tenant.setName(null);
      return CommonResult.success(tenantService.page(page, Wrappers.query(tenant).like("name",name)));
    }

    @GetMapping("getTenant")
    @SimpleLog("根据名称查询机构")
    @PreAuthorize("hasAnyAuthority('system:tenant:query')")
    public CommonResult  getOne(@RequestParam("name")String name){
        Tenant tenant = new Tenant();
        tenant.setName(name);
        return CommonResult.success(tenantService.list(Wrappers.query(tenant)));
    }

    @PostMapping("addTenant")
    @SimpleLog("新增机构信息")
    @PreAuthorize("hasAnyAuthority('system:tenant:add')")
    public CommonResult addTenant(@RequestBody Tenant tenant){
        tenant.setId(RedomUtil.getTenantId());
        tenant.setCreatedate(LocalDateTime.now());
        tenant.setUpdatedate(LocalDateTime.now());
        tenantService.save(tenant);
        return CommonResult.successNodata("新增成功");
    }

    @PostMapping("editTenant")
    @SimpleLog("修改机构信息")
    @PreAuthorize("hasAnyAuthority('system:tenant:edit')")
    public CommonResult editTenant(@RequestBody Tenant tenant){
        tenant.setUpdatedate(LocalDateTime.now());
        tenantService.updateById(tenant);
        return CommonResult.successNodata("修改成功");
    }

    @DeleteMapping("delTenant/{id}")
    @SimpleLog("删除机构信息")
    @PreAuthorize("hasAnyAuthority('system:tenant:del')")
    public CommonResult delTenant(@PathVariable("id") String  id){
        //判断机构下面是否关联的有用户
        Integer count =  tenantService.selectCount(id);
        if(count != 0){
            return CommonResult.failed("存在关联的用户，请先取消关联");
        }
        tenantService.removeById(id);
        return CommonResult.successNodata("删除成功");
    }

}
