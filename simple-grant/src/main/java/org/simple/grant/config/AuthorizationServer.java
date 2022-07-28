package org.simple.grant.config;

import org.simple.grant.exception.WebResponseTranslator;
import org.simple.grant.smscode.SmsCodeTokenGranter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.CompositeTokenGranter;
import org.springframework.security.oauth2.provider.TokenGranter;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;
import org.springframework.security.oauth2.provider.code.AuthorizationCodeServices;
import org.springframework.security.oauth2.provider.token.AuthorizationServerTokenServices;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


/**
 * @Description: 授权服务器配置
 */
@Configuration
@EnableAuthorizationServer
public class AuthorizationServer extends AuthorizationServerConfigurerAdapter {


    @Autowired
    private AuthorizationCodeServices authorizationCodeServices;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private AuthorizationServerTokenServices tokenService;

    @Autowired
    @Qualifier("myClientDetailsService")
    private ClientDetailsService clientService;

    /**
     * 配置客户端详细信息服务
     */
    @Override
    public void configure(ClientDetailsServiceConfigurer clients) throws Exception {

        clients.withClientDetails(clientService);
    }

    @Bean("myClientDetailsService")
    public ClientDetailsService clientDetailsService(DataSource dataSource, PasswordEncoder passwordEncoder) {
        JdbcClientDetailsService clientDetailsService = new JdbcClientDetailsService(dataSource);
        clientDetailsService.setPasswordEncoder(NoOpPasswordEncoder.getInstance());
        return clientDetailsService;
    }

    private TokenGranter tokenGranter(final AuthorizationServerEndpointsConfigurer endpoints) {

        // endpoints.getTokenGranter() 获取SpringSecurity OAuth2.0 现有的授权类型
        List<TokenGranter> granters =
                new ArrayList<TokenGranter>(Collections.singletonList(endpoints.getTokenGranter()));
        // 构建短信验证授权类型
        SmsCodeTokenGranter smsCodeTokenGranter =
                new SmsCodeTokenGranter(authenticationManager,
                        endpoints.getTokenServices(), endpoints.getClientDetailsService(),
                        endpoints.getOAuth2RequestFactory());
        // 向集合中添加短信授权类型
        granters.add(smsCodeTokenGranter);
        // 返回所有类型
        return new CompositeTokenGranter(granters);
    }
    /**
     * 令牌访问端点
     */
    @Override
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) {
        endpoints
                .authenticationManager(authenticationManager)
                .authorizationCodeServices(authorizationCodeServices)
                .tokenGranter(tokenGranter(endpoints))
                .tokenServices(tokenService)
                .allowedTokenEndpointRequestMethods(HttpMethod.POST)
                .exceptionTranslator(new WebResponseTranslator());
    }

    /**
     * 令牌访问端点安全策略
     */
    @Override
    public void configure(AuthorizationServerSecurityConfigurer security) {
        security
                .tokenKeyAccess("permitAll()")
                .checkTokenAccess("permitAll()")
                .allowFormAuthenticationForClients()
                .passwordEncoder(NoOpPasswordEncoder.getInstance());
    }

}
