import { ConfigEnv, UserConfig, loadEnv } from 'vite';
import compressPlugin from "vite-plugin-compression";
import { viteMockServe } from 'vite-plugin-mock';
import createVuePlugin from '@vitejs/plugin-vue';
import vueJsx from '@vitejs/plugin-vue-jsx';
import svgLoader from 'vite-svg-loader';
import proxy from './src/config/proxy'
// import commonjs from 'rollup-plugin-commonjs';
// import externalGlobals from 'rollup-plugin-external-globals';

import path from 'path';

const CWD = process.cwd();

// https://vitejs.dev/config/
export default ({ mode }: ConfigEnv): UserConfig => {
  const { VITE_BASE_URL } = loadEnv(mode, CWD);
  const TimeStamp  = new Date().getTime();
  return {
    base: VITE_BASE_URL,
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './src'),
      },
    },
    build: {
      outDir: 'vuedist',
      rollupOptions: {
        output: {
          entryFileNames: `assets/[name].${TimeStamp}.js`,
          chunkFileNames: `assets/[name].${TimeStamp}.js`,
          assetFileNames: `assets/[name].${TimeStamp}.[ext]`
        }
      }
    },

    plugins: [
      createVuePlugin(),
      vueJsx(),
      viteMockServe({
        mockPath: 'mock',
        localEnabled: false,
      }),
      svgLoader(),
      compressPlugin({
        ext: ".gz",
        deleteOriginFile: false
      })
    ],

    server: {
      port: 3002,
      host: '0.0.0.0',
      proxy: {
        "/auth": {
          target: proxy[mode].host,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/auth/, "auth"),
        },
        "/code": {
          target: proxy[mode].host,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/code/, "code"),
        },
        "/sms": {
          target: proxy[mode].host,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/sms/, "sms"),
        },
        "/center": {
          target: proxy[mode].host,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/center/, "center"),
        },
        "/gcode": {
          target: proxy[mode].host,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/gcode/, "gcode"),
        },
      },
    },
  };
};
