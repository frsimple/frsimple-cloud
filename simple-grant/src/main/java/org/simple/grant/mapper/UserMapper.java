package org.simple.grant.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.*;
import org.simple.common.dto.Logs;
import org.simple.grant.entity.UserEntity;

import java.time.LocalDateTime;

/**
 * @Description: 用户信息查询
 */

public interface UserMapper extends BaseMapper<UserEntity> {

    @Select("select * from center_user where username = #{username} or email = #{username} or phone = #{username}")
    UserEntity selectUser(@Param("username")String username);

    @Select("select * from center_user where phone = #{phone}")
    UserEntity selectUserByPhone(@Param("phone")String phone);

    @Update("update center_user set error = error +1 where id = #{id} ")
    void updatePwdError(@Param("id")String id);

    @Update("update center_user set error = 0 where id = #{id} ")
    void resetError(@Param("id")String id);

    @Update("update center_user set logindate = SYSDATE() where id = #{id} ")
    void uptLoginDate(@Param("id")String id);

    @Insert("insert into center_logs(id,servicename,recource,ip,path,useragent,username,createtime,status) " +
            "values(#{logs.id},#{logs.servicename},#{logs.recource},#{logs.ip},#{logs.path},#{logs.useragent}" +
            ",#{logs.username},sysdate(),#{logs.status})")
    void insertLogs(@Param("logs")Logs logs);

    @Select("select count(1) from center_roleuser where user = #{id}")
    Integer selectRoles(@Param("id")String id);

    @Select("select logindate from center_user where id = #{id}")
    LocalDateTime getLoginDate(@Param("id")String id);

}
