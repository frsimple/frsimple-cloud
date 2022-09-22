package org.simple.plan.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.api.R;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.simple.common.utils.RedomUtil;
import org.simple.plan.entity.DesignOpus;
import org.simple.plan.entity.DesignStar;
import org.simple.plan.entity.DesignUser;
import org.simple.plan.service.DesignOpusService;
import org.simple.plan.service.DesignStarService;
import org.simple.plan.service.DesignUserService;
import org.simple.security.utils.AuthUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 收藏作品关联表
 */
@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("/star")
public class DesignStarController {

    private final DesignStarService designStarService;
	private final DesignUserService designUserService;
	private final DesignOpusService designOpusService;

    /**
     * 查询我收藏的作品
     * @return
     */
    @GetMapping("/list")
    public R getPage() {
        return R.ok(designStarService.queryStarList());
    }

    /**
     * 收藏作品关联表查询
     * @param id
     * @return R
     */
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") String id) {
        return R.ok(designStarService.getById(id));
    }

    /**
     * 收藏作品关联表新增
     * @return R
     */
    @GetMapping("/add/{id}")
    public R save(@PathVariable String id) {
		//是否重复收藏
		DesignStar designStar1 = new DesignStar();
		designStar1.setOpusid(id);
		designStar1.setUserid(AuthUtils.getUser().getId());
		designStar1.setStatus("1");
		List<DesignStar> designStarList =
		designStarService.list(Wrappers.query(designStar1));
		if(designStarList.size() != 0){
			return R.failed("请勿重复收藏");
		}

		DesignStar designStar = new DesignStar();
		designStar.setStatus("1");
		designStar.setUserid(AuthUtils.getUser().getId());
		designStar.setId(RedomUtil.getWxStarid());
		designStar.setCreatedate(LocalDateTime.now());
		designStar.setOpusid(id);
		designStarService.save(designStar);

		//变更作品的收藏数量
		DesignOpus designOpus = designOpusService.getById(id);
		designOpus.setHeart(String.valueOf(Integer.valueOf(designOpus.getHeart())+1));
		designOpusService.updateById(designOpus);

		//变更用户的热度
		DesignUser designUser = designUserService.getById(AuthUtils.getUser().getId());
		designUser.setHeart(String.valueOf(Integer.valueOf(designUser.getHeart())+1));
		designUserService.updateById(designUser);
        return R.ok("收藏成功");
    }

    /**
     * 收藏作品关联表删除
     * @param id
     * @return R
     */
    @GetMapping("/del/{id}")
    public R removeById(@PathVariable String id) {
		//是否重复收藏
		DesignStar designStar1 = new DesignStar();
		designStar1.setOpusid(id);
		designStar1.setUserid(AuthUtils.getUser().getId());
		designStar1.setStatus("1");
		List<DesignStar> designStarList =
				designStarService.list(Wrappers.query(designStar1));
		if(designStarList.size() == 0){
			return R.failed("已取消收藏");
		}

		designStarService.removeById(designStarList.get(0).getId());

		//变更作品的收藏数量
		DesignOpus designOpus = designOpusService.getById(id);
		designOpus.setHeart(String.valueOf(Integer.valueOf(designOpus.getHeart())-1));
		designOpusService.updateById(designOpus);

		//变更用户的热度
		DesignUser designUser = designUserService.getById(AuthUtils.getUser().getId());
		designUser.setHeart(String.valueOf(Integer.valueOf(designUser.getHeart())-1));
		designUserService.updateById(designUser);
        return R.ok("取消收藏成功");
    }

}
