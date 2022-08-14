package org.simple.center.controller;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.simple.center.entity.Dictionary;
import org.simple.center.service.DictionaryService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.security.annotation.SimpleLog;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/dict")
@AllArgsConstructor
public class DictController {

    private final DictionaryService dictionaryService;


    @GetMapping("list")
    @SimpleLog("查询字典")
    @PreAuthorize("hasAnyAuthority('system:dict:query')")
    public CommonResult list(Page page, Dictionary dictionary) {
        //只查询字典
        dictionary.setValue("#");
        String label = "";
        if (StringUtils.isNotEmpty(dictionary.getLabel())) {
            label = dictionary.getLabel();
            dictionary.setLabel("");
        }
        return CommonResult.success(dictionaryService.page(page,
                Wrappers.query(dictionary).like("label", label)
                        .or().like("code", label)
                        .orderByDesc("createtime")));
    }

    @GetMapping("list1")
    @SimpleLog("查询字典")
    @PreAuthorize("hasAnyAuthority('system:dict:query')")
    public CommonResult list1(Dictionary dictionary) {
        String id = "";
        if(StringUtils.isNotEmpty(dictionary.getId())){
            id = dictionary.getId();
        }
        dictionary.setId(null);
        dictionary.setValue("#");
        return CommonResult.success(dictionaryService.list(Wrappers.query(dictionary).
                notIn("id",id)));
    }

    @GetMapping("values")
    @SimpleLog("查询字典项")
    @PreAuthorize("hasAnyAuthority('system:dict:query')")
    public CommonResult listVlues(@RequestParam("code") String code) {
        Dictionary dictionary = new Dictionary();
        dictionary.setCode(code);
        return CommonResult.success(dictionaryService.list(
                Wrappers.query(dictionary).notIn("value", "#")));
    }

    @GetMapping("vals/{code}")
    //@SimpleLog("查询字典项")
    //@PreAuthorize("hasAnyAuthority('system:dict:query')")
    public CommonResult listValues1(@PathVariable("code") String code) {
        Dictionary dictionary = new Dictionary();
        dictionary.setCode(code);
        return CommonResult.success(dictionaryService.list(
                Wrappers.query(dictionary).notIn("value", "#")));
    }

    @PostMapping("addDict")
    @SimpleLog("新增字典")
    @PreAuthorize("hasAnyAuthority('system:dict:add')")
    public CommonResult addDict(@RequestBody Dictionary dictionary) {
        dictionary.setId(RedomUtil.getDictId());
        dictionary.setCreatetime(LocalDateTime.now());
        dictionaryService.save(dictionary);
        return CommonResult.successNodata("新增成功");
    }

    @PostMapping("editDict")
    @SimpleLog("修改字典")
    @PreAuthorize("hasAnyAuthority('system:dict:edit')")
    public CommonResult editDict(@RequestBody Dictionary dictionary) {
        //清洗对象
        Dictionary d = dictionaryService.getById(dictionary.getId());
        if(d.getValue().equals("#")){
            Dictionary d1 = new Dictionary();
            d1.setCode(d.getCode());
            List<Dictionary> list = dictionaryService.
                    list(Wrappers.query(d1));
            if(CollectionUtil.isNotEmpty(list)){
                list.forEach(dict -> {
                    dict.setCode(dictionary.getCode());
                    dictionaryService.updateById(dict);
                });
            }
            d.setLabel(dictionary.getLabel());
            d.setCode(dictionary.getCode());
            dictionaryService.updateById(d);
        }else{
            d.setLabel(dictionary.getLabel());
            d.setValue(dictionary.getValue());
            dictionaryService.updateById(d);
        }
        return CommonResult.successNodata("修改成功");
    }

    @DeleteMapping("delDict")
    @SimpleLog("删除字典")
    @PreAuthorize("hasAnyAuthority('system:dict:del')")
    public CommonResult delDict(@RequestParam("id") String id) {
        Dictionary d = dictionaryService.getById(id);
        if (d.getValue().equals("#")) {
            Dictionary dic = new Dictionary();
            dic.setCode(d.getCode());
             dictionaryService.remove(Wrappers.query(dic));
        } else {
            dictionaryService.removeById(id);
        }
        return CommonResult.successNodata("删除成功");
    }


}
