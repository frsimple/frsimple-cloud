package org.simple.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.simple.center.entity.Role;

import java.util.List;

public interface RoleMapper extends BaseMapper<Role> {


    @Delete("delete from center_roleuser where role = #{id}")
    void delRoleUser(@Param("id")String id);

    @Delete("delete from center_rolemenu where role = #{id}")
    void delRoleMenu(@Param("id")String id);

    @Select("select count(1) from center_roleuser where role = #{id}")
    Integer queryRoleUser(@Param("id")String id);


    @Select("select t1.id from center_rolemenu t join center_menu t1 on t1.id = t.menu" +
            " where t.role = #{roleId}  order by t1.sort asc")
    List<String> queryRoleMenu(@Param("roleId") String roleId);

    @Insert("insert into center_rolemenu(id,role,menu) values(#{id},#{role},#{menu})")
    void insetRoleMenu(@Param("id") String id,@Param("role") String role,@Param("menu") String menu);
}
