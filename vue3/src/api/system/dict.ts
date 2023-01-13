import request from '@/utils/request'



//查询字典列表
export function listDict(params) {
  return request({
    url: '/center/dict/list',
    method: 'get',
    params: params
  })
}

//查询字典列表
export function listDict1(params) {
  return request({
    url: '/center/dict/list1',
    method: 'get',
    params: params
  })
}

//查询字典项
export function dictValues(params) {
  return request({
    url: '/center/dict/values',
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



//新增字典
export function addDict(data) {
  return request({
    url: '/center/dict/addDict',
    method: 'post',
    data: data
  })
}

//修改字典
export function editDict(data) {
  return request({
    url: '/center/dict/editDict',
    method: 'post',
    data: data
  })
}

//删除字典
export function delDict(params) {
  return request({
    url: '/center/dict/delDict',
    method: 'delete',
    params: params
  })
}


//刷新字典缓存
export function refDictCache() {
  return request({
    url: '/center/dict/refDictCache',
    method: 'get'
  })
}