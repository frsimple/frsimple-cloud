<template>
  <div class="container">
    <div class="sp-role-left">
      <t-card :bordered="false">
        <div class="sp-role-left-header">
          <t-row :gutter="10" justify="end">
            <t-col :span="2" :offset="2">
              <t-select
                v-model="params.dataId"
                :options="optionsData"
                clearable
                @change="statusChange"
                @clear="clearName(0)"
                placeholder="请选择数据源"
              />
            </t-col>
            <t-col :span="2">
              <t-input
                placeholder="请输入数据库表名"
                type="search"
                clearable
                v-model="params.tableName"
                @clear="clearName(1)"
                @enter="firstFetch"
              ></t-input>
            </t-col>
            <t-col :span="2">
              <t-button theme="default" variant="outline" @click="firstFetch" :disabled="!params.dataId">查询</t-button>
              <t-button theme="primary" @click="cfgDs"
                ><template #icon> <t-icon name="setting" /> </template>数据源配置</t-button
              >
            </t-col>
          </t-row>
        </div>
        <t-table
          row-key="tableName"
          :data="data"
          :max-height="'calc(98vh - 175px)'"
          :columns="columns"
          :loading="dataLoading"
          :loadingProps="{ size: '23px', text: '加载中...' }"
        >
          <template #operation="{ row }">
            <t-button size="small" variant="outline" theme="default" @click="initCfg(row)">配置</t-button>
            <t-button size="small" variant="outline" theme="primary" :disabled="!row.id" @click="createCode(row)"
              >生成代码</t-button
            >
          </template>
        </t-table>
      </t-card>
    </div>

    <!-- 修改配置项 -->
    <t-dialog
      v-model:visible="visibleModal"
      width="450"
      :closeOnOverlayClick="false"
      :header="'修改配置'"
      mode="modal"
      draggable
      :confirm-btn="saveBtn"
      :on-confirm="onSubmit"
    >
      <template #body>
        <t-form ref="form" :label-align="'top'" :data="cfgForm" :layout="'inline'" :rules="rules">
          <t-form-item label="表名" name="tablename">
            <t-input
              v-model="cfgForm.tablename"
              :style="{ width: '400px' }"
              placeholder="请输入表名"
              :disabled="true"
            ></t-input>
          </t-form-item>
          <t-form-item label="表前缀" name="fix">
            <t-input
              v-model="cfgForm.fix"
              :style="{ width: '400px' }"
              placeholder="请输入表前缀，生成自动去除"
            ></t-input>
          </t-form-item>
          <t-form-item label="包路径" name="pkg">
            <t-input v-model="cfgForm.pkg" :style="{ width: '400px' }" placeholder="请输入包路径"></t-input>
          </t-form-item>
          <t-form-item label="注释作者" name="auth">
            <t-input v-model="cfgForm.auth" :style="{ width: '400px' }" placeholder="请输入注释作者"></t-input>
          </t-form-item>
        </t-form>
      </template>
    </t-dialog>

    <!-- 数据源配置左侧弹框 -->
    <t-drawer
      v-model:visible="visible"
      header="数据源配置"
      :size="'800px'"
      :close-btn="true"
      :footer="false"
      :closeOnOverlayClick="false"
    >
      <p style="margin-bottom: 20px"><t-button theme="primary" @click="addDs">新增数据源</t-button></p>
      <t-table
        row-key="id"
        :data="data1"
        :max-height="tableHeight"
        :columns="columns1"
        bordered
        :loading="dataLoading1"
      >
        <template #operation="{ row }">
          <t-button size="small" variant="outline" theme="danger" @click="delDs(row)">删除</t-button>
        </template>
      </t-table>
    </t-drawer>

    <!-- 新增数据源 -->
    <t-dialog
      v-model:visible="visibleModal1"
      width="450"
      :closeOnOverlayClick="false"
      :header="'新增数据源'"
      mode="modal"
      draggable
      :confirm-btn="saveBtn1"
      :on-confirm="onSubmit1"
    >
      <template #body>
        <t-form ref="form1" :label-align="'top'" :data="cfgForm1" :layout="'inline'" :rules="rules1">
          <t-form-item label="数据源名称" name="name">
            <t-input v-model="cfgForm1.name" :style="{ width: '400px' }" placeholder="请输入数据源名称"></t-input>
          </t-form-item>
          <t-form-item label="链接地址" name="url">
            <t-textarea v-model="cfgForm1.url" :style="{ width: '400px' }" placeholder="请输入链接地址"></t-textarea>
          </t-form-item>
          <t-form-item label="用户名" name="user">
            <t-input v-model="cfgForm1.user" :style="{ width: '400px' }" placeholder="请输入用户名"></t-input>
          </t-form-item>
          <t-form-item label="密码" name="pwd">
            <t-input
              v-model="cfgForm1.pwd"
              type="password"
              :style="{ width: '400px' }"
              placeholder="请输入密码"
            ></t-input>
          </t-form-item>
        </t-form>
      </template>
    </t-dialog>
  </div>
