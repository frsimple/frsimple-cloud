package org.simple.route.entity;

import lombok.Data;
import org.springframework.cloud.gateway.route.RouteDefinition;

import java.util.List;

@Data
public class GatewayRouteList {
private static final long serialVersionUID = 1L;
	List<RouteDefinition> routes;
}
