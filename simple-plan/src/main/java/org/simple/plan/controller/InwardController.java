package org.simple.plan.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.config.impl.WxMaDefaultConfigImpl;
import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import me.chanjar.weixin.common.error.WxErrorException;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.plan.entity.DesignUser;
import org.simple.plan.service.DesignUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;


/***
 * 内部feign调用专用controller
 * */
@RestController
@RequestMapping("/inward")
public class InwardController {

    @Autowired
    private DesignUserService designUserService;

    /**
     * 根据openid查询用户信息
     *
     * @return 用户信息
     */
    @PostMapping("/info")
    public CommonResult info(@RequestBody JSONObject object) {
        JSONObject jsonObject = new JSONObject();
        //先查询是否存在该用户，若不存在则进行新增操作
        String openid = "";
        String uniopenId = "";
        WxMaService wxMaService = null;
        wxMaService = new WxMaServiceImpl();
        WxMaDefaultConfigImpl wxMaConfig = new WxMaDefaultConfigImpl();
        wxMaConfig.setAppid("wxff8c8318bc2a5d4d");
        wxMaConfig.setSecret("7e87e012502bafa0e07ddcd009d777dd");
        wxMaService.setWxMaConfig(wxMaConfig);
        try {
            WxMaJscode2SessionResult jscode2session = wxMaService.jsCode2SessionInfo(object.getStr("authcode"));
            openid = jscode2session.getOpenid();
            uniopenId = jscode2session.getUnionid();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        //根据openid来查询微信用户信息
        DesignUser designUser = new DesignUser();
        designUser.setOpenid(openid);
        List<DesignUser> list =
                designUserService.list(Wrappers.query(designUser));
        if (list.size() == 0) {
            designUser.setId(RedomUtil.getWxUserid());
            designUser.setCreatedate(LocalDateTime.now());
            designUser.setName(object.getStr("username"));
            designUser.setAvatar(object.getStr("avatar"));
            designUser.setOutavatar(object.getStr("avatar"));
            designUser.setRemark("这家伙很懒什么都没有留下");
            designUser.setType("02");
            designUser.setStatus("0");
            designUser.setUniopenid(uniopenId);
            designUser.setHeart("0");
            designUser.setServiceArea("全国");
            designUserService.save(designUser);
            jsonObject.set("userid", designUser.getId());
            jsonObject.set("username", designUser.getName());
        } else {
            designUser = list.get(0);
            designUser.setAvatar(object.getStr("avatar"));
            //designUser.setName(object.getStr("username"));
            designUserService.updateById(designUser);
            jsonObject.set("userid", designUser.getId());
            jsonObject.set("username", designUser.getName());
        }
        return CommonResult.success(jsonObject);
    }

}
