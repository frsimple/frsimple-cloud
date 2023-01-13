<template>
  <div>
    <div class="sp-role-left">
      <t-card :bordered="false">
        <div class="sp-role-left-header">
          <t-row>
            <!-- <t-col :span="6">
              <t-button v-if="authAdd" @click="addRow">新增机构</t-button>
            </t-col> -->
            <t-col :span="6" :offset="6">
              <t-row :gutter="10">
                <t-col :flex="1" :span="6" :offset="4">
                  <!-- <t-input
                    placeholder="请输入机构名称"
                    type="search"
                    clearable
                    v-model="params.name"
                    @clear="clearName"
                    @enter="firstFetch"
                  ></t-input> -->
                  <t-select
                    v-model="params.name"
                    filterable
                    clearable
                    @clear="clearName"
                    :onChange="changeTenant"
                    placeholder="请选择关联机构"
                    :on-search="remoteMethod2"
                    :loading="tenantLoad1"
                    :options="tenantD1"
                  />
                </t-col>
                <t-col :flex="1" :span="1">
                  <t-button theme="default" variant="outline" @click="firstFetch">查询</t-button>
                </t-col>
              </t-row>
            </t-col>
          </t-row>
        </div>
        <t-enhanced-table
          row-key="id"
          :data="data"
          :max-height="'calc(98vh - 235px)'"
          :columns="columns"
          :tree="{
            childrenKey: 'children',
            treeNodeColumnIndex: 0,
          }"
          :table-layout="'fixed'"
          :loading="dataLoading"
          :loadingProps="{ size: '23px', text: '加载中...' }"
        >
          <template #operation="{ row }">
            <t-button v-if="authAdd" size="small" variant="outline" theme="primary" @click="addRow(row)"
              >新增下级组织</t-button
            >
            <t-button
              v-if="authEdit"
              :disabled="row.parentId === '0'"
              size="small"
              variant="outline"
              theme="default"
              @click="editRow(row)"
              >修改</t-button
            >
            <t-button
              v-if="authDel"
              :disabled="row.parentId === '0' || (row.children && row.children.length != 0)"
              size="small"
              variant="outline"
              theme="danger"
              @click="delRow(row)"
              >删除</t-button
            >
          </template>
        </t-enhanced-table>
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
          <t-form-item v-if="opt === 'edit'" label="组织编号" name="id">
            <t-input v-model="tenantForm.id" :style="{ width: '400px' }" :disabled="true"></t-input>
          </t-form-item>
          <t-form-item label="上级组织" name="parentname">
            <t-input v-model="tenantForm.parentname" :style="{ width: '400px' }" :disabled="true"></t-input>
          </t-form-item>
          <t-form-item label="所属机构" name="tenantname">
            <t-input v-model="tenantForm.tenantname" :style="{ width: '400px' }" :disabled="true"></t-input>
          </t-form-item>
          <t-form-item label="组织名称" name="name">
            <t-input v-model="tenantForm.name" :style="{ width: '400px' }" placeholder="请输入组织名称"></t-input>
          </t-form-item>
          <t-form-item label="排序" name="sort">
            <t-input v-model="tenantForm.sort" :style="{ width: '400px' }" placeholder="请输入排序"></t-input>
          </t-form-item>
          <!-- <t-form-item label="机构邮箱" name="email">
            <t-input v-model="tenantForm.email" :style="{ width: '400px' }" placeholder="请输入机构邮箱"></t-input>
          </t-form-item>
          <t-form-item label="机构地址" name="address">
            <t-input v-model="tenantForm.address" :style="{ width: '400px' }" placeholder="请输入机构地址"></t-input>
          </t-form-item> -->
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
import { ref, onMounted, computed, reactive } from 'vue';
import { MessagePlugin, DialogPlugin } from 'tdesign-vue-next';
import { queryOrganTree, addOrgan, editOrgan, delOrgan, getOrgan } from '@/api/system/organ';
import { tenantList } from '@/api/system/tenant';

import { useUserStore } from '@/store';
//权限控制
const userStore = useUserStore();
const authAdd = computed(() => userStore.roles.includes('system:organ:add'));
const authEdit = computed(() => userStore.roles.includes('system:organ:edit'));
const authDel = computed(() => userStore.roles.includes('system:organ:del'));

const firstFetch = async () => {
  pagination.value.current = 1;
  await fetchData();
};

const changeTenant = async (val) => {
  if (val) {
    pagination.value.current = 1;
    params.name = val;
    await fetchData();
  }
};
const tenantD1 = ref([]);
const tenantLoad1 = ref(false);
const remoteMethod2 = async (search) => {
  if (search) {
    tenantLoad1.value = true;
    tenantD1.value = [];
    let res = await tenantList({
      name: search,
    });
    res.data.records.forEach((row) => {
      tenantD1.value.push({
        label: row.name,
        value: row.id,
      });
    });
    tenantLoad1.value = false;
  }
};

//新增/修改弹窗start
const visibleModal = ref(false);
const tenantForm = reactive({
  id: '',
  name: '',
  parentid: '',
  parentname: '',
  sort: '',
  tenantid: '',
  tenantname: '',
});
const form = ref(null);
const saveBtn = reactive({
  content: '保存',
  loading: false,
});
const rules = {
  name: [{ required: true, message: '请输入组织名称', type: 'error' }],
  sort: [{ required: true, message: '请输入排序', type: 'error' }],
};
const onSubmit = async () => {
  let result = await form.value.validate();
  if (typeof result !== 'object' && result) {
    saveBtn.content = '保存中...';
    saveBtn.loading = true;
    let submitForm = {
      name: tenantForm.name,
      parentid: tenantForm.parentid,
      sort: tenantForm.sort,
      tenantid: tenantForm.tenantid,
      id: null,
    };
    if (opt.value === 'add') {
      try {
        let result1 = await addOrgan(submitForm);
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
        let result1 = await editOrgan(submitForm);
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
    width: 220,
    colKey: 'name',
    title: '组织名称',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'id',
    title: '组织编号',
  },
  {
    width: 120,
    colKey: 'tenantname',
    title: '所属机构',
  },
  {
    width: 120,
    colKey: 'createtime',
    title: '创建时间',
  },
  // {
  //   width: 100,
  //   colKey: 'sort',
  //   title: '排序',
  //   ellipsis: true,
  // },
  {
    colKey: 'operation',
    title: '操作',
    width: 200,
    cell: 'operation',
    fixed: 'right',
    align: 'center',
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
const addRow = async (row) => {
  opt.value = 'add';
  form.value.reset();
  tenantForm.id = '';
  tenantForm.parentid = row.id;
  tenantForm.tenantid = row.tenantid;
  tenantForm.parentname = row.parentname;
  tenantForm.tenantname = row.tenantname;
  visibleModal.value = true;
};
const editRow = async (row) => {
  opt.value = 'edit';
  form.value.reset();
  tenantForm.id = row.id;
  tenantForm.name = row.name;
  tenantForm.parentid = row.parentid;
  tenantForm.sort = row.sort;
  tenantForm.tenantid = row.tenantid;
  tenantForm.parentname = row.parentname;
  tenantForm.tenantname = row.tenantname;
  visibleModal.value = true;
};
const delRow = async (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确认删除(' + row.name + ')组织？',
    confirmBtn: '继续删除',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      delOrgan(row.id)
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
    let res = await queryOrganTree({
      tenantId: params.name,
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
