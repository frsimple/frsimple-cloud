package org.simple.plan.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaCodeLineColor;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.binarywang.wx.miniapp.config.impl.WxMaDefaultConfigImpl;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.api.R;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.error.WxErrorException;
import org.simple.common.constant.WxConstant;
import org.simple.common.storage.AliOss;
import org.simple.common.utils.ComUtil;
import org.simple.plan.entity.DesignUser;
import org.simple.plan.service.DesignUserService;
import org.simple.security.utils.AuthUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

/**
 * 用户信息表
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/designuser")
public class DesignUserController {

	private final DesignUserService designUserService;

	private final RedisTemplate redisTemplate;

	/**
	 * 分页列表
	 *
	 * @param page       分页对象
	 * @param designUser 用户信息表
	 * @return
	 */
	@GetMapping("/page")
	public R getPage(Page page, DesignUser designUser) {
		IPage<DesignUser> pages =
				designUserService.page(page, Wrappers.query(designUser));
		List<DesignUser> list =
				pages.getRecords();
		for (DesignUser user : list) {
			user.setPhone("");
		}
		pages.setRecords(list);
		return R.ok(pages);
	}

	/**
	 * 用户信息表查询
	 *
	 * @param id
	 * @return R
	 */
	@GetMapping("/{id}")
	public R getById(@PathVariable("id") String id) {
		return R.ok(designUserService.getById(id));
	}

	/**
	 * 用户信息表修改
	 *
	 * @param designUser 用户信息表
	 * @return R
	 */
	@PostMapping("/edit")
	public R updateById(@RequestParam(name = "file", required = false) MultipartFile mulFile, DesignUser designUser) {
		String userid = AuthUtils.getUser().getId();
		designUser.setId(userid);
		//处理头像图片
		if (null != mulFile) {
			String filePath = AliOss.getInstance(redisTemplate)
					.fileUpload(ComUtil.MultipartToFile(mulFile),false,"")
					.getData().toString();
			designUser.setOutavatar(filePath);
		}
		designUser.setStatus("1");
		designUserService.updateById(designUser);
		return R.ok(designUserService.getById(designUser.getId()));
	}


	/**
	 * 用户信息表修改
	 *
	 * @param designUser 用户信息表
	 * @return R
	 */
	@PostMapping("/edit1")
	public R updateById1(@RequestBody DesignUser designUser) {
		String userid = AuthUtils.getUser().getId();
		designUser.setId(userid);
		designUser.setStatus("1");
		designUserService.updateById(designUser);
		return R.ok(designUserService.getById(designUser.getId()));
	}

	/**
	 * 用户信息表查询
	 *
	 * @return R
	 */
	@GetMapping("/getUser")
	public R getById() {
		DesignUser designUser = designUserService.getById(AuthUtils.getUser().getId());
		return R.ok(designUser);
	}


	/**
	 * 解密微信小程序手机号
	 */
	@GetMapping("/decrypt")
	public R decrypt(@RequestParam("sessionKey") String sessionKey,
					 @RequestParam("encryptedData") String encryptedData,
					 @RequestParam("ivStr") String ivStr) {
		WxMaDefaultConfigImpl wxMaConfig = new WxMaDefaultConfigImpl();
		wxMaConfig.setAppid(WxConstant.APPID);
		wxMaConfig.setSecret(WxConstant.SECRET);
		WxMaService wxMaService = new WxMaServiceImpl();
		wxMaService.setWxMaConfig(wxMaConfig);
		String phoneNum = "";
		try {
			WxMaJscode2SessionResult jscode2session = wxMaService.jsCode2SessionInfo(sessionKey);
			String sessionk = jscode2session.getSessionKey();
			System.out.println(sessionk);
			WxMaPhoneNumberInfo wxMaPhoneNumberInfo
					= wxMaService.getUserService().getPhoneNoInfo(sessionk, encryptedData, ivStr);
			phoneNum = wxMaPhoneNumberInfo.getPhoneNumber();
		} catch (WxErrorException e) {
			e.printStackTrace();
		}
		return R.ok(phoneNum);
	}

	/**
	 * 作品图片上传
	 *
	 * @return R
	 */
	@PostMapping("/upload")
	public R updateById(@RequestParam(name = "file", required = true) MultipartFile mulFile) throws Exception {
		//处理头像图片
		String filePath = AliOss.getInstance(redisTemplate)
				.fileUpload(ComUtil.MultipartToFile(mulFile),false,"")
				.getData().toString();
		return R.ok(filePath);
	}


	/**
	 * 对外接口-查询用户信息
	 *
	 * @param id
	 * @return R
	 */
	@GetMapping("/api/{id}")
	public R apiUser(@PathVariable("id") String id) {
		return R.ok(designUserService.getById(id));
	}

	/**
	 * 获取小程序太阳码
	 *
	 * @return
	 */
	@GetMapping("/getImg")
	public void writeToServletFile(@RequestParam("path") String path, @RequestParam("scan") String scan,
								   HttpServletResponse resp) {
		try {
			WxMaService wxMaService = null;
			wxMaService = new WxMaServiceImpl();
			WxMaDefaultConfigImpl wxMaConfig = new WxMaDefaultConfigImpl();
			wxMaConfig.setAppid(WxConstant.APPID);
			wxMaConfig.setSecret(WxConstant.SECRET);
			wxMaService.setWxMaConfig(wxMaConfig);
			File fileImg = wxMaService.getQrcodeService()
					.createWxaCodeUnlimit
					(scan, path, false, "trial", 122, false,
							new WxMaCodeLineColor("0", "0", "0"), true);
			resp.setHeader("Content-Type", "image/jped");//图片流写回图片的src属性即可展示
			IoUtil.write(resp.getOutputStream(),true, FileUtil.readBytes(fileImg));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
