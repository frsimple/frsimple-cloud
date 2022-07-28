
package org.simple.route.init;

import com.alibaba.nacos.api.NacosFactory;
import com.alibaba.nacos.api.config.ConfigService;
import com.alibaba.nacos.api.config.listener.Listener;
import com.alibaba.nacos.api.exception.NacosException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.simple.route.entity.GatewayRouteList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.route.RouteDefinitionWriter;
import org.springframework.context.annotation.Configuration;
import org.yaml.snakeyaml.Yaml;
import reactor.core.publisher.Mono;

import javax.annotation.PostConstruct;
import java.util.concurrent.Executor;

/**
 * 动态路由管理
 */


@Slf4j
@Configuration
public class NacosDynamicRoutes {
    @Autowired
    private RouteDefinitionWriter routeDefinitionWriter;

    @Value("${spring.cloud.nacos.discovery.server-addr}")
    private String serverAddr;
    @Value("${spring.application.name}.${spring.cloud.nacos.config.file-extension}")
    private String dataId;
    @Value("${spring.cloud.nacos.config.group}")
    private String groupId;


    @PostConstruct
    public void initRoute() {
        try {
            ConfigService configService = NacosFactory.createConfigService(serverAddr);
            String content = configService.getConfig(dataId, groupId, 5000L);
            initOrUpdateRoutes(content);
            configService.addListener(dataId, groupId, new Listener() {
                @Override
                public void receiveConfigInfo(String configInfo) {
                    initOrUpdateRoutes(configInfo);
                }

                @Override
                public Executor getExecutor() {
                    return null;
                }
            });
        } catch (NacosException e) {
            log.error("加载路由出错：{}", e.getErrMsg());
        }
    }

    public void initOrUpdateRoutes(String content) {
        if (StringUtils.isEmpty(content)) {
            return;
        }
        Yaml yaml = new Yaml();
        GatewayRouteList gatewayRouteList = yaml.loadAs(content,GatewayRouteList.class);
        gatewayRouteList.getRoutes().forEach(route -> {
            log.info("加载路由：{},{}", route.getId(), route);
            routeDefinitionWriter.save(Mono.just(route)).subscribe();
        });
    }
}