</template>

<script lang="ts">
export default {
  name: 'ListBase',
};
</script>

<script setup lang="ts">
import { ref, onMounted, getCurrentInstance, reactive } from 'vue';
import { MessagePlugin, DialogPlugin } from 'tdesign-vue-next';
import {
  queryDs,
  queryTableList,
  updateTableCfg,
  codeCreate,
  addDataSource,
  delDataSource,
  checkDataSource,
} from '@/api/system/code';
//获取table全局高度
const tableHeight = getCurrentInstance().appContext.config.globalProperties.$tableHeight;
//生成代码
const createCode = async (row) => {
  let res = await codeCreate({
    id: row.id,
    tableComment: row.tableComment,
  });
  let blob = new Blob([res], { type: 'application/zip' });
  let filename = row.tableName + '.zip';
  let link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = filename;
  document.body.appendChild(link);
  link.click();
};

//数据源配置
const visible = ref(false);
const data1 = ref([]);
const dataLoading1 = ref(false);
const columns1 = [
  {
    width: 180,
    colKey: 'name',
    title: '数据源名称',
    ellipsis: true,
  },
  {
    width: 300,
    colKey: 'url',
    title: '链接地址',
    ellipsis: true,
  },
  {
    width: 80,
    colKey: 'user',
    title: '用户名',
    ellipsis: true,
  },
  {
    colKey: 'operation',
    title: '操作',
    width: 80,
    align: 'center',
    cell: 'operation',
    fixed: 'right',
  },
];
const cfgDs = async () => {
  visible.value = true;
  await initDataSource();
};
const addDs = () => {
  form1.value.reset();
  visibleModal1.value = true;
};
const form1 = ref(null);
const saveBtn1 = reactive({
  content: '保存',
  loading: false,
});
const rules1 = {
  name: [{ required: true, message: '请输入数据源名称', type: 'error' }],
  url: [{ required: true, message: '请输入链接地址', type: 'error' }],
  user: [{ required: true, message: '请输入用户名', type: 'error' }],
  pwd: [{ required: true, message: '请输入密码', type: 'error' }],
};
const cfgForm1 = reactive({
  name: '',
  url: '',
  user: '',
  pwd: '',
});
const visibleModal1 = ref(false);
const onSubmit1 = async () => {
  let result = await form1.value.validate();
  if (typeof result !== 'object' && result) {
    saveBtn1.content = '保存中...';
    saveBtn1.loading = true;
    let submitForm = {
      name: cfgForm1.name,
      url: cfgForm1.url,
      user: cfgForm1.user,
      pwd: cfgForm1.pwd,
    };
    try {
      let result1 = await addDataSource(submitForm);
      if (result1.code === 0) {
        visibleModal1.value = false;
        MessagePlugin.success('保存成功');
        await initDataSource();
      } else {
        MessagePlugin.error('保存失败：' + result1.msg);
      }
    } catch (error) {
      MessagePlugin.error('保存失败');
    } finally {
      saveBtn1.content = '保存';
      saveBtn1.loading = false;
    }
  }
};

