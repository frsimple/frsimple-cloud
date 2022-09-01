package org.simple.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.entity.Sms;
import org.simple.center.mapper.SmsMapper;
import org.simple.center.service.SmsService;
import org.springframework.stereotype.Service;

@Service
public class SmsServiceImpl
        extends ServiceImpl<SmsMapper, Sms>
        implements SmsService {
}
