import request from '@/utils/request'



export function queryOrganTree(params) {
  return request({
    url: '/center/branch/queryOrganTree',
    method: 'get',
    params:params
  })
}

export function getOrgan(id) {
  return request({
    url: '/center/branch/getOrgan/'+id,
    method: 'get'
  })
}

export function addOrgan(data) {
  return request({
    url: '/center/branch/addOrgan',
    method: 'post',
    data:data
  })
}

export function editOrgan(data) {
  return request({
    url: '/center/branch/editOrgan',
    method: 'post',
    data:data
  })
}

export function delOrgan(id) {
  return request({
    url: '/center/branch/delOrgan/'+id,
    method: 'delete',
  })
}
