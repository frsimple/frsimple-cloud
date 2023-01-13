package org.simple.center.controller;


import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.io.FileUtil;
import org.apache.commons.lang.StringUtils;
import org.simple.center.dto.EmailParams;
import org.simple.center.entity.Email;
import org.simple.center.service.EmailService;
import org.simple.common.constant.RedisConstant;
import org.simple.common.dto.EmailDto;
import org.simple.common.sms.EmailUtil;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/email")
public class EmailController {

    @Autowired
    private EmailService emailService;
    @Autowired
    private RedisTemplate redisTemplate;


    @GetMapping("emailCfg")
    public  CommonResult getEmailCfg(){
      return CommonResult.success(emailService.list());
    }

    @PostMapping("saveOrUpdate")
    public CommonResult saveOrUpdate(@RequestBody Email email){
        if(StringUtils.isEmpty(email.getId())){
            email.setId(RedomUtil.getEmailCfgId());
        }
       emailService.saveOrUpdate(email);
        //初始化缓存
        EmailDto emailDto = new EmailDto();
        emailDto.setHost(email.getHost());
        emailDto.setPort(email.getPort());
        emailDto.setSitename(email.getSitename());
        emailDto.setUsername(email.getUsername());
        emailDto.setPassword(email.getPassword());
        emailDto.setIsssl(email.getIsssl());
        redisTemplate.opsForHash().putAll(RedisConstant.EMIAL_PIX, BeanUtil.beanToMap(emailDto));
        redisTemplate.expire(RedisConstant.EMIAL_PIX, 300000000, TimeUnit.DAYS);
       return CommonResult.successNodata("修改成功");
    }

    @PostMapping("sendEmail")
    public CommonResult sendEmail(EmailParams emailParams,
                                  @RequestParam(value = "files",required = false) MultipartFile[] files) throws IOException {
        File[]  fileList = new File[files.length];
        if(null != files && files.length != 0){
            for(int i =0 ;i < files.length ; i++){
                MultipartFile file = files[i];
                try {
                    File f = null;
                    InputStream inputStream = file.getInputStream();
                    String originalFilename = file.getOriginalFilename();
                    f = new File(originalFilename);
                    FileUtil.writeFromStream(inputStream,f);
                    fileList[i] = f;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return  EmailUtil.getInstance(redisTemplate).sendEmail(
                emailParams.getTitle(),emailParams.getContent(),
                emailParams.getTos().split(","),true,fileList);
    }
}
