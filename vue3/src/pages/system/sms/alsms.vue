<template>
  <div class="sp-main-info">
    <t-loading size="small" :loading="loading" show-overlay>
      <t-form ref="form" :data="aliForm" @submit="onSubmit" labelWidth="160px" :rules="rules">
        <t-form-item label="Endpoint" name="endpoint" help="默认为：dysmsapi.aliyuncs.com">
          <t-input v-model="aliForm.endpoint" clearable placeholder="请输入Endpoint"></t-input>
        </t-form-item>
        <t-form-item label="地域(region)" name="region" help="没有特殊要求，默认为空">
          <t-input v-model="aliForm.region" clearable placeholder="请输入地域"></t-input>
        </t-form-item>
        <t-form-item label="accesskeyId" name="accesskeyid">
          <t-input v-model="aliForm.accesskeyid" type="password" clearable placeholder="请输入accesskeyId"></t-input>
        </t-form-item>
        <t-form-item label="accessKeySecret" name="accesskeysecret">
          <t-input
            v-model="aliForm.accesskeysecret"
            type="password"
            clearable
            placeholder="请输入accessKeySecret"
          ></t-input>
        </t-form-item>
        <t-form-item label="默认签名" name="sign">
          <t-input v-model="aliForm.sign" clearable placeholder="请输入默认签名"></t-input>
        </t-form-item>
        <t-form-item style="padding-top: 8px">
          <t-button theme="primary" type="submit" :loading="saveBtn.loading" style="margin-right: 10px">{{
            saveBtn.text
          }}</t-button>
        </t-form-item>
      </t-form>
    </t-loading>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, reactive } from 'vue';
import { MessagePlugin, DialogPlugin } from 'tdesign-vue-next';
import { saveOrUpdate, smsConfig } from '@/api/system/sms';

const smsType = ref('ALI');
const form = ref(null);

const loading = ref(false);
const saveBtn = reactive({
  text: '保存',
  loading: false,
});

const initData = async () => {
  form.value.reset();
  aliForm.endpoint = 'dysmsapi.aliyuncs.com';
  loading.value = true;
  try {
    let res = await smsConfig(smsType.value);
    if (res.data) {
      aliForm.id = res.data.id;
      aliForm.endpoint = res.data.endpoint;
      aliForm.region = res.data.region;
      aliForm.accesskeyid = res.data.secretid;
      aliForm.accesskeysecret = res.data.secretkey;
      aliForm.sign = res.data.sign;
    }
  } catch (error) {
  } finally {
    loading.value = false;
  }
};

//表单
const rules = {
  endpoint: [{ required: true, message: '请输入Endpoint', type: 'error', trigger: 'change' }],
  accesskeyid: [{ required: true, message: '请输入accesskeyId', type: 'error', trigger: 'change' }],
  accesskeysecret: [{ required: true, message: '请输入accessKeySecret', type: 'error', trigger: 'change' }],
  sign: [{ required: true, message: '请输入默认签名', type: 'error', trigger: 'change' }],
};
const aliForm = reactive({
  id: '',
  endpoint: 'dysmsapi.aliyuncs.com',
  region: '',
  accesskeyid: '',
  accesskeysecret: '',
  sign: '',
});
const onSubmit = async ({ validateResult }) => {
  if (validateResult === true) {
    const confirmDia = DialogPlugin({
      header: '提醒',
      body: '是否确定保存(阿里云短信)本次的修改?',
      confirmBtn: '确定',
      //cancelBtn: '暂不',
      onConfirm: async ({ e }) => {
        saveBtn.text = '保存中...';
        saveBtn.loading = true;
        confirmDia.hide();
        let subForm = {
          id: aliForm.id,
          endpoint: aliForm.endpoint,
          region: aliForm.region,
          secretid: aliForm.accesskeyid,
          secretkey: aliForm.accesskeysecret,
          type: smsType.value,
          sign: aliForm.sign,
        };
        try {
          let res = await saveOrUpdate(subForm);
          if (res.code === 0) {
            await initData();
            MessagePlugin.success('保存成功');
          } else {
            MessagePlugin.error('保存失败：' + res.msg);
          }
        } catch (error) {
          MessagePlugin.error('保存失败：' + error);
        } finally {
          saveBtn.text = '保存';
          saveBtn.loading = false;
        }
      },
      onClose: ({ e, trigger }) => {
        confirmDia.hide();
      },
    });
  }
};
//vue的api
onMounted(async () => {
  await initData();
});

defineExpose({
  initData,
});
</script>

<style lang="less" scoped>
@import '@/style/variables';

.sp-main-info {
  padding: 30px;
  width: 50%;
}
</style>
