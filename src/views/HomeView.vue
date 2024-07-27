<template>
  <HelloWorld />
</template>

<script>
import { defineComponent } from 'vue';

// Components  내용무
import HelloWorld from '../components/HelloWorld.vue';

export default defineComponent({
  name: 'HomeView',

  components: {
    HelloWorld,
  },
});
</script>
