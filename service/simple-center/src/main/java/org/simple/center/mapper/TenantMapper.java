package org.simple.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.simple.center.entity.Tenant;

public interface TenantMapper extends BaseMapper<Tenant> {

    @Select("select count(1) from center_usertenant t where t.tenant = #{id} ")
    Integer  selectCount(@Param("id")String id);
}
