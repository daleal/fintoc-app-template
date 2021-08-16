import TurbolinksAdapter from 'vue-turbolinks';
import LoadScript from 'vue-plugin-load-script';
import Vue from 'vue/dist/vue.esm';
import BankApplication from '../applications/BankApplication.vue';

Vue.use(TurbolinksAdapter);
Vue.use(LoadScript);

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('bank-application')) {
    new Vue({
      render: (h) => h(BankApplication),
    }).$mount('#bank-application');
  }
});
