<template>
  <Navbar />
  <router-view />
</template>

<script>
import Navbar from '@/components/Navbar';

export default {
  components: {
    Navbar
  }
};
</script>

<style lang="scss">
@import 'assets/scss/custom.scss';
</style>
