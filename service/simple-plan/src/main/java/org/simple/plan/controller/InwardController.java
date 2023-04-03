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

}
