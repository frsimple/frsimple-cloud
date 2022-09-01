package org.simple.center.service.impl;

import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNodeConfig;
import cn.hutool.core.lang.tree.TreeUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.simple.center.dto.OrganTreeDto;
import org.simple.center.entity.Branch;
import org.simple.center.mapper.BranchMapper;
import org.simple.center.service.BranchService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Copyright: simple <br/>
 * @Desc: <br/>
 * @Date: 2022-08-03 21:47:58 <br/>
 * @Author: frsimple
 */


@Service
public class BranchServiceImpl
        extends ServiceImpl<BranchMapper, Branch>
        implements BranchService {

    @Override
    public List<Tree<String>> queryOrganTree(String tenantId) {
        List<OrganTreeDto> treeDtoList = new ArrayList<>();
        if (StringUtils.isEmpty(tenantId)) {
            treeDtoList = baseMapper.queryOrganTree();
        } else {
            treeDtoList = baseMapper.queryOrganTreeByName(tenantId);
        }
        TreeNodeConfig config = new TreeNodeConfig();
        config.setWeightKey("sort");
        List<Tree<String>> treeNodes = TreeUtil.build(treeDtoList, "0", config,
                (object, tree) -> {
                    tree.setName(object.getName());
                    tree.setId(object.getId());
                    tree.setParentId(object.getParentid());
                    tree.setWeight(StringUtils.isEmpty(object.getSort()) ? 0 : Integer.valueOf(object.getSort()));
                    tree.putExtra("createtime", object.getCreatetime());
                    tree.putExtra("tenantname", object.getTenantname());
                    tree.putExtra("tenantid", object.getTenantid());
                    tree.putExtra("parentname", object.getParentname());
                });
        return treeNodes;
    }
}