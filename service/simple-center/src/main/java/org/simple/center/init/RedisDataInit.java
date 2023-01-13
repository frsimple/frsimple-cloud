package org.simple.center.init;


import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollectionUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.simple.center.entity.Dictionary;
import org.simple.center.entity.Email;
import org.simple.center.entity.Oss;
import org.simple.center.entity.Sms;
import org.simple.center.service.DictionaryService;
import org.simple.center.service.EmailService;
import org.simple.center.service.OssService;
import org.simple.center.service.SmsService;
import org.simple.common.constant.RedisConstant;
import org.simple.common.dto.EmailDto;
import org.simple.common.dto.OssDto;
import org.simple.common.dto.SmsDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.concurrent.TimeUnit;


/**
 * redis数据初始化
 */
@Configuration
public class RedisDataInit {

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private OssService ossService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private SmsService smsService;

    @Autowired
    private DictionaryService dictionaryService;


    @PostConstruct
    public void initData() {
        //初始化加载oss数据
        loadOssConfig();
        //初始化加载短信配置，短信模版数据
        loadSmsConfig();
        //初始化邮件配置数据
        loadEmailConfig();
        //初始化字典缓存数据
        loadDictConfig();
    }


    private void loadDictConfig() {
        Dictionary dictionary = new Dictionary();
        dictionary.setValue("#");
        List<Dictionary> dictionaryList = dictionaryService.list(Wrappers.query(dictionary));
        if (dictionaryList.size() != 0) {
            //Map<String, JSONArray> dictMap = new HashMap<>();
            for (Dictionary item : dictionaryList) {
                Dictionary d = new Dictionary();
                d.setCode(item.getCode());
                List<Dictionary> dicts =
                        dictionaryService.list(Wrappers.query(d).notIn("value", "#"));
                JSONArray array = new JSONArray();
                if (dicts.size() != 0) {
                    for (Dictionary item1 : dicts) {
                        JSONObject jsonObject = new JSONObject();
                        jsonObject.put("value", item1.getValue());
                        jsonObject.put("id", item1.getId());
                        jsonObject.put("label", item1.getLabel());
                        jsonObject.put("code", item1.getCode());
                        array.add(jsonObject);
                    }
                }
                //dictMap.put(item.getCode(), array);
                redisTemplate.opsForValue().set(item.getCode(),array);
            }
        }
    }

    private void loadSmsConfig() {
        List<Sms> smsList = smsService.list();
        if (CollectionUtil.isNotEmpty(smsList)) {
            smsList.forEach(sms -> {
                SmsDto smsDto = new SmsDto();
                smsDto.setAppid(sms.getAppid());
                smsDto.setEndpoint(sms.getEndpoint());
                smsDto.setSecretid(sms.getSecretid());
                smsDto.setSecretkey(sms.getSecretkey());
                smsDto.setSign(sms.getSign());
                if (sms.getType().equals("ALI")) {
                    redisTemplate.opsForHash().putAll(RedisConstant.SMS_ALI, BeanUtil.beanToMap(smsDto));
                    redisTemplate.expire(RedisConstant.SMS_ALI, 300000000, TimeUnit.DAYS);
                } else if (sms.getType().equals("TENCENT")) {
                    redisTemplate.opsForHash().putAll(RedisConstant.SMS_TENCENT, BeanUtil.beanToMap(smsDto));
                    redisTemplate.expire(RedisConstant.SMS_TENCENT, 300000000, TimeUnit.DAYS);
                }
            });
        }
    }

    private void loadEmailConfig() {
        List<Email> emails = emailService.list();
        if (CollectionUtil.isNotEmpty(emails)) {
            Email email = emails.get(0);
            EmailDto emailDto = new EmailDto();
            emailDto.setHost(email.getHost());
            emailDto.setPort(email.getPort());
            emailDto.setSitename(email.getSitename());
            emailDto.setUsername(email.getUsername());
            emailDto.setPassword(email.getPassword());
            emailDto.setIsssl(email.getIsssl());
            redisTemplate.opsForHash().putAll(RedisConstant.EMIAL_PIX, BeanUtil.beanToMap(emailDto));
            redisTemplate.expire(RedisConstant.EMIAL_PIX, 300000000, TimeUnit.DAYS);
        }
    }

    private void loadOssConfig() {
        List<Oss> ossList = ossService.list();
        if (CollectionUtil.isNotEmpty(ossList)) {
            ossList.forEach(oss -> {
                OssDto o = new OssDto();
                o.setAccesskeysecret(oss.getAccesskeysecret());
                o.setAccesskeyid(oss.getAccesskeyid());
                o.setAppid(oss.getAppid());
                o.setRegion(oss.getRegion());
                o.setEndpoint(oss.getEndpoint());
                o.setWorkspace(oss.getWorkspace());
                if (oss.getType().equals("ALIOSS")) {
                    redisTemplate.opsForHash().putAll(RedisConstant.ALIOSS_PIX, BeanUtil.beanToMap(o));
                    redisTemplate.expire(RedisConstant.ALIOSS_PIX, 300000000, TimeUnit.DAYS);
                } else if (oss.getType().equals("TENCENTCOS")) {
                    redisTemplate.opsForHash().putAll(RedisConstant.TENCENT_PIX, BeanUtil.beanToMap(o));
                    redisTemplate.expire(RedisConstant.TENCENT_PIX, 300000000, TimeUnit.DAYS);
                } else if (oss.getType().equals("MINIO")) {
                    redisTemplate.opsForHash().putAll(RedisConstant.MINIO_PIX, BeanUtil.beanToMap(o));
                    redisTemplate.expire(RedisConstant.MINIO_PIX, 300000000, TimeUnit.DAYS);
                }
            });
        }
    }
}
