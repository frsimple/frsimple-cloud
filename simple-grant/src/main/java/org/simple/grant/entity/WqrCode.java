package org.simple.grant.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@Accessors(chain = true)
@TableName(value = "center_wqrcode",autoResultMap = true)
public class WqrCode {

    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 临时授权码
     * */
    private String code;

    /**
     *  生成时间
     * */
    private LocalDateTime createtime;

    /**
     * 状态
     * */
    private String status;

    /**
     * 微信用户id
     * */
    private String openid;

    /**
     * 操作
     * */
    private String opt;

    /**
     * 扫码时间
     * */
    private LocalDateTime qrtime;

}
