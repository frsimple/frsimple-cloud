package org.simple.security.feign;

import org.simple.common.utils.CommonResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(contextId = "feignPlanServer", value = "simple-plan")
public interface FeignPlanServer {

    @GetMapping("/inward/user")
    CommonResult getInfo(@RequestParam(value = "username",required = false) String username);

}
