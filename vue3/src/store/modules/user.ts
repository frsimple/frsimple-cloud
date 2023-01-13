import { defineStore } from 'pinia';
import { TOKEN_NAME } from '@/config/global';
import { store } from '@/store';
import { loginByUserName, getCurUserInfo, logout, loginByUserPhone } from '@/api/system/auth';

const InitUserInfo = {
  roles: [],
  user: null
};

export const useUserStore = defineStore('user', {
  state: () => ({
    token: localStorage.getItem(TOKEN_NAME), // 默认token不走权限
    userInfo: InitUserInfo,
  }),
  getters: {
    roles: (state) => {
      return state.userInfo?.roles;
    },
    curUser: (state) => {
      return state.userInfo?.user;
    }
  },
  actions: {
    async login(userInfo: Record<string, unknown>) {
      try {
        const res = await loginByUserName(userInfo);
        this.token = res.access_token;
        localStorage.setItem(TOKEN_NAME, res.access_token)
        return {
          code: 0,
          msg: '登录成功，即将进入系统...'
        }
      } catch (err) {
        throw err;
      }
    },
    async loginByPhone(userInfo: Record<string, unknown>) {
      try {
        const res = await loginByUserPhone(userInfo);
        this.token = res.access_token;
        localStorage.setItem(TOKEN_NAME, res.access_token)
        return {
          code: 0,
          msg: '登录成功，即将进入系统...'
        }
      } catch (err) {
        throw err;
      }
    },
    async getUserInfo() {
      try {
        let res = await getCurUserInfo()
        this.userInfo = res.data;
      } catch (error) {
        throw error
      }
    },
    async logout() {
      await logout()
      localStorage.removeItem(TOKEN_NAME);
      localStorage.removeItem('tabRouterList')
      this.token = '';
      this.userInfo = InitUserInfo;
    },
    async removeToken() {
      this.token = '';
    },
  },
});

export function getUserStore() {
  return useUserStore(store);
}
