import request from '@/utils/request'



export function queryDs() {
  return request({
    url: '/gcode/code/queryDs',
    method: 'get'
  })
}


export function queryTableList(params) {
  return request({
    url: '/gcode/code/queryTableList',
    method: 'get',
    params:params
  })
}

export function updateTableCfg(data) {
  return request({
    url: '/gcode/code/updateTableCfg',
    method: 'post',
    data:data
  })
}


export function codeCreate(params) {
  return request({
    url: '/gcode/code/codeCreate',
    method: 'get',
    params: params,
    responseType: 'arraybuffer'
  })
}

export function addDataSource(data) {
  return request({
    url: '/gcode/code/addDataSource',
    method: 'post',
    data:data
  })
}

export function delDataSource(params) {
  return request({
    url: '/gcode/code/delDataSource',
    method: 'delete',
    params:params
  })
}

export function checkDataSource(data) {
  return request({
    url: '/gcode/code/checkDataSource',
    method: 'post',
    data:data
  })
}
