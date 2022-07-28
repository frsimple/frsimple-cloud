package org.simple.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.entity.OauthClientDetails;
import org.simple.center.mapper.OauthClientMapper;
import org.simple.center.service.OauthClientService;
import org.springframework.stereotype.Service;

@Service
public class OauthClientServiceImpl
        extends ServiceImpl<OauthClientMapper, OauthClientDetails>
        implements OauthClientService {
}
