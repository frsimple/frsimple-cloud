package org.simple.grant.feign;


import cn.hutool.json.JSONObject;
import org.simple.common.utils.CommonResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(contextId = "feignPlanServer", value = "simple-plan")
public interface FeignPlanServer {

    @PostMapping("/inward/info")
    CommonResult info(@RequestBody JSONObject object);

}
