package org.simple.grant.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.simple.grant.entity.PermissionEntry;

import java.util.List;

/**
 * @Description: 用户权限查询
 */
public interface PermissionMapper extends BaseMapper<PermissionEntry> {


    @Select("select t.id,t1.authcode from center_rolemenu t join center_menu t1 on t1.id = t.menu" +
            " where t.role in ( select  role from center_roleuser where user  = #{userId}) " +
            " and t1.type = 'b'")
    List<PermissionEntry> selectPermissionsByUserId(@Param("userId") String uerId);


}
