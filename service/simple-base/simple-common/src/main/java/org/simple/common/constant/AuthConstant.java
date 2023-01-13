package org.simple.common.constant;



/**
 * 授权常量
 */
public interface AuthConstant {
    /**
     * token的key值
     * */
    String SIMPLE_TOKEN_KEY = "simple:auth:token:";

    /**
     * 对称秘钥
     */
    String SIGNING_KEY = "meco123";

    String AUTH_KEY = "AUTH_KEY";

    /**
     * 网关响应消息
     */
    String LACK_TOKEN = "令牌缺失，拒绝访问";

    String DECRYPTION_FAILURE = "解密失败，请求未授权";

    String TOKEN_EXPIRED = "令牌已过期，请重新认证";


}