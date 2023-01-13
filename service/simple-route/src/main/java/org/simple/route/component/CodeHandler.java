package org.simple.route.component;

import com.wf.captcha.ArithmeticCaptcha;
import org.simple.common.constant.RedisConstant;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.FastByteArrayOutputStream;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import javax.annotation.Resource;
import java.util.concurrent.TimeUnit;

@Component
public class CodeHandler implements HandlerFunction<ServerResponse> {

    @Resource
    private RedisTemplate redisTemplate;

    @Override
    public Mono<ServerResponse> handle(ServerRequest serverRequest) {
        //生成验证码
        ArithmeticCaptcha captcha = new ArithmeticCaptcha(111, 36);
        captcha.setLen(2);
        String result ="";
        try {
            result = new Double(Double.parseDouble(captcha.text())).intValue()+"";
        }catch (Exception e){
            result = captcha.text();
        }
        //存储验证码到reids中
        String spStr = serverRequest.queryParam("sp").get();
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.opsForValue().set( RedisConstant.CODE_STR + spStr, result
                , RedisConstant.CODE_TIMEOUT, TimeUnit.SECONDS);
        FastByteArrayOutputStream os = new FastByteArrayOutputStream();
        captcha.out(os);
        os.close();
        return ServerResponse
                .status(HttpStatus.OK)
                .contentType(MediaType.IMAGE_JPEG)
                .body(BodyInserters.fromResource(new ByteArrayResource(os.toByteArray())));
    }
}
