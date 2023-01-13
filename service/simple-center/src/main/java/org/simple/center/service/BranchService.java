package org.simple.center.service;

import cn.hutool.core.lang.tree.Tree;
import com.baomidou.mybatisplus.extension.service.IService;
import org.simple.center.entity.Branch;

import java.util.List;


/**
 * @Copyright: simple <br/>
 * @Desc:  <br/>
 * @Date: 2022-08-03 21:47:58 <br/>
 * @Author: frsimple
 */
public interface BranchService extends IService<Branch>{

    public List<Tree<String>> queryOrganTree(String tenantName);

}