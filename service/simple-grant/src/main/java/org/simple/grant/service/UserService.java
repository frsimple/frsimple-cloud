package org.simple.grant.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.ibatis.annotations.Param;
import org.simple.common.dto.Logs;
import org.simple.grant.entity.UserEntity;
import org.simple.grant.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;


@Service
public class UserService extends ServiceImpl<UserMapper, UserEntity> {

    public UserEntity getUserByUsername(String username) {
        return baseMapper.selectUser(username);
    }

    public UserEntity getUserBPhone(String phone) {
        return baseMapper.selectUserByPhone(phone);
    }

    public UserEntity getUserByThird(String type,String openId){
        return baseMapper.selectUserByThird(type,openId);
    }

    public Integer confirmLogin(String code,String openId){
        return baseMapper.confirmLogin(code,openId);
    }

    public String queryOpenIdByCode(String code){
        return baseMapper.queryOpenIdByCode(code);
    }
    //密码错误更新密码错误次数，超过5次锁定密码
    public void updatPwdError(String id) {
        baseMapper.updatePwdError(id);
    }

    public void resetError(String id) {
        baseMapper.resetError(id);
    }

    public void uptLoginDate(String id) {
        baseMapper.uptLoginDate(id);
    }

    public void insertLogs(Logs logs) {
        baseMapper.insertLogs(logs);
    }

    public Integer selectRoles(String id){
        return baseMapper.selectRoles(id);
    }

    public LocalDateTime getLoginDate(String id){
        return baseMapper.getLoginDate(id);
    }

}
