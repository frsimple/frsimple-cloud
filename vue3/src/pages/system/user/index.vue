<template>
  <div>
    <div class="sp-role-left">
      <t-card :bordered="false">
        <div class="sp-role-left-header">
          <t-row>
            <t-col :span="6">
              <t-button v-if="authAdd" @click="addRow">新增用户</t-button>
              <!-- <t-button @click="updateRow(0)" theme="default" :disabled="selectedRowKeys.length === 0"
                >关联角色</t-button
              >
              <t-button @click="updateRow(1)" theme="default" :disabled="selectedRowKeys.length === 0"
                >关联机构</t-button
              > -->
            </t-col>
            <t-col :span="6">
              <t-row :gutter="10">
                <t-col :flex="1" :span="2" :offset="1">
                  <t-select
                    placeholder="用户状态"
                    type="search"
                    clearable
                    :options="statusList"
                    v-model="params.status"
                    @clear="clearName(0)"
                    @change="statusChange"
                  ></t-select>
                </t-col>
                <t-col :flex="1" :span="4">
                  <t-select
                    v-model="params.tenant"
                    filterable
                    clearable
                    @clear="clearName(1)"
                    :onChange="changeTenant"
                    placeholder="请选择关联机构"
                    :on-search="remoteMethod2"
                    :loading="tenantLoad1"
                    :options="tenantD1"
                  />
                </t-col>
                <t-col :flex="1" :span="3">
                  <t-input
                    placeholder="请输入用户昵称"
                    type="search"
                    clearable
                    v-model="params.nickname"
                    @clear="clearName(2)"
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
          :max-height="'calc(98vh - 235px)'"
          :columns="columns"
          :table-layout="'fixed'"
          :pagination="pagination"
          :selected-row-keys="selectedRowKeys"
          @select-change="rehandleSelectChange"
          @page-change="onPageChange"
          :loading="dataLoading"
          :loadingProps="{ size: '23px', text: '加载中...' }"
        >
          <template #phone="{ row }">
            {{ row.phone + '/' + row.email }}
          </template>
          <template #status="{ row }">
            <t-tag shape="round" :theme="row.status === '0' ? 'primary' : 'warning'" variant="light" size="small">{{
              statusMap[row.status]
            }}</t-tag>
          </template>
          <template #operation="{ row }">
            <t-button size="small" variant="outline" theme="primary" @click="viewRow(row)">详情</t-button>
            <t-button v-if="authEdit" size="small" variant="outline" theme="default" @click="editRow(row)"
              >修改</t-button
            >
            <t-button v-if="authDel" size="small" variant="outline" theme="danger" @click="delRow(row)">删除</t-button>
            <t-dropdown :options="options" @click="clickHandler(row)" maxColumnWidth="100px">
              <t-button size="small" theme="default">更多</t-button>
            </t-dropdown>
          </template>
        </t-table>
      </t-card>
    </div>
    <!-- 新增/修改用户 -->
    <t-dialog
      v-model:visible="visibleModal"
      width="900"
      :closeOnOverlayClick="false"
      :header="opt === 'add' ? '新增用户' : '修改用户'"
      mode="modal"
      draggable
      :confirm-btn="saveBtn"
      :on-confirm="onSubmit"
    >
      <template #body>
        <t-form ref="form" :label-align="'top'" :data="userForm" :layout="'inline'" :rules="rules">
          <t-form-item label="关联机构" name="tenant">
            <t-select
              v-model="userForm.tenant"
              filterable
              placeholder="请选择关联机构"
              :on-search="remoteMethod"
              :loading="tenantLoad"
              :options="tenantD"
              :style="{ width: '400px' }"
            />
          </t-form-item>
          <t-form-item label="关联组织" name="organ" :style="{ width: '800px' }">
            <t-cascader
              v-model="userForm.organ"
              :keys="{ value: 'id', label: 'name' }"
              :options="organList"
              placeholder="请选择关联组织"
              check-strictly
              clearable
            />
          </t-form-item>
          <t-form-item label="关联角色" name="roles">
            <t-select
              v-model="userForm.roles"
              placeholder="请选择关联角色"
              :options="roleD"
              multiple
              :style="{ width: '400px' }"
            />
          </t-form-item>
          <t-form-item label="登录账号" name="username">
            <t-input v-model="userForm.username" :style="{ width: '400px' }" placeholder="请输入登录账号"></t-input>
          </t-form-item>
          <t-form-item v-if="!userForm.id" label="登录密码" name="password">
            <t-input
              v-model="userForm.password"
              :style="{ width: '400px' }"
              type="password"
              placeholder="请输入登录密码"
            ></t-input>
          </t-form-item>
          <t-form-item label="用户昵称" name="nickname">
            <t-input v-model="userForm.nickname" :style="{ width: '400px' }" placeholder="请输入用户昵称"></t-input>
          </t-form-item>
          <t-form-item label="手机号" name="phone">
            <t-input v-model="userForm.phone" :style="{ width: '400px' }" placeholder="请输入手机号"></t-input>
          </t-form-item>
          <t-form-item label="电子邮箱" name="email">
            <t-input v-model="userForm.email" :style="{ width: '400px' }" placeholder="请输入电子邮箱"></t-input>
          </t-form-item>
        </t-form>
      </template>
    </t-dialog>

    <!-- 查看详情 -->
    <t-dialog
      v-model:visible="visibleModal1"
      width="900"
      :closeOnOverlayClick="false"
      :header="'用户详情'"
      mode="modal"
      draggable
      :close-btn="null"
      :confirmBtn="null"
    >
      <template #body>
        <t-form ref="form1" :disabled="true" :label-align="'top'" :data="viewForm" :layout="'inline'">
          <t-form-item label="关联机构" name="tenantName">
            <t-input v-model="viewForm.tenantName" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="关联组织" name="organ" :style="{ width: '800px' }">
            <t-cascader
              v-model="viewForm.organ"
              :keys="{ value: 'id', label: 'name' }"
              :options="organList"
              check-strictly
            />
          </t-form-item>
          <t-form-item label="关联角色" name="roles">
            <t-input v-model="viewForm.roles" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="登录账号" name="username">
            <t-input v-model="viewForm.username" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="用户昵称" name="nickname">
            <t-input v-model="viewForm.nickname" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="手机号" name="phone">
            <t-input v-model="viewForm.phone" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="电子邮箱" name="email">
            <t-input v-model="viewForm.email" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="状态" name="email">
            <t-input v-model="statusMap[viewForm.status]" :style="{ width: '400px' }"></t-input>
          </t-form-item>
          <t-form-item label="最后登录时间" name="logindate">
            <t-input v-model="viewForm.logindate" :style="{ width: '400px' }"></t-input>
          </t-form-item>
        </t-form>
      </template>
    </t-dialog>

    <!-- 修改密码 -->
    <t-dialog
      v-model:visible="visibleModal2"
      width="900"
      :closeOnOverlayClick="false"
      :header="'修改用户密码'"
      mode="modal"
      draggable
      :confirm-btn="saveBtn2"
      :on-confirm="onSubmit2"
    >
      <template #body>
        <t-form ref="form2" :label-align="'top'" :data="passwordForm" :layout="'inline'" :rules="prules">
          <t-form-item label="用户" name="username">
            <t-input v-model="passwordForm.username" :style="{ width: '400px' }" :disabled="true"></t-input>
          </t-form-item>
          <t-form-item label="当前密码" name="password">
            <t-input
              v-model="passwordForm.password"
              :style="{ width: '400px' }"
              placeholder="请输入当前密码"
              type="password"
            ></t-input>
          </t-form-item>
          <t-form-item label="新密码" name="nPassword">
            <t-input
              v-model="passwordForm.nPassword"
              :style="{ width: '400px' }"
              type="password"
              placeholder="请输入新密码"
            ></t-input>
          </t-form-item>
          <t-form-item label="确认新密码" name="rnPassword">
            <t-input
              v-model="passwordForm.rnPassword"
              :style="{ width: '400px' }"
              placeholder="请输入确认新密码"
              type="password"
            ></t-input>
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
import { ref, onMounted, computed, reactive } from 'vue';
import { MessagePlugin, DialogPlugin } from 'tdesign-vue-next';
import { queryOrganTree } from '@/api/system/organ';
import {
  userList,
  addUser,
  editUser,
  delUser,
  getUser,
  lockUser,
  unlockUser,
  resetPwd,
  updatePwd,
  checkPwd,
} from '@/api/system/user';
import { tenantList } from '@/api/system/tenant';
import { roleList } from '@/api/system/role';
import { dicVals } from '@/api/common';
import { useUserStore } from '@/store';

