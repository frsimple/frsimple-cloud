package org.simple.center.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.simple.center.entity.Branch;
import org.simple.center.service.BranchService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.security.annotation.SimpleLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * @Copyright: simple <br/>
 * @Desc:  <br/>
 * @Date: 2022-08-03 21:47:58 <br/>
 * @Author: frsimple <br/>
 */

@RestController
@RequestMapping("/branch")
public class BranchController {

    @Autowired
    private BranchService branchService;


    @GetMapping("queryOrganTree")
    @SimpleLog("查询组织机构树形列表")
    @PreAuthorize("hasAnyAuthority('system:organ:query')")
    public CommonResult queryOrganTree(@RequestParam(required = false,name = "tenantId")String tenantId){
        return CommonResult.success(branchService.queryOrganTree(tenantId));
    }


    @PostMapping("editOrgan")
    @SimpleLog("修改组织机构信息")
    @PreAuthorize("hasAnyAuthority('system:organ:edit')")
    public CommonResult editOrgan(@RequestBody Branch branch){
        return CommonResult.success(branchService.updateById(branch));
    }

    @PostMapping("addOrgan")
    @SimpleLog("新增组织机构信息")
    @PreAuthorize("hasAnyAuthority('system:organ:add')")
    public CommonResult addOrgan(@RequestBody Branch branch){
        branch.setId(RedomUtil.getOrganId());
        branch.setCreatetime(LocalDateTime.now());
        return CommonResult.success(branchService.save(branch));
    }


    @DeleteMapping("delOrgan/{id}")
    @SimpleLog("新增组织机构信息")
    @PreAuthorize("hasAnyAuthority('system:organ:del')")
    public CommonResult delOrgan(@PathVariable("id")String id){
        Branch branch =new Branch();
        branch.setParentid(id);
        if(branchService.list(Wrappers.query(branch)).size() != 0){
            return CommonResult.failed("存在关联的下级组织，请先删除所有下级组织");
        }
        return CommonResult.success(branchService.removeById(id));
    }

    @DeleteMapping("getOrgan")
    @SimpleLog("新增组织机构信息")
    @PreAuthorize("hasAnyAuthority('system:organ:query')")
    public CommonResult getOrgan(@RequestParam("id")String id){
        return CommonResult.success(branchService.getById(id));
    }


}