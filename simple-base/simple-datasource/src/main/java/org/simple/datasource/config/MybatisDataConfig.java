package org.simple.datasource.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import lombok.AllArgsConstructor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

/**
 * MybatisPlus配置
 *
 */
@Configuration
@ConditionalOnBean(DataSource.class)
@AllArgsConstructor
@AutoConfigureAfter(DataSourceAutoConfiguration.class)
@MapperScan("org.simple.**.mapper")
public class MybatisDataConfig {
	/**
	 * 分页
	 */
	@Bean
	public PaginationInterceptor paginationInterceptor() {
		PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
		paginationInterceptor.setDialectType(DbType.POSTGRE_SQL.getDb());
		return paginationInterceptor;
	}
}
