<template>
  <select
    :disabled="!accounts || loading"
    @change="selected($event.target.value)"
    v-model="index"
  >
    <option
      v-for="(account, index) in accounts"
      :key="account.id"
      :value="index"
    >{{ account.name }}</option>
  </select>
</template>

<script>
export default {
  data() {
    return {
      index: null,
    };
  },
  props: {
    accounts: {
      type: Array,
      required: true,
    },
    loading: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    selected(index) {
      this.$emit("selected", index)
    }
  }
}
</script>
