package org.simple.center.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;


/**
 * @Copyright: simple <br/>
 * @Desc: 组织机构信息表实体 <br/>
 * @Date: 2022-08-03 21:47:58 <br/>
 * @Author: frsimple <br/>
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName(value = "center_branch")
public class Branch implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    private String name;

    private String parentid;

    private LocalDateTime createtime;

    private Integer sort;

    private String tenantid;


}
