import { MessagePlugin } from 'tdesign-vue-next';
import NProgress from 'nprogress'; // progress bar
import 'nprogress/nprogress.css'; // progress bar style

import { getPermissionStore, getUserStore } from '@/store';
import router from '@/router';

const permissionStore = getPermissionStore();
const userStore = getUserStore();

NProgress.configure({ showSpinner: false });

const { whiteListRouters } = permissionStore;

router.beforeEach(async (to, from, next) => {
  NProgress.start();
  const { token } = userStore;
  if (token) {
    if (to.path === '/login') {
      //userStore.logout();
      //permissionStore.restore();
      next();
      return;
    }
    const { curUser } = userStore;

    if (curUser) {
      next()
    } else {
      try {
        await userStore.getUserInfo();
        // const { routers } = permissionStore
        // if (routers && routers.length === 0) {
        //   await permissionStore.initRoutes();
        //   next({ ...to, replace: true })
        // } else {
        //   next()
        // }
        await permissionStore.initRoutes();
        if (router.hasRoute(to.name)) {
          next()
        } else {
          if (to.matched && to.matched.length == 0) {
            next({ ...to, replace: true })
          } else {
            next(`/`);
          }
        }
      } catch (error) {
        next(`/login?redirect=${to.path}`);
        NProgress.done();
      }
    }
  } else {
    if (whiteListRouters.indexOf(to.path) !== -1) {
      next();
    } else {
      next(`/login?redirect=${to.path}`);
    }
    NProgress.done();
  }
});

router.afterEach(() => {
  NProgress.done();
});
