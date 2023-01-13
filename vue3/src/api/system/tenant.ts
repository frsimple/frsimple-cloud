import request from '@/utils/request'

//查询机构列表
export function tenantList(params) {
  return request({
    url: '/center/tenant/list',
    method: 'get',
    params: params
  })
}



//新增机构
export function addTenant(data) {
  return request({
    url: '/center/tenant/addTenant',
    method: 'post',
    data: data
  })
}

//修改机构
export function editTenant(data) {
  return request({
    url: '/center/tenant/editTenant',
    method: 'post',
    data: data
  })
}

//删除机构
export function delTenant(id) {
  return request({
    url: '/center/tenant/delTenant/' + id,
    method: 'delete',
  })
}

//根据name查询机构
export function getTenant(params) {
  return request({
    url: '/center/tenant/getTenant',
    method: 'get',
    params: params
  })
}
