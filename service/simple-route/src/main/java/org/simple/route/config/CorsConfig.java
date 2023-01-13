package org.simple.route.config;


import org.simple.route.component.CodeHandler;
import org.simple.route.component.HystrixFallbackHandler;
import org.simple.route.component.PhoneCodeHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;
import org.springframework.web.util.pattern.PathPatternParser;


@Configuration
public class CorsConfig {

    @Autowired
    private HystrixFallbackHandler hystrixFallbackHandler;

    @Autowired
    private CodeHandler codeHandler;

    @Autowired
    private PhoneCodeHandler phoneCodeHandler;

    @Bean
    public CorsWebFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedMethod("*");
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource(new PathPatternParser());
        source.registerCorsConfiguration("/**", config);
        return new CorsWebFilter(source);
    }

    @Bean
    public RouterFunction routerFunction(){
       return RouterFunctions.route()
               .GET("/fallback",hystrixFallbackHandler)
               .GET("/code",codeHandler)
               .GET("/sms",phoneCodeHandler)
               .build();
    }
}