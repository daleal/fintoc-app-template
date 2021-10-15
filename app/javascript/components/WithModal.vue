<template>
  <div>
    <slot />
  </div>
</template>

<script>
import Widget from '../services/widget';

const webhookBase = (
  window.location.origin.includes('localhost')
    ? 'https://*.ngrok.io'
    : window.location.origin
);

export default {
  data() {
    return {
      widget: null,
    }
  },
  props: {
    holderType: {
      type: String,
      required: true,
      validator: (value) => ['individual', 'business'].includes(value),
    },
    product: {
      type: String,
      required: true,
      validator: (value) => {
        return [
          'movements', 'subscription', 'tax_return', 'invoices'
        ].includes(value);
      },
    },
    publicKey: {
      type: String,
      required: true,
    },
  },
  async mounted() {
    this.widget = await Widget.build({
      holderType: this.holderType,
      product: this.product,
      publicKey: this.publicKey,
      webhookUrl: `${webhookBase}/api/links`,
      onSuccess: this.onSuccess,
      onExit: this.onExit,
    });
    this.widget.open();
  },
  methods: {
    onSuccess(link) {
      this.$emit("on-success", link);
      this.destroyWidget();
    },
    onExit() {
      this.$emit("on-exit");
      this.destroyWidget();
    },
    destroyWidget() {
      this.widget.destroy();
    }
  }
}
</script>
