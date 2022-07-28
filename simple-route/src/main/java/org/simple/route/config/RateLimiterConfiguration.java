package org.simple.route.config;

import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import reactor.core.publisher.Mono;

/**
 *  令牌桶，限流策略配置
 */
@Configuration
public class RateLimiterConfiguration {
	@Bean(value = "ipKeyResolver")
	public KeyResolver remoteAddrKeyResolver() {
		return exchange -> Mono.just(exchange.getRequest().getRemoteAddress().getAddress().getHostAddress());
	}
}
