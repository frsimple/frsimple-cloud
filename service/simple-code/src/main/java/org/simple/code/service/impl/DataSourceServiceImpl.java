package org.simple.code.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.code.entity.DataSource;
import org.simple.code.service.DataSourceService;
import org.simple.code.mapper.DataSourceMapper;
import org.springframework.stereotype.Service;


@Service
public class DataSourceServiceImpl
        extends ServiceImpl<DataSourceMapper, DataSource>
        implements DataSourceService {
}
