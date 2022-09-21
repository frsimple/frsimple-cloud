package org.simple.common.storage;


import org.springframework.data.redis.core.RedisTemplate;

/**
 * 文件存储工具类
 * */
public class OssUtil {

    public static AliOss  getAliOss(RedisTemplate redisTemplate){
         return AliOss.getInstance(redisTemplate);
    }

    public static TencentOss  getTencentOss(RedisTemplate redisTemplate){
        return TencentOss.getInstance(redisTemplate);
    }

    public static MinioOss  getMinioOss(RedisTemplate redisTemplate){
        return MinioOss.getInstance(redisTemplate);
    }
}
