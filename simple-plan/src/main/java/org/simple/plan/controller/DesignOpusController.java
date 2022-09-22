package org.simple.plan.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.simple.common.utils.CommonResult;
import org.simple.plan.entity.DesignOpus;
import org.simple.plan.entity.DesignUser;
import org.simple.plan.service.DesignOpusService;
import org.simple.plan.service.DesignUserService;
import org.simple.security.utils.AuthUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * 作品设计表
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/opus")
public class DesignOpusController {

    private final DesignOpusService designOpusService;
	private final DesignUserService designUserService;

    /**
     * 分页列表
     * @param page 分页对象
     * @param designOpus 作品设计表
     * @return
     */
    @GetMapping("/page")
    public CommonResult getPage(Page page, DesignOpus designOpus) {
		designOpus.setUserid(AuthUtils.getUser().getId());
        return CommonResult.success(designOpusService.page(page, Wrappers.query(designOpus)));
    }

    /**
     * 作品设计表查询
     * @param id
     * @return R
     */
    @GetMapping("/{id}")
    public CommonResult getById(@PathVariable("id") String id) {
		DesignOpus designOpus = designOpusService.getById(id);
		if(!designOpus.getUserid().equals(AuthUtils.getUser().getId())){
			return CommonResult.failed("非法操作");
		}
        return CommonResult.success(designOpus);
    }

    /**
     * 作品设计表新增
     * @param designOpus 作品设计表
     * @return R
     */
    @PostMapping("/add")
    public CommonResult save(@RequestBody DesignOpus designOpus) {
		designOpus.setUpdatedate(LocalDateTime.now());
		designOpus.setUserid(AuthUtils.getUser().getId());
		designOpus.setLook("0");
		designOpus.setHeart("0");
		designOpus.setStatus("00");  //待发布
        return CommonResult.success(designOpusService.save(designOpus));
    }

    /**
     * 作品设计表修改
     * @param designOpus 作品设计表
     * @return R
     */
    @PostMapping("/edit")
    public CommonResult updateById(@RequestBody DesignOpus designOpus) {
        return CommonResult.success(designOpusService.updateById(designOpus));
    }

    /**
     * 作品设计表删除
     * @param id
     * @return R
     */
    @DeleteMapping("/{id}")
    public CommonResult removeById(@PathVariable String id) {
        return CommonResult.success(designOpusService.removeById(id));
    }


	/**
	 * 发布作品
	 * @param id 作品id
	 * @return
	 */
	@GetMapping("/open/{id}")
	public CommonResult open(@PathVariable("id")String id) {
		DesignOpus designOpus =
				designOpusService.getById(id);
		if(null == designOpus ||!designOpus.getUserid().equals(AuthUtils.getUser().getId())){
			return CommonResult.failed("非法操作");
		}
		designOpus.setStatus("99");
		return CommonResult.success(designOpusService.updateById(designOpus));
	}

	/**
	 * 下架作品
	 * @param id 作品id
	 * @return
	 */
	@GetMapping("/close/{id}")
	public CommonResult close(@PathVariable("id")String id) {
		DesignOpus designOpus =
				designOpusService.getById(id);
		if(null == designOpus ||!designOpus.getUserid().equals(AuthUtils.getUser().getId())){
			return CommonResult.failed("非法操作");
		}
		designOpus.setStatus("00");
		return CommonResult.success(designOpusService.updateById(designOpus));
	}

	/**
	 * 对外接口-查询产品信息
	 * @param id
	 * @return R
	 */
	@GetMapping("/api/{id}")
	public CommonResult apiOpus(@PathVariable("id") String id) {
		DesignOpus designOpus = designOpusService.getById(id);
		if(designOpus.getStatus().equals("99")){
			return CommonResult.success(designOpus);
		}else{
			return CommonResult.success("");
		}
	}

	/**
	 * 查询所有作品
	 * @param designOpus 作品设计表
	 * @return
	 */
	@GetMapping("/api/page")
	public CommonResult getPage(DesignOpus designOpus) {
		return CommonResult.success(designOpusService.list(Wrappers.query(designOpus)));
	}


	/**
	 * 对外接口-增加设计作品访问量
	 * @param id
	 * @return R
	 */
	@GetMapping("/api/look/{id}")
	public CommonResult apiLookOpus(@PathVariable("id") String id) {
		DesignOpus designOpus = designOpusService.getById(id);
		if(null == designOpus){
			return CommonResult.failed("非法请求");
		}
		designOpus.setLook(String.valueOf(Integer.valueOf(designOpus.getLook())+1));
		designOpusService.updateById(designOpus);

		//更新设计师热度
		DesignUser designUser = designUserService.getById(designOpus.getUserid());
		designUser.setHeart(String.valueOf(Integer.valueOf(designUser.getHeart())+1));
		designUserService.updateById(designUser);
		return CommonResult.success("");
	}
}
