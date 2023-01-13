package org.simple.grant.config;

import org.simple.common.constant.AuthConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.code.AuthorizationCodeServices;
import org.springframework.security.oauth2.provider.code.JdbcAuthorizationCodeServices;
import org.springframework.security.oauth2.provider.token.AuthorizationServerTokenServices;
import org.springframework.security.oauth2.provider.token.DefaultTokenServices;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.redis.RedisTokenStore;

import javax.sql.DataSource;

/**
 * @Description: token管理配置
 */
@Configuration
public class TokenConfig {


    @Autowired
    private RedisConnectionFactory redisConnectionFactory;


    @Bean
    public TokenStore tokenStore() {
        RedisTokenStore redisTokenStore = new RedisTokenStore(redisConnectionFactory);
        redisTokenStore.setPrefix(AuthConstant.SIMPLE_TOKEN_KEY);
        return redisTokenStore;
    }


//    @Bean
//    public JwtAccessTokenConverter accessTokenConverter() {
//        JwtAccessTokenConverter converter = new JwtAccessTokenConverter();
//        converter.setSigningKey(SIGNING_KEY);
//        return converter;
//    }

    /**
     * 配置令牌管理
     */
    @Bean
    public AuthorizationServerTokenServices tokenService(ClientDetailsService clientDetailsService,TokenStore tokenStore
            ) {
        DefaultTokenServices service = new DefaultTokenServices();
        service.setClientDetailsService(clientDetailsService);
        service.setSupportRefreshToken(true);
        service.setTokenStore(tokenStore);
        service.setTokenEnhancer(tokenEnhancer());
        return service;
    }

    @Bean
    public TokenEnhancer tokenEnhancer() {
       return new CustTokenEnhancer();
    }


    /**
     * 授权码存储方式
     */

    @Bean
    public AuthorizationCodeServices authorizationCodeServices(DataSource dataSource) {
        return new JdbcAuthorizationCodeServices(dataSource);
    }

}
