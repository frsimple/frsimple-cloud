package org.simple.center.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.simple.center.dto.LogsDto;
import org.simple.center.service.LogsService;
import org.simple.common.utils.CommonResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/logs")
@AllArgsConstructor
public class LogsController {

    private final LogsService logsService;

    @GetMapping("list")
    public CommonResult logsList(Page page, LogsDto logs){
       return CommonResult.success(logsService.logsList(page,logs));
    }

}
