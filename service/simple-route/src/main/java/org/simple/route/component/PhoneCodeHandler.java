package org.simple.route.component;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSONObject;
import org.simple.common.constant.RedisConstant;
import org.simple.common.sms.SmsUtil;
import org.simple.common.utils.CommonResult;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import javax.annotation.Resource;
import java.util.concurrent.TimeUnit;

@Component
public class PhoneCodeHandler implements HandlerFunction<ServerResponse> {

    @Resource
    private RedisTemplate redisTemplate;

    @Override
    public Mono<ServerResponse> handle(ServerRequest serverRequest) {
        String spStr = serverRequest.queryParam("sp").get();
        String key = RedisConstant.PHONE_CODE_STR + spStr;
        //校验是否发送过短信以免重复发送60秒只能发送一次
        if (redisTemplate.hasKey(key)) {
            Long seconds = redisTemplate.opsForValue().getOperations().getExpire(key);
            if (seconds > 0) {
                return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON)
                        .body(BodyInserters.fromValue(JSONUtil.toJsonStr(CommonResult.failed("已获取过短信，请等待"+seconds+"秒之后在获取"))));
            }
        }
        //获取四位随机数字
        String rom = RandomUtil.randomNumbers(4);
        //调用阿里云短信接口发送短信
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",rom);
        try {
//            CommonResult result = SmsUtil.getAliSms(redisTemplate).sendAsyncSms(
//                    null,new String[]{spStr},"SMS_207760664",jsonObject
//            );
            CommonResult result = SmsUtil.getTencentSms(redisTemplate).sendSms(null,"865723",
                    new String[]{rom},new String[]{spStr});
            if(result.getCode() == 1){
                return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON)
                        .body(BodyInserters.fromValue(JSONUtil.toJsonStr(result)));
            }
        } catch (Exception e) {
            return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON)
                    .body(BodyInserters.fromValue(JSONUtil.toJsonStr(CommonResult.failed("发送失败:"+e.getMessage()))));
        }

        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.opsForValue().set( RedisConstant.PHONE_CODE_STR + spStr, rom
                , RedisConstant.CODE_TIMEOUT, TimeUnit.SECONDS);
        return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON)
                .body(BodyInserters.fromValue(JSONUtil.toJsonStr(CommonResult.successNodata("短信已发送"))));
    }
}
