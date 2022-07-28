package org.simple.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.entity.Oss;
import org.simple.center.mapper.OssMapper;
import org.simple.center.service.OssService;
import org.springframework.stereotype.Service;

@Service
public class OssServiceImpl
        extends ServiceImpl<OssMapper, Oss>
        implements OssService {
}
