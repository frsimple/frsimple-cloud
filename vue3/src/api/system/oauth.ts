import request from '@/utils/request'

//查询角色列表
export function oauthList(params) {
  return request({
    url: '/center/oauth/list',
    method: 'get',
    params: params
  })
}



//新增客户端用户
export function addClient(data) {
  return request({
    url: '/center/oauth/addClient',
    method: 'post',
    data: data
  })
}

//修改客户端用户
export function editClient(data) {
  return request({
    url: '/center/oauth/editClient',
    method: 'post',
    data: data
  })
}

//删除客户端用户
export function delClient(params) {
  return request({
    url: '/center/oauth/delClient',
    method: 'delete',
    params: params
  })
}

//根据id查询客户端用户
export function getClient(id) {
  return request({
    url: '/center/oauth/getClient/' + id,
    method: 'get',
  })
}
