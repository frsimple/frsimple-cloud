package org.simple.center.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.simple.center.entity.Menu;
import org.simple.center.service.MenuService;
import org.simple.common.utils.CommonResult;
import org.simple.common.utils.RedomUtil;
import org.simple.security.annotation.SimpleLog;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/menu")
@AllArgsConstructor
public class MenuController {

    private final MenuService menuService;


    @GetMapping("treeAll")
    @SimpleLog("查询菜单树")
    public CommonResult getTreeMenuAll(){
       return CommonResult.success(menuService.getTreeMenuAll());
    }


    @GetMapping("roleTreeAll")
    @SimpleLog("查询权限菜单树")
    public CommonResult getRoleTreeAll(){
        return CommonResult.success(menuService.getRoleMenuAll());
    }


    @GetMapping("menuList")
    @SimpleLog("根据条件查询菜单")
    public CommonResult getMenuList(Page page, Menu menu){
        String name = menu.getName();
        menu.setName("");
        return CommonResult.success(menuService.page(page,Wrappers.query(menu).orderByAsc("sort")
                .like("name",name)));
    }

    @GetMapping("btnList")
    @SimpleLog("查询菜单权限列表")
    public CommonResult getbtnList(@RequestParam("id")String id){
        Menu m = new Menu();
        m.setParentid(id);
        m.setType("b");
        return CommonResult.success(menuService.list(Wrappers.query(m)));
    }

    @PostMapping("addMenu")
    @SimpleLog("新增菜单信息")
    @PreAuthorize("hasAnyAuthority('center:menu:add')")
    public CommonResult addMenu(@RequestBody Menu menu){
        //重新组装菜单信息表
        Menu menu1 = new Menu();
        menu1.setCreatetime(LocalDateTime.now());
        menu1.setUpdatetime(LocalDateTime.now());
        menu1.setId(RedomUtil.getMenuId());
        menu1.setType("c");
        menu1.setParentid(menu.getParentid());
        menu1.setComponent(menu.getComponent());
        menu1.setName(menu.getName());
        menu1.setMeta(menu.getMeta());
        menu1.setPath(menu.getPath());
        menu1.setSort(menu.getSort());
        menu1.setStatus("0");
        menuService.save(menu1);
        return CommonResult.success("添加成功");
    }

    @PostMapping("editMenu")
    @SimpleLog("修改菜单信息")
    @PreAuthorize("hasAnyAuthority('center:menu:edit')")
    public CommonResult editMenu(@RequestBody Menu menu){
        //重新组装菜单信息表
        Menu menu1 = new Menu();
        menu1.setUpdatetime(LocalDateTime.now());
        menu1.setId(menu.getId());
        menu1.setComponent(menu.getComponent());
        menu1.setName(menu.getName());
        menu1.setMeta(menu.getMeta());
        menu1.setPath(menu.getPath());
        menu1.setSort(menu.getSort());
        menuService.updateById(menu1);
        return CommonResult.success("修改成功");
    }

    @DeleteMapping("delMenu")
    @SimpleLog("删除菜单信息")
    @PreAuthorize("hasAnyAuthority('center:menu:del')")
    public CommonResult delMenu(@RequestParam("id")String id){
        return menuService.delMenu(id);
    }


    @PostMapping("addBtnMenu")
    @SimpleLog("新增菜单权限信息")
    @PreAuthorize("hasAnyAuthority('center:menu:add')")
    public CommonResult addBtnMenu(@RequestBody Menu menu){
        Menu m = new Menu();
        m.setId(RedomUtil.getMenuBtnId());
        m.setStatus("0");
        m.setName(menu.getName());
        m.setType("b");
        m.setAuthcode(menu.getAuthcode());
        m.setParentid(menu.getParentid());
        m.setCreatetime(LocalDateTime.now());
        m.setUpdatetime(LocalDateTime.now());
        menuService.save(m);
        return CommonResult.successNodata("保存成功");
    }


    @PostMapping("editBtnMenu")
    @SimpleLog("修改菜单权限信息")
    @PreAuthorize("hasAnyAuthority('center:menu:edit')")
    public CommonResult editBtnMenu(@RequestBody Menu menu){
        Menu m = new Menu();
        m.setId(menu.getId());
        m.setName(menu.getName());
        m.setAuthcode(menu.getAuthcode());
        m.setUpdatetime(LocalDateTime.now());
        menuService.updateById(m);
        return CommonResult.successNodata("保存成功");
    }


    @DeleteMapping("delBtnMenu")
    @SimpleLog("删除菜单权限信息")
    @PreAuthorize("hasAnyAuthority('center:menu:del')")
    public CommonResult delBtnMenu(@RequestParam("id") String id){
        return menuService.delBtnMenu(id);
    }
}
