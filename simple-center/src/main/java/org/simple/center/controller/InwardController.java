package org.simple.center.controller;


import cn.hutool.core.bean.BeanUtil;
import lombok.AllArgsConstructor;
import org.simple.center.entity.Logs;
import org.simple.center.service.LogsService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/inward")
@AllArgsConstructor
public class InwardController {

    private final LogsService centerLogsService;

    @PostMapping("saveLogs")
    public CommonResult saveSimpleLog(@RequestBody org.simple.common.dto.Logs centerLogs) {
        Logs log = new Logs();
        BeanUtil.copyProperties(centerLogs,log);
        System.out.println("-----全局日志处理start------");
        log.setId(RedomUtil.getLogsId());
        log.setCreatetime(LocalDateTime.now());
        centerLogsService.save(log);
        System.out.println("-----全局日志处理end------");
        return CommonResult.success("成功");
    }

}
