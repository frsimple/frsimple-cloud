package org.simple.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.simple.center.entity.Dictionary;
import org.simple.center.mapper.DictionaryMapper;
import org.simple.center.service.DictionaryService;
import org.springframework.stereotype.Service;

@Service
public class DictionaryServiceImpl
        extends ServiceImpl<DictionaryMapper, Dictionary>
        implements DictionaryService {

}
