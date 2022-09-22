package org.simple.plan.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.plan.entity.DesignOpus;
import org.simple.plan.entity.DesignSort;
import org.simple.plan.service.DesignOpusService;
import org.simple.plan.service.DesignSortService;
import org.simple.security.utils.AuthUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 分类表
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/designsort")
public class DesignSortController {

    private final DesignSortService designSortService;
	private final DesignOpusService designOpusService;

    /**
     * 分页列表
     * @param designSort 分类表
     * @return
     */
    @GetMapping("/page")
    public CommonResult getPage(DesignSort designSort) {
		designSort.setUserid(AuthUtils.getUser().getId());
        return CommonResult.success(designSortService.list(Wrappers.query(designSort)));
    }

	/**
	 * 查询用户所有分类信息
	 * @return
	 */
	@GetMapping("/api/{userid}")
	public CommonResult getPage(@PathVariable("userid") String userid) {
		DesignSort designSort = new DesignSort();
		designSort.setUserid(userid);
		return CommonResult.success(designSortService.list(Wrappers.query(designSort)));
	}

    /**
     * 分类表新增
     * @param designSort 分类表
     * @return R
     */
    @PostMapping("/add")
    public CommonResult save(@RequestBody DesignSort designSort) {
		designSort.setId(RedomUtil.getWxCataid());
		designSort.setCreatedate(LocalDateTime.now());
		designSort.setUserid(AuthUtils.getUser().getId());
        return CommonResult.success(designSortService.save(designSort));
    }

    /**
     * 分类表删除
     * @return R
     */
    @GetMapping("/delete")
    public CommonResult removeById(@RequestParam("value") String value) {
		DesignSort designSort  = new DesignSort();
		designSort.setUserid(AuthUtils.getUser().getId());
		designSort.setName(value);
		List<DesignSort> sortList =
		designSortService.list(Wrappers.query(designSort));
		if(sortList.size()==0){
			return CommonResult.failed("非法操作！");
		}else{
			designSort = sortList.get(0);
		}

		DesignOpus designOpus = new DesignOpus();
		designOpus.setSort(designSort.getId());
		designOpus.setUserid(AuthUtils.getUser().getId());
        List<DesignOpus> opusList =
				designOpusService.list(Wrappers.query(designOpus));
		if(opusList.size()!=0){
			return CommonResult.failed("有关联作品，请取消关联之后在进行删除！");
		}
        return CommonResult.success(designSortService.removeById(designSort.getId()));
    }

}
