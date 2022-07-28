package org.simple.grant.controller;


import cn.hutool.core.collection.CollectionUtil;
import org.apache.commons.lang.StringUtils;
import org.simple.common.utils.CommonResult;
import org.simple.grant.dto.TokenDto;
import org.simple.grant.dto.TokenParams;
import org.simple.grant.entity.UserEntity;
import org.simple.grant.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.token.ConsumerTokenServices;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/sp")
public class AuthController {

    @Autowired
    private TokenStore tokenStore;

    @Autowired
    @Qualifier("consumerTokenServices")
    private ConsumerTokenServices consumerTokenServices;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private UserService userService;


    /**
     * 退出登录
     * */
    @GetMapping("logout")
    public CommonResult logout(@RequestHeader(HttpHeaders.AUTHORIZATION)String token){
        token = token.replace("Bearer ","");
        token = token.replace("bearer ","");
        OAuth2AccessToken oAuth2AccessToken = tokenStore.readAccessToken(token);
        if(null != oAuth2AccessToken){
            consumerTokenServices.revokeToken(token);
        }
//        else{
//            return CommonResult.failed("错误的token");
//        }
        return CommonResult.successNodata("退出登录成功");
    }


    @GetMapping("list")
    public CommonResult tokenList(TokenParams tokenDto){
        Set<String> keys = redisTemplate.keys("simple:auth:token:auth:*");
        List<String> list = new ArrayList<>(keys);
        if(CollectionUtil.isNotEmpty(list)){
            Integer start = tokenDto.getSize() * (tokenDto.getCurrent() - 1);
            Integer end = tokenDto.getSize() * tokenDto.getCurrent();
            if(list.size() >= end || (list.size() >= start && list.size()<end)){
                List<TokenDto> tokenList = new ArrayList<>();
                for(int i = start ;i < end ; i++){
                    if(i >= list.size()){
                        break;
                    }
                    TokenDto t = new TokenDto();
                    String token = list.get(i).replace("simple:auth:token:auth:","");
                    OAuth2AccessToken oAuth2AccessToken = tokenStore.readAccessToken(token);
                    Integer  expires = oAuth2AccessToken.getExpiresIn();
                    Map<String,Object> info = oAuth2AccessToken.getAdditionalInformation();
                    UserEntity user = userService.getById(info.get("id").toString());
                    t.setNickname(user.getNickname());
                    t.setUsername(user.getUsername());
                    t.setTiems(String.valueOf(expires));
                    t.setLoginDate(userService.getLoginDate(info.get("id").toString()));
                    t.setToken(token);
                    t.setClientId(info.get("clientId").toString());
                    t.setTenantId(info.get("tenantId").toString());
                    if(StringUtils.isNotEmpty(tokenDto.getName())){
                        if(t.getUsername().indexOf(tokenDto.getName()) >= 0 ||
                                t.getNickname().indexOf(tokenDto.getName()) >= 0){
                            tokenList.add(t);
                        }
                    }else{
                        tokenList.add(t);
                    }
                }
                tokenDto.setTotal(tokenList.size());
                tokenDto.setTokenDtos(tokenList);
            }else{
                tokenDto.setTotal(list.size());
                tokenDto.setTokenDtos(new ArrayList<>());
            }
        }else{
            tokenDto.setTotal(0);
            tokenDto.setTokenDtos(new ArrayList<>());
        }
        return CommonResult.success(tokenDto);
    }


    /**
     * 踢人下线
     * */
    @GetMapping("userLogout")
    public CommonResult userLogout(@RequestParam("token")String token){
        OAuth2AccessToken oAuth2AccessToken = tokenStore.readAccessToken(token);
        if(null != oAuth2AccessToken){
            consumerTokenServices.revokeToken(token);
        }
//        else{
//            return CommonResult.failed("错误的token");
//        }
        return CommonResult.successNodata("操作成功");
    }


}
