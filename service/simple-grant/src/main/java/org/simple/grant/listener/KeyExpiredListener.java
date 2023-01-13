package org.simple.grant.listener;

import org.simple.grant.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.KeyExpirationEventMessageListener;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;

/**
 * redis过期监听
 * */

@Component
public class KeyExpiredListener extends KeyExpirationEventMessageListener {

    @Autowired
    public RedisTemplate<String,String> redisTemplate;

    @Autowired
    private UserService userService;

    public KeyExpiredListener(RedisMessageListenerContainer listenerContainer) {
        super(listenerContainer);
    }

    @Override
    public void onMessage(Message message, byte[] bytes) {
        //获取失效key名称
        String expireKey = new String(message.getBody(), StandardCharsets.UTF_8);
        //获取key原本的value 获取不到 是null
        String expireKeyValue = redisTemplate.opsForValue().get("myKey");
        System.out.println("过期key:"+expireKey);
        if(expireKey.startsWith("user_passwrod_error:")){
            userService.resetError(expireKey.replace("user_passwrod_error:",""));
        }
    }
}
