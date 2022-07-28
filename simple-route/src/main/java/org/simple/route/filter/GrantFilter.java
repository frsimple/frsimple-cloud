package org.simple.route.filter;

import cn.hutool.core.util.CharsetUtil;
import cn.hutool.crypto.symmetric.SymmetricAlgorithm;
import cn.hutool.crypto.symmetric.SymmetricCrypto;
import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.simple.common.constant.RedisConstant;
import org.simple.common.utils.CommonResult;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.util.UriComponentsBuilder;
import reactor.core.publisher.Mono;

import javax.annotation.Resource;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

@Component
public class GrantFilter extends AbstractGatewayFilterFactory {


    @Resource
    private RedisTemplate redisTemplate;

    private String KEY = "L3u8/dQQDSz3ilOdw0XTJaxbuqFX/qtaZGhcXuKRuw8=";

    private Mono<Void> buildReturnMono(JSONObject json, ServerWebExchange exchange) {
        byte[] bits = json.toJSONString().getBytes(StandardCharsets.UTF_8);
        DataBuffer buffer = exchange.getResponse().bufferFactory().wrap(bits);
        exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
        //指定编码，否则在浏览器中会中文乱码
        exchange.getResponse().getHeaders().add(
                "Content-Type", "text/plain;charset=UTF-8");
        return exchange.getResponse().writeWith(Mono.just(buffer));
    }

//    public static void main(String[] args) throws NoSuchAlgorithmException {
//           System.out.println(encrypt("simple_simple","L3u8/dQQDSz3ilOdw0XTJaxbuqFX/qtaZGhcXuKRuw8="));
//    }

    private static  Map<String,String>  encrypt(String content,String key) throws NoSuchAlgorithmException {
        Map<String,String> result = new HashMap<>();
        if(StringUtils.isEmpty(key)){
            // 随机生成密钥
            KeyGenerator kg = KeyGenerator.getInstance("AES");
            //下面调用方法的参数决定了生成密钥的长度，可以修改为128, 192或256
            kg.init(256);
            SecretKey sk = kg.generateKey();
            byte[] b = sk.getEncoded();
            key = Base64.encodeBase64String(b);
        }
        SymmetricCrypto aes = new SymmetricCrypto(SymmetricAlgorithm.AES, Base64.decodeBase64(key));
        String encryptHex = aes.encryptHex(content);
        result.put("key",key);
        result.put("encrypt",encryptHex);
        System.out.println("加密串:"+encryptHex);
        return result;
    }
    private  Map<String,String> decrypt(String encrypt) throws Exception {
        SymmetricCrypto aes = new SymmetricCrypto(SymmetricAlgorithm.AES, Base64.decodeBase64(
                this.KEY
        ));
        Map<String,String> result = new HashMap<>();
        String str = aes.decryptStr(encrypt, CharsetUtil.CHARSET_UTF_8);
        if(StringUtils.isEmpty(str) || str.indexOf("_") ==  -1 ){
            throw new Exception("授权信息错误");
        }
        String[] clientInfo = str.split("_");
        result.put("client_id",clientInfo[0]);
        result.put("client_secret",clientInfo[1]);
        return result;
    }

    @Override
    public GatewayFilter apply(Object config) {
        return (exchange, chain) -> {
            String requestUrl = exchange.getRequest().getPath().value();
            //grant_type为password登录需要验证码
            if (requestUrl.equals("/oauth/token")) {
                ServerHttpRequest request = exchange.getRequest();
                String grantType = request.getHeaders().getFirst("grant_type");
                if (StringUtils.isEmpty(grantType)) {
                    return buildReturnMono(JSONObject.parseObject(
                            JSON.toJSONString(CommonResult.failed("grant_type不能为空"))), exchange);
                }
                if (grantType.equals("password")) {
                    String code = request.getQueryParams().getFirst("code");
                    if (StringUtils.isEmpty(code)) {
                        return buildReturnMono(JSONObject.parseObject(
                                JSON.toJSONString(CommonResult.failed("验证码不能为空"))), exchange);
                    }
                    String sp = String.valueOf(request.getQueryParams().getFirst("sp"));
                    Object  redisCode  =  redisTemplate.opsForValue().get(RedisConstant.CODE_STR+sp);
                    if(null == redisCode){
                        return buildReturnMono(JSONObject.parseObject(
                                JSON.toJSONString(CommonResult.failed("验证码错误"))), exchange);
                    }
                    if(!code.equals(redisCode)){
                        redisTemplate.delete(RedisConstant.CODE_STR+sp);
                        return buildReturnMono(JSONObject.parseObject(
                                JSON.toJSONString(CommonResult.failed("验证码错误"))), exchange);
                    }
                    //验证通过之后删除验证码
                    redisTemplate.delete(RedisConstant.CODE_STR+sp);
                }
                if (grantType.equals("sms_code")) {
                    String code = request.getQueryParams().getFirst("code");
                    if (StringUtils.isEmpty(code)) {
                        return buildReturnMono(JSONObject.parseObject(
                                JSON.toJSONString(CommonResult.failed("验证码不能为空"))), exchange);
                    }
                    String phone = String.valueOf(request.getQueryParams().getFirst("phone"));
                    Object  redisCode  =  redisTemplate.opsForValue().get(RedisConstant.PHONE_CODE_STR+phone);
                    if(null == redisCode){
                        return buildReturnMono(JSONObject.parseObject(
                                JSON.toJSONString(CommonResult.failed("验证码错误"))), exchange);
                    }
                    if(!code.equals(redisCode)){
                        redisTemplate.delete(RedisConstant.CODE_STR+phone);
                        return buildReturnMono(JSONObject.parseObject(
                                JSON.toJSONString(CommonResult.failed("验证码错误"))), exchange);
                    }
                    //验证通过之后删除验证码
                    redisTemplate.delete(RedisConstant.CODE_STR+phone);
                }
                //将请求头的参数进行解密
                String secret = request.getHeaders().getFirst("sp");
                if(StringUtils.isEmpty(secret)){
                    return buildReturnMono(JSONObject.parseObject(
                            JSON.toJSONString(CommonResult.failed("授权参数不能为空"))), exchange);
                }
                //删掉header中的grand_type
                request.mutate().headers(httpHeaders -> {
                    httpHeaders.remove("grant_type");
                    httpHeaders.remove("sp");
                    httpHeaders.remove("Authorization");
                });
                // 以反射的形式将grant_type,client_id,client_secret存储到params中
                Map<String,String> clientInfo = new HashMap<>();
            try {
                 clientInfo = decrypt(secret);
            } catch (Exception ex) {
                return buildReturnMono(JSONObject.parseObject(
                        JSON.toJSONString(CommonResult.failed(ex.getMessage()))), exchange);
            }
                URI uri = exchange.getRequest().getURI();
                String queryParam = uri.getRawQuery();
                Map<String, String> paramMap = HttpUtil.decodeParamMap(queryParam,CharsetUtil.CHARSET_UTF_8);
                paramMap.put("grant_type",grantType);
                paramMap.put("client_id",clientInfo.get("client_id"));
                paramMap.put("client_secret",clientInfo.get("client_secret"));
                return chain.filter(exchange.mutate().request(
                        request.mutate().uri(UriComponentsBuilder.fromUri(uri)
                                .replaceQuery(HttpUtil.toParams(paramMap))
                                .build(true)
                                .toUri()).build()
                ).build());
            }
            return chain.filter(exchange);
        };
    }
}
