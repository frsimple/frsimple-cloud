package org.simple.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.*;
import org.simple.center.dto.UserDto;
import org.simple.center.entity.Menu;
import org.simple.center.entity.User;

import java.util.List;

public interface UserMapper extends BaseMapper<User> {

    @Select("select t1.* from center_rolemenu t join center_menu t1 on t1.id = t.menu" +
            " where t.role in ( select  role from center_roleuser where  " +
            "user  = #{userId}) and t1.type ='c' order by t1.sort asc")
    @Results({
            @Result(column = "meta", property = "meta", typeHandler = JacksonTypeHandler.class)
    })
    List<Menu> getUserMenu(@Param("userId") String userId);


    @Delete("delete from center_roleuser where user = #{userId}")
    void delRoleUser(@Param("userId") String userId);

    @Delete("delete from center_usertenant where user = #{userId}")
    void delUserTenant(@Param("userId") String userId);

    @Insert("insert into center_usertenant(id,tenant,user) values(#{id},#{tenant},#{user})")
    void insertUserTenant(@Param("id")String id,@Param("tenant")String tenant,@Param("user")String user);

    @Insert("insert into center_roleuser(id,role,user) values(#{id},#{role},#{user})")
    void insertRoleUser(@Param("id")String id,@Param("role")String role,@Param("user")String user);

    IPage<List<UserDto>> listAll(Page page, @Param("user")User user);

}
