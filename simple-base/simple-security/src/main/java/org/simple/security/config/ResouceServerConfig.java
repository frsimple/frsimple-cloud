package org.simple.security.config;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.simple.security.handler.CustomAccessDeniedHandler;
import org.simple.security.handler.CustomOAuth2AuthenticationEntryPoint;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.TokenStore;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * @Description:
 */
@Configuration
@EnableResourceServer
@EnableGlobalMethodSecurity(prePostEnabled = true)
@ConfigurationProperties(prefix = "auth")
public class ResouceServerConfig extends ResourceServerConfigurerAdapter {


    @Value("${oauth2.scope}")
    private String scope;

    /**
     * 资源ID
     */
    @Value("${spring.application.name}")
    private String resource;


    @Getter
    @Setter
    private List<String> whiteUrls;

    @Resource
    private TokenStore tokenStore;


    /**
     * 资源配置
     */
    @Override
    public void configure(ResourceServerSecurityConfigurer resources) {
        resources.resourceId(resource)
                .tokenStore(tokenStore)
                .stateless(true)
                .accessDeniedHandler(new CustomAccessDeniedHandler())
                .authenticationEntryPoint(new CustomOAuth2AuthenticationEntryPoint());
    }

    /**
     * 请求配置
     */
    @Override
    public void configure(HttpSecurity http) throws Exception {
        String[] urls;
        if (CollectionUtils.isNotEmpty(whiteUrls)) {
            urls = getUrls(whiteUrls);
        } else {
            urls = new String[0];
        }
        String auth = "#oauth2.hasScope('" + scope + "') or #oauth2.hasScope('all')";
        http.authorizeRequests()
                .antMatchers(urls).permitAll()
                //feign内部请求
                .antMatchers("/inward/**").permitAll()
                .anyRequest().access(auth)
                .and().csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
    }

    private String[] getUrls(List<String> list){
        List<String> newUrls = new ArrayList<>();
        for(int i =0 ;i< list.size() ;i++){
            String wUrl = list.get(i);
            if(wUrl.startsWith("/"+resource.split("-")[1])){
                LinkedList list1 = new LinkedList<String>(Arrays.asList(
                        wUrl.split("/")));
                list1.remove(1);
                String cUrl = StringUtils.join(list1, "/");
                newUrls.add(cUrl);
            }
        }
        return newUrls.toArray(new String[newUrls.size()]);
    }
}
