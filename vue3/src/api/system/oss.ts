import request from '@/utils/request'

//修改oss信息
export function addOrUpdateOss(data) {
  return request({
    url: '/center/oss/saveOrUpdate',
    method: 'post',
    data: data
  })
}

//查询oss信息
export function getOssInfo(type) {
  return request({
    url: '/center/oss/' + type,
    method: 'get',
  })
}

//查询oss信息
export function listFiles(params) {
  return request({
    url: '/center/oss/listFiles/' + params.type,
    method: 'get',
    params: {
      prefix: params.prefix
    }
  })
}

//下载附件
export function downloadFile(params) {
  return request({
    url: '/center/oss/downloadFile/' + params.type,
    method: 'get',
    params: {
      key: params.key
    }
  })
}

//获取附件下载链接
export function downloadFileLink(params) {
  return request({
    url: '/center/oss/downloadFileLink/' + params.type,
    method: 'get',
    params: {
      key: params.key
    }
  })
}
