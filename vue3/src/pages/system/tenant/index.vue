<template>
  <div>
    <div class="sp-role-left">
      <t-card :bordered="false">
        <div class="sp-role-left-header">
          <t-row>
            <t-col :span="6">
              <t-button v-if="authAdd" @click="addRow">新增租户</t-button>
            </t-col>
            <t-col :span="6">
              <t-row :gutter="10">
                <t-col :flex="1" :span="6" :offset="4">
                  <t-input
                    placeholder="请输入租户名称"
                    type="search"
                    clearable
                    v-model="params.name"
                    @clear="clearName"
                    @enter="firstFetch"
                  ></t-input>
                </t-col>
                <t-col :flex="1" :span="1">
                  <t-button theme="default" variant="outline" @click="firstFetch">查询</t-button>
                </t-col>
              </t-row>
            </t-col>
          </t-row>
        </div>
        <t-table
          row-key="id"
          :data="data"
          :max-height="tableHeight"
          :columns="columns"
          :table-layout="'fixed'"
          :pagination="pagination"
          @page-change="onPageChange"
          :loading="dataLoading"
          :loadingProps="{ size: '23px', text: '加载中...' }"
        >
          <template #operation="{ row }">
            <t-button v-if="authEdit" size="small" variant="outline" theme="default" @click="editRow(row)"
              >修改</t-button
            >
            <t-button v-if="authDel" size="small" variant="outline" theme="danger" @click="delRow(row)">删除</t-button>
          </template>
        </t-table>
      </t-card>
    </div>
    <!-- 新增/修改角色 -->
    <t-dialog
      v-model:visible="visibleModal"
      width="900"
      :closeOnOverlayClick="false"
      :header="opt === 'add' ? '新增客户端用户' : '修改客户端用户'"
      mode="modal"
      draggable
      :confirm-btn="saveBtn"
      :on-confirm="onSubmit"
    >
      <template #body>
        <t-form ref="form" :label-align="'top'" :data="tenantForm" :layout="'inline'" :rules="rules">
          <t-form-item label="租户名称" name="name">
            <t-input v-model="tenantForm.name" :style="{ width: '400px' }" placeholder="请输入租户名称"></t-input>
          </t-form-item>
          <t-form-item label="租户电话" name="phone">
            <t-input v-model="tenantForm.phone" :style="{ width: '400px' }" placeholder="请输入租户电话"></t-input>
          </t-form-item>
          <t-form-item label="租户邮箱" name="email">
            <t-input v-model="tenantForm.email" :style="{ width: '400px' }" placeholder="请输入租户邮箱"></t-input>
          </t-form-item>
          <t-form-item label="租户地址" name="address">
            <t-input v-model="tenantForm.address" :style="{ width: '400px' }" placeholder="请输入租户地址"></t-input>
          </t-form-item>
        </t-form>
      </template>
    </t-dialog>
  </div>
</template>

<script lang="ts">
export default {
  name: 'ListTenant',
};
</script>

<script setup lang="ts">
import { ref, onMounted, computed, reactive, getCurrentInstance } from 'vue';
import { MessagePlugin, DialogPlugin } from 'tdesign-vue-next';
import { tenantList, addTenant, editTenant, delTenant, getTenant } from '@/api/system/tenant';

import { useUserStore } from '@/store';
//获取table全局高度
const tableHeight = getCurrentInstance().appContext.config.globalProperties.$tableHeight;

//权限控制
const userStore = useUserStore();
const authAdd = computed(() => userStore.roles.includes('system:tenant:add'));
const authEdit = computed(() => userStore.roles.includes('system:tenant:edit'));
const authDel = computed(() => userStore.roles.includes('system:tenant:del'));

const firstFetch = async () => {
  pagination.value.current = 1;
  await fetchData();
};

//新增/修改弹窗start
const visibleModal = ref(false);
const tenantForm = reactive({
  id: '',
  name: '',
  phone: '',
  email: '',
  address: '',
});
const form = ref(null);
const saveBtn = reactive({
  content: '保存',
  loading: false,
});
const idValidator = async (val) => {
  if (opt.value === 'add' && val) {
    let res = await getTenant({
      name: val,
    });
    if (res.data.length != 0) {
      return { result: false, message: '租户名称不能重复', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const rules = {
  name: [{ required: true, message: '请输入租户名称', type: 'error' }, { validator: idValidator }],
  phone: [
    { required: true, message: '请输入租户电话', type: 'error' },
    { telnumber: true, message: '请输入正确的手机号码' },
  ],
  email: [
    { required: true, message: '请输入租户邮箱', type: 'error' },
    { email: { ignore_max_length: true }, message: '请输入正确的邮箱地址' },
  ],
  address: [{ required: true, message: '请输入租户地址', type: 'error' }],
};
const onSubmit = async () => {
  let result = await form.value.validate();
  if (typeof result !== 'object' && result) {
    saveBtn.content = '保存中...';
    saveBtn.loading = true;
    let submitForm = {
      name: tenantForm.name,
      phone: tenantForm.phone,
      email: tenantForm.email,
      address: tenantForm.address,
      id: null,
    };
    if (opt.value === 'add') {
      submitForm.id = tenantForm.id;
      try {
        let result1 = await addTenant(submitForm);
        if (result1.code === 0) {
          visibleModal.value = false;
          await fetchData();
          MessagePlugin.success('保存成功');
        } else {
          MessagePlugin.error('保存失败：' + result1.msg);
        }
      } catch (error) {
        MessagePlugin.error('保存失败');
      } finally {
        saveBtn.content = '保存';
        saveBtn.loading = false;
      }
    } else {
      submitForm.id = tenantForm.id;
      try {
        let result1 = await editTenant(submitForm);
        if (result1.code === 0) {
          visibleModal.value = false;
          fetchData();
          MessagePlugin.success('保存成功');
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
  }
};
//新增/修改弹窗end

//左侧角色菜单列表数据start
const data = ref([]);
const columns = [
  {
    width: 140,
    colKey: 'id',
    title: '租户ID',
  },
  {
    width: 220,
    colKey: 'name',
    title: '租户名称',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'phone',
    title: '电话',
  },
  {
    width: 180,
    colKey: 'email',
    title: '邮箱',
  },
  {
    width: 240,
    colKey: 'address',
    title: '地址',
    ellipsis: true,
  },
  // {
  //   width: 200,
  //   colKey: 'createtime',
  //   title: '创建时间',
  // },
  {
    colKey: 'operation',
    title: '操作',
    width: 200,
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
  params.name = '';
  pagination.value.current = 1;
  await fetchData();
};
const opt = ref('add');
const addRow = async () => {
  opt.value = 'add';
  form.value.reset();
  tenantForm.id = '';
  visibleModal.value = true;
};
const editRow = async (row) => {
  opt.value = 'edit';
  form.value.reset();
  tenantForm.id = row.id;
  tenantForm.name = row.name;
  tenantForm.phone = row.phone;
  tenantForm.email = row.email;
  tenantForm.address = row.address;
  visibleModal.value = true;
};
const delRow = async (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确认删除(' + row.name + ')租户？',
    confirmBtn: '继续删除',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      delTenant(row.id)
        .then((res) => {
          if (res.code === 0) {
            fetchData();
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

const fetchData = async () => {
  data.value = [];
  dataLoading.value = true;
  try {
    let res = await tenantList({
      size: pagination.value.pageSize,
      current: pagination.value.current,
      name: params.name,
    });
    if (res.code === 0) {
      data.value = res.data.records;
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
