import request from '@/utils/request'



//保存邮箱配置信息
export function saveOrUpdate(data) {
  return request({
    url: '/center/email/saveOrUpdate',
    method: 'post',
    data: data
  })
}

//发送邮件
export function sendEmail(data) {
  return request({
    url: '/center/email/sendEmail',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

//查询邮件配置信息
export function emailCfg() {
  return request({
    url: '/center/email/emailCfg',
    method: 'get',
  })
}
