package org.simple.center.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.dto.LogsDto;
import org.simple.center.entity.Logs;
import org.simple.center.mapper.LogsMapper;
import org.simple.center.service.LogsService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogsServiceImpl extends ServiceImpl<LogsMapper, Logs>
        implements LogsService {


    @Override
    public IPage<List<LogsDto>> logsList(Page page, LogsDto logs) {
        return baseMapper.logsList(page,logs);
    }
}
