import request from '@/utils/request'

const secret = "6ceb70f6cca98475ae91bb8aa9657b6d"

export function loginByUserName(data) {
  return request({
    url: '/auth/oauth/token',
    method: 'post',
    params: data,
    headers: {
      isAuth: false,
      sp: secret,
      'grant_type': 'password'
    }
  })
}

export function loginByUserPhone(data) {
  return request({
    url: '/auth/oauth/token',
    method: 'post',
    params: data,
    headers: {
      isAuth: false,
      sp: secret,
      'grant_type': 'sms_code'
    }
  })
}

export function sendSms(params) {
  return request({
    url: '/sms',
    method: 'get',
    params: params,
    headers: {
      isAuth: false,
    }
  })
}

export function getCurUserInfo() {
  return request({
    url: '/center/user/info',
    method: 'get'
  })
}

export function getCurUserMenu() {
  return request({
    url: '/center/user/menu',
    method: 'get'
  })
}


export function logout() {
  return request({
    url: '/auth/sp/logout',
    method: 'get'
  })
}


export function tokenList(params) {
  return request({
    url: '/auth/sp/list',
    method: 'get',
    params: params
  })
}

export function userLogout(params) {
  return request({
    url: '/auth/sp/userLogout',
    method: 'get',
    params: params
  })
}
