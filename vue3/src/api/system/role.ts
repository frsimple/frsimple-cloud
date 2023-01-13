import request from '@/utils/request'


//查询角色列表
export function roleTreeAll() {
  return request({
    url: '/center/menu/roleTreeAll',
    method: 'get'
  })
}

//查询角色列表
export function roleTree(params) {
  return request({
    url: '/center/role/roleMenu',
    method: 'get',
    params: params
  })
}

//查询角色列表
export function roleList(params) {
  return request({
    url: '/center/role/list',
    method: 'get',
    params: params
  })
}



//新增角色
export function addRoleInfo(data) {
  return request({
    url: '/center/role/addRole',
    method: 'post',
    data: data
  })
}

//修改角色
export function editRoleInfo(data) {
  return request({
    url: '/center/role/editRole',
    method: 'post',
    data: data
  })
}

//删除角色
export function delRoleInfo(params) {
  return request({
    url: '/center/role/delRole',
    method: 'delete',
    params: params
  })
}


//保存角色权限
export function saveRoleMenu(data) {
  return request({
    url: '/center/role/saveRoleMenu',
    method: 'post',
    data: data
  })
}
