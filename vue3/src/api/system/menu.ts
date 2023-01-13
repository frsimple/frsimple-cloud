import request from '@/utils/request'


//获取菜单根据固定条件
export function getMenuList(params) {
  return request({
    url: '/center/menu/menuList',
    method: 'get',
    params: params
  })
}

//查询菜单权限信息
export function getBtnList(params) {
  return request({
    url: '/center/menu/btnList',
    method: 'get',
    params: params
  })
}

//查询菜单树，所有数据
export function getTreeMenuAll() {
  return request({
    url: '/center/menu/treeAll',
    method: 'get'
  })
}


//新增菜单
export function addMenuInfo(data) {
  return request({
    url: '/center/menu/addMenu',
    method: 'post',
    data: data
  })
}

//修改菜单
export function editMenuInfo(data) {
  return request({
    url: '/center/menu/editMenu',
    method: 'post',
    data: data
  })
}

//删除菜单信息
export function delMenuInfo(params) {
  return request({
    url: '/center/menu/delMenu',
    method: 'delete',
    params: params
  })
}


//新增菜单按钮权限
export function addBtnMenuInfo(data) {
  return request({
    url: '/center/menu/addBtnMenu',
    method: 'post',
    data: data
  })
}

//修改菜单按钮权限
export function editBtnMenuInfo(data) {
  return request({
    url: '/center/menu/editBtnMenu',
    method: 'post',
    data: data
  })
}

//删除菜单按钮权限
export function delBtnMenuInfo(params) {
  return request({
    url: '/center/menu/delBtnMenu',
    method: 'delete',
    params: params
  })
}
