package org.simple.center.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.DesensitizedUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.commons.lang.StringUtils;
import org.simple.center.dto.UserDto;
import org.simple.center.entity.User;
import org.simple.center.service.UserService;
import org.simple.common.constant.RedisConstant;
import org.simple.common.sms.EmailUtil;
import org.simple.common.sms.SmsUtil;
import org.simple.common.storage.OssUtil;
import org.simple.common.utils.ComUtil;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.security.annotation.SimpleLog;
import org.simple.security.utils.AuthUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.function.ServerResponse;

import javax.annotation.Resource;
import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @Autowired
    private RedisTemplate redisTemplate;

    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @GetMapping("info")
    @SimpleLog("查询当前用户信息")
    public CommonResult getUserInfo(){
        User user = userService.getById(AuthUtils.getUser().getId());
        Map<String,Object> userInfo =
                BeanUtil.beanToMap(AuthUtils.getUser());
        userInfo.put("avatar",user.getAvatar());
        userInfo.put("nickname",user.getNickname());
        Map<String,Object> result = new HashMap<String,Object>();
        result.put("roles",AuthUtils.getAuthoritys());
        result.put("user",userInfo);
       return CommonResult.success(result);
    }


    @GetMapping("menu")
    @SimpleLog("查询当前用户菜单")
    public CommonResult getUserMenu(){
        return CommonResult.success(userService.getUserMenu(AuthUtils.getUser().getId()));
    }

    @GetMapping("list")
    @SimpleLog("查询用户列表")
    @PreAuthorize("hasAnyAuthority('system:user:query')")
    public CommonResult list(Page page, User user){
        return CommonResult.success(userService.listAll(page,user));
    }

    @GetMapping("list1")
    @SimpleLog("根据条件查询用户")
    @PreAuthorize("hasAnyAuthority('system:user:query')")
    public CommonResult list1(User user){
        String id = user.getId();
        user.setId(null);
         return CommonResult.success(userService.list(Wrappers.query(user).notIn("id",id)));
    }

    @PostMapping("addUser")
    @SimpleLog("新增用户信息")
    @PreAuthorize("hasAnyAuthority('system:user:add')")
    public CommonResult addUser(@RequestBody UserDto userDto){
        String userid = RedomUtil.getUserId();
        User user = new User();
        user.setId(userid);
        user.setStatus("0");
        user.setError(0);
        user.setCreatedate(LocalDateTime.now());
        user.setUpdatedate(LocalDateTime.now());
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        user.setPhone(userDto.getPhone());
        user.setEmail(userDto.getEmail());
        user.setNickname(userDto.getNickname());
        user.setUsername(userDto.getUsername());
        user.setTenant(userDto.getTenant());
        userService.save(user);
        userService.insertUserTenant(RedomUtil.getUserTenantId(),user.getTenant(),userid);
        //for循环插入用户角色关联关系数据
        String[] roles = userDto.getRoles().split(",");
        for(String role : roles){
            userService.insertRoleUser(RedomUtil.getRoleUserId(),role,userid);
        }
        return CommonResult.successNodata("新增成功");
    }

    @PostMapping("editUser")
    @SimpleLog("修改用户信息")
    @PreAuthorize("hasAnyAuthority('system:user:edit')")
    public CommonResult editUser(@RequestBody UserDto userDto){
        return  userService.updateUser(userDto);
    }

    @DeleteMapping("delUser/{id}")
    @SimpleLog("删除用户信息")
    @PreAuthorize("hasAnyAuthority('system:user:del')")
    public CommonResult delUser(@PathVariable("id") String id){
        if(id.equals("1")){
            return CommonResult.failed("不允许删除超级管理员");
        }
        return userService.delUser(id);
    }

    @GetMapping("lock/{id}")
    @SimpleLog("锁定用户")
    @PreAuthorize("hasAnyAuthority('system:user:edit')")
    public CommonResult lock(@PathVariable("id") String id){
        User user = new User();
        user.setId(id);
        user.setStatus("1");
        userService.updateById(user);
        return CommonResult.successNodata("账户已被锁定");
    }

    @GetMapping("unlock/{id}")
    @SimpleLog("解锁用户")
    @PreAuthorize("hasAnyAuthority('system:user:edit')")
    public CommonResult unlock(@PathVariable("id") String id){
        User user = new User();
        user.setId(id);
        user.setStatus("0");
        userService.updateById(user);
        return CommonResult.successNodata("账户已解锁");
    }

    @GetMapping("resetPwd/{id}")
    @SimpleLog("重置密码")
    @PreAuthorize("hasAnyAuthority('system:user:edit')")
    public CommonResult resetPwd(@PathVariable("id") String id){
        User user = new User();
        user.setId(id);
        user.setPassword(passwordEncoder.encode("888888"));
        userService.updateById(user);
        return CommonResult.successNodata("账户密码已重置");
    }

    @PostMapping("updatePwd")
    @SimpleLog("修改密码")
    public CommonResult updatePwd(@RequestBody  UserDto userDto){
        User user = new User();
        if(StringUtils.isEmpty(userDto.getId())){
            userDto.setId(AuthUtils.getUser().getId());
        }
        user.setId(userDto.getId());
        user.setPassword(passwordEncoder.encode(userDto.getNPassword()));
        userService.updateById(user);
        return CommonResult.successNodata("账户密码修改成功");
    }

    @PostMapping("checkPwd")
    @SimpleLog("检验密码是否正确")
    public CommonResult checkPwd(@RequestBody  UserDto userDto){
        if(StringUtils.isEmpty(userDto.getId())){
            userDto.setId(AuthUtils.getUser().getId());
        }
        User user = userService.getById(userDto.getId());
        if(!passwordEncoder.matches(userDto.getPassword(),
                user.getPassword())){
            return CommonResult.failed("密码错误");
        }
        return CommonResult.successNodata("密码正确");
    }

    @PostMapping("updateAvatar")
    public  CommonResult updateAvatar(@RequestParam("file")MultipartFile file){
          File file1 = ComUtil.MultipartToFile(file);
          //上传图片
        CommonResult result =
                OssUtil.getAliOss(redisTemplate).fileUpload(file1,false,AuthUtils.getUser().getId());
        if(result.getCode() == 0){
            //上传成功，头像用户头像
            User user = new User();
            user.setAvatar(result.getData().toString());
            user.setId(AuthUtils.getUser().getId());
            userService.updateById(user);
            return CommonResult.successNodata(result.getData().toString());
        }else{
            return  result;
        }
    }

    @GetMapping("queryUser")
    public CommonResult queryUser(){
        User user =  userService.getById(AuthUtils.getUser().getId());
        User r = new User();
        r.setId(user.getId());
        r.setEmail(StrUtil.hide(user.getEmail(),3,5));
        r.setPhone(DesensitizedUtil.mobilePhone(user.getPhone()));
        r.setNickname(user.getNickname());
        return CommonResult.success(r);
    }

    @PostMapping("updateUser")
    public CommonResult updateUser(@RequestBody User user){
        if(!user.getId().equals(AuthUtils.getUser().getId())){
           return CommonResult.failed("非法操作");
        }
        return CommonResult.success(userService.updateById(user));
    }


    @GetMapping("sendMsg")
    public CommonResult sendMsg(@RequestParam("phone")String phone){
        //判断是否和当前手机号一直
        User phoneUser = new User();
        phoneUser.setPhone(phone);
        if(userService.list(Wrappers.query(phoneUser)).size()!=0){
            return CommonResult.failed("新手机号已注册，不能重复使用");
        }

        String key = RedisConstant.PHONE_UPDATE_CODE_STR + AuthUtils.getUser().getId();
        //校验是否发送过短信以免重复发送60秒只能发送一次
        if (redisTemplate.hasKey(key)) {
            Long seconds = redisTemplate.opsForValue().getOperations().getExpire(key);
            if (seconds > 0) {
                return CommonResult.failed("已获取过短信，请等待"+seconds+"秒之后在获取");
            }
        }
        //获取四位随机数字
        String rom = RandomUtil.randomNumbers(4);
        try {
            CommonResult result = SmsUtil.getTencentSms(redisTemplate).sendSms(null,"865723",
                    new String[]{rom},new String[]{phone});
            if(result.getCode() == 1){
                return CommonResult.failed("发送失败："+result.getMsg());
            }
        } catch (Exception e) {
            return CommonResult.failed("发送失败："+e.getMessage());
        }
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.opsForValue().set( RedisConstant.PHONE_UPDATE_CODE_STR + AuthUtils.getUser().getId(),
                rom +"_"+phone, RedisConstant.CODE_TIMEOUT, TimeUnit.SECONDS);
        return CommonResult.successNodata("发送成功");
    }


    @GetMapping("updatePhone")
    public CommonResult updatePhone(@RequestParam("password")String password,
                                    @RequestParam("code")String code){
        String key = RedisConstant.PHONE_UPDATE_CODE_STR + AuthUtils.getUser().getId();
        Object smsStr = redisTemplate.opsForValue().get(key);
        if(null == smsStr){
            return CommonResult.failed("验证码错误");
        }
        String smsCode = String.valueOf(smsStr).split("_")[0];
        String phone = String.valueOf(smsStr).split("_")[1];
        if( !code.equals(smsCode)){
            return CommonResult.failed("验证码错误");
        }
        if(!passwordEncoder.matches(password,
                userService.getById(AuthUtils.getUser().getId()).getPassword())){
            return CommonResult.failed("用户密码错误");
        }
        //验证成功开始更新数据
        User user = new User();
        user.setId(AuthUtils.getUser().getId());
        user.setPhone(phone);
        userService.updateById(user);

        return CommonResult.successNodata("关联手机绑定成功");
    }


    @GetMapping("sendEmail")
    public CommonResult sendEmail(@RequestParam("email")String email){
        //判断是否和当前手机号一直
        User emailUser = new User();
        emailUser.setEmail(email);
        if(userService.list(Wrappers.query(emailUser)).size()!=0){
            return CommonResult.failed("新邮箱已注册，不能重复使用");
        }

        String key = RedisConstant.EMAIL_UPDATE_CODE_STR + AuthUtils.getUser().getId();
        //校验是否发送过短信以免重复发送60秒只能发送一次
        if (redisTemplate.hasKey(key)) {
            Long seconds = redisTemplate.opsForValue().getOperations().getExpire(key);
            if (seconds > 0) {
                return CommonResult.failed("已获取过验证码，请等待"+seconds+"秒之后在获取");
            }
        }
        //获取四位随机数字
        String rom = RandomUtil.randomNumbers(4);
        try {
            CommonResult result = EmailUtil.getInstance(redisTemplate)
                    .sendEmail("更换绑定邮箱地址","验证码："+rom,
                            new String[]{email},true,null);
            if(result.getCode() == 1){
                return CommonResult.failed("发送失败："+result.getMsg());
            }
        } catch (Exception e) {
            return CommonResult.failed("发送失败："+e.getMessage());
        }
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.opsForValue().set( RedisConstant.EMAIL_UPDATE_CODE_STR + AuthUtils.getUser().getId(),
                rom +"_"+email, RedisConstant.CODE_TIMEOUT, TimeUnit.SECONDS);
        return CommonResult.successNodata("发送成功");
    }


    @GetMapping("updateEmail")
    public CommonResult updateEmail(@RequestParam("password")String password,
                                    @RequestParam("code")String code){
        String key = RedisConstant.EMAIL_UPDATE_CODE_STR + AuthUtils.getUser().getId();
        Object smsStr = redisTemplate.opsForValue().get(key);
        if(null == smsStr){
            return CommonResult.failed("验证码错误");
        }
        String smsCode = String.valueOf(smsStr).split("_")[0];
        String email = String.valueOf(smsStr).split("_")[1];
        if( !code.equals(smsCode)){
            return CommonResult.failed("验证码错误");
        }
        if(!passwordEncoder.matches(password,
                userService.getById(AuthUtils.getUser().getId()).getPassword())){
            return CommonResult.failed("用户密码错误");
        }
        //验证成功开始更新数据
        User user = new User();
        user.setId(AuthUtils.getUser().getId());
        user.setEmail(email);
        userService.updateById(user);

        return CommonResult.successNodata("更新绑定邮箱成功");
    }


}
