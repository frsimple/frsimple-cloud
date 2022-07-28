package org.simple.center.service.impl;

import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNodeConfig;
import cn.hutool.core.lang.tree.TreeUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.simple.center.dto.UserDto;
import org.simple.center.entity.Menu;
import org.simple.center.entity.User;
import org.simple.center.mapper.UserMapper;
import org.simple.center.service.UserService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Service
public class UserServiceImpl
        extends ServiceImpl<UserMapper, User>
        implements UserService {
    @Override
    public List<Tree<String>> getUserMenu(String userId) {
        List<Menu> menus = baseMapper.getUserMenu(userId);
        if (CollectionUtils.isNotEmpty(menus)) {
            TreeNodeConfig config = new TreeNodeConfig();
            //config.setParentIdKey("parentid");
            List<Tree<String>> treeNodes = TreeUtil.build(menus, "999999", config,
                    (object, tree) -> {
                        tree.setName(object.getName());
                        tree.setId(object.getId());
                        tree.setWeight(StringUtils.isEmpty(object.getSort())?0:Integer.valueOf(object.getSort()));
                        tree.setParentId(object.getParentid());
                        tree.putExtra("component", object.getComponent());
                        tree.putExtra("path", object.getPath());
                        tree.setName(
                                object.getPath().startsWith("/") ?
                                        object.getPath().substring(1) :
                                        object.getPath());
//                        Map<String, String> meta = new HashMap<>();
//                        meta.put("title", object.getName());
//                        meta.put("icon", object.getIcon());
                        tree.putExtra("meta", object.getMeta());
                        tree.putExtra("redirect", "");
                    });
            return treeNodes;
        } else {
            return new ArrayList<Tree<String>>();
        }
    }

    @Override
    public CommonResult delUser(String userId) {
        //先删除用户关联的数据
        baseMapper.delRoleUser(userId);
        baseMapper.delUserTenant(userId);
        baseMapper.deleteById(userId);
        return CommonResult.successNodata("删除成功");
    }

    @Override
    public void insertUserTenant(String id, String tenant, String user) {
         baseMapper.insertUserTenant(id,tenant,user);
    }

    @Override
    public void insertRoleUser(String id, String role, String user) {
        baseMapper.insertRoleUser(id,role,user);
    }

    @Override
    public IPage<List<UserDto>> listAll(Page page, User user) {
        return baseMapper.listAll(page,user);
    }

    @Override
    public CommonResult updateUser(UserDto userDto) {
        User user = new User();
        user.setUpdatedate(LocalDateTime.now());
        user.setTenant(userDto.getTenant());
        user.setUsername(userDto.getUsername());
        user.setNickname(userDto.getNickname());
        user.setPhone(userDto.getPhone());
        user.setEmail(userDto.getEmail());
        user.setId(userDto.getId());
        baseMapper.updateById(user);

        //删除用户机构关联关系,角色用户关联关系
        baseMapper.delUserTenant(userDto.getId());
        baseMapper.delRoleUser(userDto.getId());

        //重新插入用户角色和用户机构关联关系
        baseMapper.insertUserTenant(RedomUtil.getUserTenantId(),userDto.getTenant(),userDto.getId());
        String[] roles = userDto.getRoles().split(",");
        for(String role : roles){
            baseMapper.insertRoleUser(RedomUtil.getRoleUserId(),role,userDto.getId());
        }
        return CommonResult.successNodata("修改成功");
    }
}