const delDs = (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确定删除数据源(' + row.name + ')？',
    confirmBtn: '继续删除',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      delDataSource({
        id: row.id,
      })
        .then((res) => {
          if (res.code === 0) {
            initDataSource();
            MessagePlugin.success('删除成功');
          } else {
            MessagePlugin.error('删除失败：' + res.msg);
          }
        })
        .catch((error) => {
          MessagePlugin.error('删除失败');
        });
    },
    onClose: ({ e, trigger }) => {
      confirmDia.hide();
    },
  });
};
//数据源配置end
//修改配置项start
const initCfg = (row) => {
  form.value.reset();
  if (row.id) {
    cfgForm.id = row.id;
    cfgForm.tablename = row.tableName;
    cfgForm.fix = row.fix;
    cfgForm.pkg = row.pkg;
    cfgForm.auth = row.auth;
  } else {
    cfgForm.tablename = row.tableName;
  }
  visibleModal.value = true;
};
const form = ref(null);
const saveBtn = reactive({
  content: '保存',
  loading: false,
});
const rules = {
  auth: [{ required: true, message: '请输入注释作者', type: 'error' }],
  fix: [{ required: true, message: '请输入表前缀', type: 'error' }],
  pkg: [{ required: true, message: '请输入包路径', type: 'error' }],
};
const cfgForm = reactive({
  id: '',
  tablename: '',
  fix: '',
  pkg: '',
  auth: '',
});
const visibleModal = ref(false);
const onSubmit = async () => {
  let result = await form.value.validate();
  if (typeof result !== 'object' && result) {
    saveBtn.content = '保存中...';
    saveBtn.loading = true;
    let submitForm = {
      id: cfgForm.id,
      tablename: cfgForm.tablename,
      fix: cfgForm.fix,
      pkg: cfgForm.pkg,
      auth: cfgForm.auth,
      datasource: params.dataId,
    };
    try {
      let result1 = await updateTableCfg(submitForm);
      if (result1.code === 0) {
        visibleModal.value = false;
        MessagePlugin.success('保存成功');
        await fetchData();
      } else {
        MessagePlugin.error('保存失败：' + result1.msg);
      }
    } catch (error) {
      MessagePlugin.error('保存失败');
    } finally {
      saveBtn.content = '保存';
      saveBtn.loading = false;
    }
  }
};
//修改配置项end

const firstFetch = async () => {
  pagination.value.current = 1;
  await fetchData();
};

const optionsData = ref([]);
//左侧角色菜单列表数据start
const data = ref([]);
const columns = [
  {
    width: 180,
    colKey: 'tableComment',
    title: '表中文名称',
    ellipsis: true,
  },
  {
    width: 150,
    colKey: 'tableName',
    title: '表英文名称',
    ellipsis: true,
  },
  {
    width: 130,
    colKey: 'tableCollation',
    title: '排序规则',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'createTime',
    title: '创建时间',
    align: 'center',
  },
  {
    colKey: 'operation',
    title: '操作',
    width: 220,
    align: 'center',
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
  dataId: '',
  tableName: '',
});
const onPageChange = async (pageInfo) => {
  pagination.value.current = pageInfo.current;
  pagination.value.pageSize = pageInfo.pageSize;
  await fetchData();
};
const statusChange = async (value) => {
  params.dataId = value;
  if (params.dataId) {
    await fetchData();
  } else {
    data.value = [];
  }
};
const clearName = async (index) => {
  if (index === 0) {
    params.dataId = '';
  } else if (index === 1) {
    params.tableName = '';
  }
  //pagination.value.current = 1;
  if (!params.dataId) {
    data.value = [];
  } else {
    await fetchData();
  }
};
const fetchData = async () => {
  data.value = [];
  dataLoading.value = true;
  try {
    let res = await queryTableList({
      dataId: params.dataId,
      tableName: params.tableName,
    });
    if (res.code === 0) {
      data.value = res.data;
      //pagination.value.total = res.data.total;
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
  await initDataSource();
});

//初始化数据源
const initDataSource = async () => {
  optionsData.value = [];
  data1.value = [];
  dataLoading1.value = true;
  let res = await queryDs();
  res.data.forEach((row) => {
    data1.value.push(row);
    optionsData.value.push({
      value: row.id,
      label: row.name,
    });
  });
  dataLoading1.value = false;
};
</script>

<style lang="less" scoped>
@import '@/style/variables';
.t-tag {
  cursor: pointer;
}
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
.container {
  position: relative;
}
</style>
