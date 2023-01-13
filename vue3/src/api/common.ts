import request from '@/utils/request'

//查询字典项
export function dicVals(code) {
  return request({
    url: '/center/dict/vals/' + code,
    method: 'get'
  })
}

