<template>
  <div>
    Link id: {{ linkId }}
  </div>
</template>

<script>
export default {
  props: {
    linkId: {
      type: String,
      required: true,
    },
  },
}
</script>
