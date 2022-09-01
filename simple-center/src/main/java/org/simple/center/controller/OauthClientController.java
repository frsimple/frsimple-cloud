package org.simple.center.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.simple.center.entity.OauthClientDetails;
import org.simple.center.service.OauthClientService;
import org.simple.common.utils.CommonResult;
import org.simple.security.annotation.SimpleLog;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;

@RestController
@RequestMapping("/oauth")
@AllArgsConstructor
public class OauthClientController {

    private final OauthClientService oauthClientService;

    @GetMapping("list")
    @SimpleLog("查询客户端用户")
    @PreAuthorize("hasAnyAuthority('system:oauth:query')")
    public CommonResult list(Page page, OauthClientDetails oauthClientDetails){
        String clientId = oauthClientDetails.getClientId();
        oauthClientDetails.setClientId(null);
        return CommonResult.success(oauthClientService.page(page,
                Wrappers.query(oauthClientDetails).like("client_id",clientId)));
    }


    @PostMapping("addClient")
    @SimpleLog("新增客户端用户")
    @PreAuthorize("hasAnyAuthority('system:oauth:add')")
    public CommonResult addClient(@RequestBody OauthClientDetails oauthClientDetails){
        oauthClientDetails.setCreateTime(new Timestamp(new Date().getTime()));
        oauthClientDetails.setArchived(0);
        oauthClientDetails.setTrusted(0);
        oauthClientDetails.setAutoapprove("false");
        return CommonResult.success(oauthClientService.save(oauthClientDetails));
    }

    @PostMapping("editClient")
    @SimpleLog("修改客户端用户")
    @PreAuthorize("hasAnyAuthority('system:oauth:edit')")
    public CommonResult editClient(@RequestBody OauthClientDetails oauthClientDetails){
        oauthClientDetails.setCreateTime(new Timestamp(new Date().getTime()));
        return CommonResult.success(oauthClientService.updateById(oauthClientDetails));
    }

    @DeleteMapping("delClient")
    @SimpleLog("删除客户端用户")
    @PreAuthorize("hasAnyAuthority('system:oauth:del')")
    public CommonResult delClient(@RequestParam("clientId") String clientId){
        return CommonResult.success(oauthClientService.removeById(clientId));
    }

    @GetMapping("getClient/{id}")
    @SimpleLog("根据id查询客户端用户")
    @PreAuthorize("hasAnyAuthority('system:oauth:query')")
    public CommonResult getOne(@PathVariable("id") String clientId){
        return CommonResult.success(oauthClientService.getById(clientId));
    }

}
