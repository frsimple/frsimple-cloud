package org.simple.plan.controller;

import org.simple.common.utils.CommonResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


/***
 * 内部feign调用专用controller
 * */
@RestController
@RequestMapping("/inward")
public class InwardController {

    @GetMapping("/user")
    public CommonResult getInfo(@RequestParam(value = "username",required = false)String username){
        return CommonResult.success("feign调用成功:"+username);
    }

    @GetMapping("/user1")
    public CommonResult getInfo1(@RequestParam(value = "username",required = false)String username){
        return CommonResult.success("feign调用成功:"+username);
    }

}
