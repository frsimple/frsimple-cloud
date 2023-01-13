<template>
  <div>
    <div class="sp-role-left">
      <t-card :bordered="false">
        <div class="sp-role-left-header">
          <t-row :gutter="10" justify="end">
            <t-col :span="2" :offset="8">
              <t-input
                placeholder="请输入登录账号/昵称"
                type="search"
                clearable
                v-model="params.name"
                @clear="clearName"
                @enter="firstFetch"
              ></t-input>
            </t-col>
            <t-col :span="1">
              <t-button theme="default" variant="outline" @click="firstFetch">查询</t-button>
            </t-col>
          </t-row>
        </div>
        <t-table
          row-key="username"
          :data="data"
          :max-height="'calc(98vh - 235px)'"
          :columns="columns"
          :table-layout="'fixed'"
          :pagination="pagination"
          @page-change="onPageChange"
          :loading="dataLoading"
          :loadingProps="{ size: '23px', text: '加载中...' }"
        >
          <template #operation="{ row }">
            <t-button size="small" @click="userOut(row)" variant="outline" theme="danger">踢他下线</t-button>
          </template>
        </t-table>
      </t-card>
    </div>
  </div>
</template>

<script lang="ts">
export default {
  name: 'ListBase',
};
</script>

<script setup lang="ts">
import { ref, onMounted, computed, reactive } from 'vue';
import { MessagePlugin, DialogPlugin } from 'tdesign-vue-next';
import { tokenList, userLogout } from '@/api/system/auth';

const firstFetch = async () => {
  pagination.value.current = 1;
  await fetchData();
};

//左侧角色菜单列表数据start
const data = ref([]);
const columns = [
  {
    width: 120,
    colKey: 'clientId',
    title: '客户端用户',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'username',
    title: '登录用户',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'nickname',
    title: '用户昵称',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'loginDate',
    title: '登录时间',
    align: 'center',
  },
  {
    width: 100,
    colKey: 'tiems',
    title: '有效期(s)',
  },
  {
    colKey: 'operation',
    title: '操作',
    width: 100,
    cell: 'operation',
    fixed: 'right',
  },
];
const dataLoading = ref(false);
const pagination = ref({
  pageSize: 20,
  total: 0,
  current: 1,
});
const params = reactive({
  name: '',
});
const onPageChange = async (pageInfo) => {
  pagination.value.current = pageInfo.current;
  pagination.value.pageSize = pageInfo.pageSize;
  await fetchData();
};
const clearName = async () => {
  pagination.value.current = 1;
  params.name = '';
  await fetchData();
};
const userOut = async (row) => {
  const confirmDia = DialogPlugin({
    header: '下线提醒',
    body: '是否踢(' + row.nickname + '-' + row.username + ')下线？',
    confirmBtn: '确定',
    //cancelBtn: '取消',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      userLogout({
        token: row.token,
      })
        .then((res) => {
          if (res.code === 0) {
            MessagePlugin.success('已踢下线');
            fetchData();
          } else {
            MessagePlugin.error('操作失败：' + res.msg);
          }
        })
        .catch((error) => {
          MessagePlugin.error('操作失败：');
        });
    },
    onClose: ({ e, trigger }) => {
      confirmDia.hide();
    },
  });
};
const fetchData = async () => {
  data.value = [];
  dataLoading.value = true;
  try {
    let res = await tokenList({
      size: pagination.value.pageSize,
      current: pagination.value.current,
      name: params.name,
    });
    if (res.code === 0) {
      data.value = res.data.tokenDtos;
      pagination.value.total = res.data.total;
    }
  } catch (er) {
  } finally {
    dataLoading.value = false;
  }
};
//左侧角色菜单列表数据end

//vue的api
onMounted(async () => {
  //await fetchData();
  await fetchData();
});
</script>

<style lang="less" scoped>
@import '@/style/variables';
.menu-active {
  color: var(--td-brand-color) !important;
}
.menu-unactive {
  color: var(--tdvns-text-color-primary) !important;
}
.menu-text {
  vertical-align: middle;
}
.sp-role-left {
  border-radius: 8px;
  .sp-role-left-header {
    padding-bottom: 30px;
  }
}
</style>
