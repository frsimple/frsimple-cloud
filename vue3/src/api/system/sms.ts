import request from '@/utils/request'



//保存短信配置信息
export function saveOrUpdate(data) {
  return request({
    url: '/center/sms/saveOrUpdate',
    method: 'post',
    data: data
  })
}

//查询短信配置信息
export function smsConfig(type) {
  return request({
    url: '/center/sms/' + type,
    method: 'get',
  })
}
