<template>
  <with-modal
    v-if="publicKey"
    :holderType="holderType"
    :product="product"
    :publicKey="publicKey"
    @on-success="saveLink"
  >
    <layout
      v-if="link"
      :link-id="link.id"
    />
  </with-modal>
</template>

<script>
import Layout from '../components/Layout.vue';
import WithModal from '../components/WithModal.vue';

export default {
  data() {
    return {
      link: null,
      publicKey: null,
      holderType: 'individual',
      product: 'movements',
    }
  },
  components: {
    Layout,
    WithModal,
  },
  mounted() {
    const $dataContainer = document.getElementById('application-data');
    this.publicKey = $dataContainer.dataset.fintocPublicKey;
  },
  methods: {
    saveLink(link) {
      this.link = link;
    },
  }
}
</script>