//权限控制
const userStore = useUserStore();
const authAdd = computed(() => userStore.roles.includes('system:user:add'));
const authEdit = computed(() => userStore.roles.includes('system:user:edit'));
const authDel = computed(() => userStore.roles.includes('system:user:del'));

const firstFetch = async () => {
  pagination.value.current = 1;
  await fetchData();
};

//修改密码start
const visibleModal2 = ref(false);
const form2 = ref(null);
const passwordForm = ref({
  id: '',
  username: '',
  password: '',
  nPassword: '',
  rnPassword: '',
});
const npwValidator = async (val) => {
  if (val) {
    let rex = /^\S*(?=\S{6,})(?=\S*\d)(?=\S*[A-Z])(?=\S*[a-z])(?=\S*[!@#$%^&*? ])\S*$/;
    if (!rex.test(val)) {
      return { result: false, message: '至少六位，需包含大小写字，数字和特殊字符', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const pwValidator1 = async (val) => {
  if (val) {
    let res = await checkPwd({
      id: passwordForm.value.id,
      password: passwordForm.value.password,
    });
    if (res.code === 1) {
      return { result: false, message: '密码错误', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const rnPasswordValidator = async (val) => {
  if (val) {
    if (val !== passwordForm.value.nPassword) {
      return { result: false, message: '两次输入的密码不一致', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const prules = {
  password: [{ required: true, message: '请输入当前密码', type: 'error' }, { validator: pwValidator1 }],
  nPassword: [{ required: true, message: '请输入新密码', type: 'error' }, { validator: npwValidator }],
  rnPassword: [{ required: true, message: '请输入确认新密码', type: 'error' }, { validator: rnPasswordValidator }],
};
const saveBtn2 = reactive({
  content: '保存',
  loading: false,
});
const onSubmit2 = async () => {
  let result = await form2.value.validate();
  if (typeof result !== 'object' && result) {
    saveBtn2.content = '保存中...';
    saveBtn2.loading = true;
    let submitForm = {
      id: passwordForm.value.id,
      nPassword: passwordForm.value.nPassword,
    };
    try {
      let result1 = await updatePwd(submitForm);
      if (result1.code === 0) {
        visibleModal2.value = false;
        await fetchData();
        MessagePlugin.success('密码修改成功');
      } else {
        MessagePlugin.error('密码修改失败' + result1.msg);
      }
    } catch (error) {
      MessagePlugin.error('密码修改失败');
    } finally {
      saveBtn2.content = '保存';
      saveBtn2.loading = false;
    }
  }
};
//修改密码end

const statusList = ref([]);
const statusMap = ref({});
const initDicts = async () => {
  let res = await dicVals('SP_USERSTATUS');
  statusList.value = res.data;
  res.data.forEach((row) => {
    statusMap.value[row.value] = row.label;
  });
};
const statusChange = async (val) => {
  if (val) {
    pagination.value.current = 1;
    params.status = val;
    await fetchData();
  }
};
const changeTenant = async (val) => {
  if (val) {
    pagination.value.current = 1;
    params.tenant = val;
    await fetchData();
  }
};

const visibleModal1 = ref(false);
const viewForm = ref({
  tenantName: '',
  roles: '',
  username: '',
  nickname: '',
  phone: '',
  email: '',
  status: '',
  logindate: null,
  organ: '',
});
const viewRow = async (row) => {
  viewForm.value = row;
  visibleModal1.value = true;
};
//机构选择动态加载start
const tenantD = ref([]);
const tenantLoad = ref(false);
const remoteMethod = async (search) => {
  if (search) {
    tenantLoad.value = true;
    tenantD.value = [];
    let res = await tenantList({
      name: search,
    });
    res.data.records.forEach((row) => {
      tenantD.value.push({
        label: row.name,
        value: row.id,
      });
    });
    tenantLoad.value = false;
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

const roleD = ref([]);
const initRoles = async () => {
  let res = await roleList({
    size: 500,
    current: 1,
  });
  res.data.records.forEach((row) => {
    roleD.value.push({
      label: row.name,
      value: row.id,
    });
  });
};
//机构选择动态加载end

const selectedRowKeys = ref([]);
const rehandleSelectChange = (value, { selectedRowData }) => {
  selectedRowKeys.value = value;
};
const updateRow = async () => {
  if (selectedRowKeys.value.length !== 0) {
  }
};
const btnVal = ref('');
const options = [
  {
    content: '锁定',
    value: 1,
    onClick: () => {
      btnVal.value = '1';
    },
  },
  {
    content: '解锁',
    value: 2,
    onClick: () => {
      btnVal.value = '2';
    },
  },
  {
    content: '重置密码',
    value: 3,
    onClick: () => {
      btnVal.value = '3';
    },
  },
  {
    content: '修改密码',
    value: 4,
    onClick: () => {
      btnVal.value = '4';
    },
  },
  // {
  //   content: '注销',
  //   value: 3,
  // },
];

//新增/修改弹窗start
const visibleModal = ref(false);
const userForm = reactive({
  id: '',
  username: '',
  password: '',
  nickname: '',
  phone: '',
  email: '',
  tenant: '',
  roles: [],
  organ: '',
});
const form = ref(null);
const saveBtn = reactive({
  content: '保存',
  loading: false,
});
const idValidator = async (val) => {
  if (opt.value === 'add' && val) {
    let res = await getUser({
      username: val,
      id: userForm.id,
    });
    if (res.data.length != 0) {
      return { result: false, message: '用户账号不能重复', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const phoneValidator = async (val) => {
  if (opt.value === 'add' && val) {
    let res = await getUser({
      phone: val,
      id: userForm.id,
    });
    if (res.data.length != 0) {
      return { result: false, message: '手机号不能重复', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const emailValidator = async (val) => {
  if (opt.value === 'add' && val) {
    let res = await getUser({
      email: val,
      id: userForm.id,
    });
    if (res.data.length != 0) {
      return { result: false, message: '电子邮箱不能重复', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const usernameValidator = async (val) => {
  if (val) {
    let rex = /^[a-z]+$/;
    if (val.length < 5 || !rex.test(val)) {
      return { result: false, message: '至少5位，只能输入大小写字母或数字', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const pwValidator = async (val) => {
  if (val) {
    let rex = /^\S*(?=\S{6,})(?=\S*\d)(?=\S*[A-Z])(?=\S*[a-z])(?=\S*[!@#$%^&*? ])\S*$/;
    if (!rex.test(val)) {
      return { result: false, message: '至少六位，需包含大小写字，数字和特殊字符', type: 'error' };
    }
  }
  return { result: true, type: 'success' };
};
const rules = {
  username: [
    { required: true, message: '请输入用户账号', type: 'error' },
    { validator: idValidator },
    { validator: usernameValidator },
  ],
  phone: [
    { required: true, message: '请输入手机号', type: 'error' },
    { telnumber: true, message: '请输入正确的手机号码' },
    { validator: phoneValidator },
  ],
  email: [
    { required: true, message: '请输入机构邮箱', type: 'error' },
    { email: { ignore_max_length: true }, message: '请输入正确的邮箱地址' },
    { validator: emailValidator },
  ],
  password: [{ required: true, message: '请输入用户密码', type: 'error' }, { validator: pwValidator }],
  tenant: [{ required: true, message: '请选择关联机构', type: 'error' }],
  organ: [{ required: true, message: '请选择关联组织', type: 'error' }],
  nickname: [{ required: true, message: '请输入用户昵称', type: 'error' }],
};
const onSubmit = async () => {
  let result = await form.value.validate();
  if (typeof result !== 'object' && result) {
    saveBtn.content = '保存中...';
    saveBtn.loading = true;
    let submitForm = {
      username: userForm.username,
      phone: userForm.phone,
      email: userForm.email,
      nickname: userForm.nickname,
      tenant: userForm.tenant,
      roles: userForm.roles.join(','),
      password: null,
      organ: userForm.organ,
      id: null,
    };
    if (opt.value === 'add') {
      submitForm.password = userForm.password;
      try {
        let result1 = await addUser(submitForm);
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
      submitForm.id = userForm.id;
      try {
        let result1 = await editUser(submitForm);
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
    }
  }
};
//新增/修改弹窗end

//左侧角色菜单列表数据start
const clickHandler = async (row) => {
  if (btnVal.value === '1') {
    await lockRow(row);
  } else if (btnVal.value === '2') {
    await unlockRow(row);
  } else if (btnVal.value === '3') {
    await resetRow(row);
  } else if (btnVal.value === '4') {
    form2.value.reset();
    passwordForm.value.id = row.id;
    passwordForm.value.username = row.username + '/' + row.nickname;
    visibleModal2.value = true;
  }
};
const data = ref([]);
const columns = [
  {
    width: 100,
    colKey: 'username',
    title: '登录账号',
  },
  {
    width: 100,
    colKey: 'nickname',
    title: '用户昵称',
    ellipsis: true,
  },
  {
    width: 160,
    colKey: 'tenantName',
    title: '关联机构',
    ellipsis: true,
  },
  {
    width: 120,
    colKey: 'roles',
    title: '关联角色',
  },
  {
    width: 80,
    colKey: 'status',
    title: '状态',
  },
  {
    width: 130,
    colKey: 'logindate',
    title: '最后登录时间',
    ellipsis: true,
  },
  {
    colKey: 'operation',
    title: '操作',
    width: 160,
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
  nickname: '',
  status: '',
  tenant: '',
});
const onPageChange = async (pageInfo) => {
  pagination.value.current = pageInfo.current;
  pagination.value.pageSize = pageInfo.pageSize;
  await fetchData();
};
const clearName = async (index) => {
  if (index === 0) {
    params.status = '';
  } else if (index === 1) {
    params.tenant = '';
  } else if (index === 2) {
    params.nickname = '';
  }
  pagination.value.current = 1;
  await fetchData();
};
const opt = ref('add');
const addRow = async () => {
  opt.value = 'add';
  form.value.reset();
  tenantD.value = [];
  userForm.id = '';
  visibleModal.value = true;
};
const editRow = async (row) => {
  opt.value = 'edit';
  form.value.reset();
  userForm.id = row.id;
  userForm.username = row.username;
  userForm.nickname = row.nickname;
  userForm.phone = row.phone;
  userForm.email = row.email;
  userForm.roles = row.roleIds.split(',');
  userForm.organ = row.organ;
  //userForm.tenant = row.tenant;
  tenantD.value = [];
  let res = await tenantList({
    id: row.tenant,
  });
  res.data.records.forEach((row1) => {
    tenantD.value.push({
      label: row1.name,
      value: row1.id,
    });
  });
  userForm.tenant = row.tenant;
  visibleModal.value = true;
};
const delRow = async (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确认删除(' + row.username + '/' + row.nickname + ')用户？',
    confirmBtn: '继续删除',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      delUser(row.id)
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

const lockRow = async (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确认锁定(' + row.username + '/' + row.nickname + ')用户？',
    confirmBtn: '继续锁定',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      lockUser(row.id)
        .then((res) => {
          if (res.code === 0) {
            fetchData();
            MessagePlugin.success('锁定成功');
          } else {
            MessagePlugin.error('锁定失败：' + res.msg);
          }
        })
        .catch((error) => {
          MessagePlugin.error('锁定失败');
        });
    },
    onClose: ({ e, trigger }) => {
      confirmDia.hide();
    },
  });
};

const unlockRow = async (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确认解锁(' + row.username + '/' + row.nickname + ')用户？',
    confirmBtn: '继续解锁',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      unlockUser(row.id)
        .then((res) => {
          if (res.code === 0) {
            fetchData();
            MessagePlugin.success('解锁成功');
          } else {
            MessagePlugin.error('解锁失败：' + res.msg);
          }
        })
        .catch((error) => {
          MessagePlugin.error('解锁失败');
        });
    },
    onClose: ({ e, trigger }) => {
      confirmDia.hide();
    },
  });
};

const resetRow = async (row) => {
  const confirmDia = DialogPlugin({
    header: '提醒',
    body: '是否确认重置(' + row.username + '/' + row.nickname + ')用户密码？',
    confirmBtn: '继续重置',
    //cancelBtn: '在考虑下',
    onConfirm: ({ e }) => {
      confirmDia.hide();
      resetPwd(row.id)
        .then((res) => {
          if (res.code === 0) {
            fetchData();
            MessagePlugin.success('重置成功');
          } else {
            MessagePlugin.error('重置失败：' + res.msg);
          }
        })
        .catch((error) => {
          MessagePlugin.error('重置失败');
        });
    },
    onClose: ({ e, trigger }) => {
      confirmDia.hide();
    },
  });
};

const fetchData = async () => {
  data.value = [];
  selectedRowKeys.value = [];
  dataLoading.value = true;
  try {
    let res = await userList({
      size: pagination.value.pageSize,
      current: pagination.value.current,
      nickname: params.nickname,
      status: params.status,
      tenant: params.tenant,
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

//初始化查询组织树形
const organList = ref([]);
const initOrganTree = async () => {
  let res = await queryOrganTree({});
  organList.value = res.data;
};
//vue的api
onMounted(async () => {
  await initRoles();
  await initDicts();
  await fetchData();
  await initOrganTree();
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
