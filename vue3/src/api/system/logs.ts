import request from '@/utils/request'


//查询角色列表
export function logsList(params) {
  return request({
    url: '/center/logs/list',
    method: 'get',
    params: params
  })
}
