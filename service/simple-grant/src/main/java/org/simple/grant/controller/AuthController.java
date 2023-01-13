package org.simple.grant.controller;


import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaCodeLineColor;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.config.impl.WxMaDefaultConfigImpl;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import me.chanjar.weixin.common.error.WxErrorException;
import org.apache.commons.lang.StringUtils;
import org.simple.common.constant.WxConstant;
import org.simple.common.utils.CommonResult;
import org.simple.grant.dto.TokenDto;
import org.simple.grant.dto.TokenParams;
import org.simple.grant.entity.UserEntity;
import org.simple.grant.entity.WqrCode;
import org.simple.grant.service.UserService;
import org.simple.grant.service.WqrCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.token.ConsumerTokenServices;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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

    @Autowired
    private WqrCodeService wqrCodeService;


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


    @GetMapping("getWeChat")
    public void getWeChatImg(@RequestParam("code") String code, HttpServletResponse req) throws WxErrorException, IOException {
        //生成授权码
        //String code = RedomUtil.getQrcode();
        //调用微信接口生成微信小程序二维码
        WxMaService wxService = new WxMaServiceImpl();
        WxMaDefaultConfigImpl wxMaDefaultConfig = new WxMaDefaultConfigImpl();
        wxMaDefaultConfig.setAppid(WxConstant.APPID);
        wxMaDefaultConfig.setSecret(WxConstant.SECRET);
        wxService.setWxMaConfig(wxMaDefaultConfig);
        byte[] img = wxService.getQrcodeService().createWxaCodeUnlimitBytes
                (code, "pages/index", false, "trial", 122, false,
                        new WxMaCodeLineColor("0", "0", "0"), true);

        //生成临时授权码记录到数据库
        WqrCode wqrCode = new WqrCode();
        wqrCode.setId(code);
        wqrCode.setCreatetime(LocalDateTime.now());
        wqrCode.setStatus("0");
        wqrCode.setCode(code);
        wqrCodeService.save(wqrCode);

        //redisTemplate.opsForValue().set(code+"_status","0");

        req.setHeader("Content-type", "image/jped");
        IoUtil.write(req.getOutputStream(), true, img);
    }

    @GetMapping("queryIsScan")
    public CommonResult queryIsScan(@RequestParam("code")String code){
        WqrCode wqrCode = wqrCodeService.getById(code);
        if(null == wqrCode){
            return CommonResult.failed("非法操作");
        }
        if(wqrCode.getStatus().equals("0")){
            return CommonResult.failed("未扫描");
        }
        return CommonResult.successNodata("已经扫描");
    }

    @GetMapping("timeOutScan")
    public CommonResult timeOutScan(@RequestParam("code")String code){
        WqrCode wqrCode = wqrCodeService.getById(code);
        if(null == wqrCode){
            return CommonResult.failed("非法操作");
        }
        wqrCode.setStatus("-1");
        wqrCodeService.updateById(wqrCode);
        return CommonResult.successNodata("验证码过期作废成功");
    }


    @GetMapping("confirmIsLogin")
    public CommonResult confirmIsLogin(@RequestParam("code")String code){
        WqrCode wqrCode = wqrCodeService.getById(code);
        if(null == wqrCode){
            return CommonResult.failed("非法操作");
        }
        long secouds =  ChronoUnit.SECONDS.between(wqrCode.getQrtime(),LocalDateTime.now());
        if(secouds >= 300){
            return CommonResult.success("-1");
        }
        if(StringUtils.isEmpty(wqrCode.getOpt())){
            return CommonResult.failed("未操作");
        }
        return CommonResult.success(wqrCode.getOpt());
    }

    /**
     * 用户在用微信扫码
     * */
    @GetMapping("wechatScan")
    public CommonResult loginByWechat(@RequestParam("authCode") String authCode,
                                      @RequestParam("code") String code) throws WxErrorException {
        WqrCode wqrCode = wqrCodeService.getById(code);
        if (null == wqrCode) {
            return CommonResult.failed("非法请求");
        }
        if(!wqrCode.getStatus().equals("0")){
            return CommonResult.failed("二维码已使用，请重新获取");
        }
        WxMaService wxMaService = null;
        wxMaService = new WxMaServiceImpl();
        WxMaDefaultConfigImpl wxMaConfig = new WxMaDefaultConfigImpl();
        wxMaConfig.setAppid(WxConstant.APPID);
        wxMaConfig.setSecret(WxConstant.SECRET);
        wxMaService.setWxMaConfig(wxMaConfig);
        WxMaJscode2SessionResult jscode2session =
                wxMaService.jsCode2SessionInfo(authCode);
        String openid = jscode2session.getOpenid();
        wqrCode.setOpenid(openid);
        wqrCode.setQrtime(LocalDateTime.now());
        wqrCode.setStatus("1");
        wqrCodeService.updateById(wqrCode);
        //String uniopenId = jscode2session.getUnionid();
        return CommonResult.successNodata("二维码扫码成功");
    }


    /**
     * 用户在小程序中确定登录操作
     * */
    @GetMapping("wechatLoginConfirm")
    public CommonResult loginByWechat(@RequestParam("authCode") String authCode,
                                      @RequestParam("code") String code,
                                      @RequestParam("opt")String opt) throws WxErrorException {
        WqrCode wqrCode = new WqrCode();
        wqrCode.setCode(code);
                //wqrCodeService.getById(code);
        //获取openid
        WxMaService wxMaService = null;
        wxMaService = new WxMaServiceImpl();
        WxMaDefaultConfigImpl wxMaConfig = new WxMaDefaultConfigImpl();
        wxMaConfig.setAppid(WxConstant.APPID);
        wxMaConfig.setSecret(WxConstant.SECRET);
        wxMaService.setWxMaConfig(wxMaConfig);
        WxMaJscode2SessionResult jscode2session =
                wxMaService.jsCode2SessionInfo(authCode);
        String openid = jscode2session.getOpenid();
        wqrCode.setOpenid(openid);
        List<WqrCode> list = wqrCodeService.list(Wrappers.query(wqrCode));
        if (list.size()==0) {
            return CommonResult.failed("非法请求");
        }
        wqrCode = list.get(0);
        if(!wqrCode.getStatus().equals("1")){
            return CommonResult.failed("还未进行扫码操作");
        }
        if(StringUtils.isNotEmpty(wqrCode.getOpt())){
            return CommonResult.failed("二维码已使用，请重新获取");
        }
        wqrCode.setOpt(opt);
        wqrCodeService.updateById(wqrCode);
        //String uniopenId = jscode2session.getUnionid();
        return CommonResult.successNodata("登录操作成功");
    }

}
