<template>
  <div>
    <div
      v-for="movement in movements"
      :key="movement.id"
    >
      {{ prettifyMovement(movement) }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    movements: {
      type: Array,
      required: true,
    },
    loading: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    prettifyMovement(mov) {
      const date = this.prettifyDate(mov.post_date);
      return `${date}: ${mov.amount} ${mov.currency} (${mov.description})`;
    },
    prettifyDate(date) {
      const obj = new Date(date);
      const day = obj.getDate();
      const month = obj.getMonth() + 1;
      const year = obj.getFullYear();
      const hours = obj.getHours().toString().padStart(2, '0');
      const minutes = obj.getMinutes().toString().padStart(2, '0');
      return `${day}/${month}/${year} ${hours}:${minutes}`;
    },
  },
}
</script>
