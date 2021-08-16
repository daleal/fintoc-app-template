<template>
  <div>
    <account-selector
      :loading="loading"
      :accounts="accounts"
      @selected="accountSelected"
    />
    <movements
      v-if="movements"
      :loading="loading"
      :movements="movements"
    />
  </div>
</template>

<script>
import axios from 'axios';

import AccountSelector from './AccountSelector.vue';
import Movements from './Movements.vue';

export default {
  data() {
    return {
      accounts: [],
      movements: [],
      loading: false,
      selectedAccount: null,
    };
  },
  components: {
    AccountSelector,
    Movements,
  },
  props: {
    linkId: {
      type: String,
      required: true,
    },
  },
  mounted() {
    this.fetchAccounts();
  },
  methods: {
    async fetchAccounts() {
      try {
        const url = '/api/accounts';
        const response = await axios.get(url, {
          params: {
            link_id: this.linkId,
          }
        });
        this.accounts = response.data;
      } catch (error) {
        this.accounts = [];
      }
    },
    async fetchMovements() {
      if (!this.selectedAccount) {
        this.movements = [];
        return;
      }
      this.loading = true;
      try {
        const url = `/api/accounts/${this.selectedAccount.id}/movements`;
        const response = await axios.get(url, {
          params: {
            link_id: this.linkId,
          }
        });
        this.movements = response.data;
      } catch (error) {
        this.movements = [];
      }
      this.loading = false;
    },
    accountSelected(index) {
      this.selectedAccount = this.accounts[index];
      this.fetchMovements();
    }
  },
}
</script>
