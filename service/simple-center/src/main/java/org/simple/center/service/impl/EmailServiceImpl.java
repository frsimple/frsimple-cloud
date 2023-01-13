package org.simple.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.entity.Email;
import org.simple.center.mapper.EmailMapper;
import org.simple.center.service.EmailService;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl extends ServiceImpl<EmailMapper, Email>
        implements EmailService {
}
