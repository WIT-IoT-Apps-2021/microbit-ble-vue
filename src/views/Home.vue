<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col">
        <Microbit />
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import Microbit from '@/components/Microbit.vue';

export default {
  name: 'Home',
  components: {
    Microbit
  }
};
</script>
