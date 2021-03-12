<template>
  <header>
    <h1>
        <!-- My Scheduler Todo it! -->
        {{ this.getHeaderText }}
    </h1>
  </header>
</template>

<script>
import { mapGetters } from 'vuex'

export default{
  computed : {
    ...mapGetters(['getHeaderText'])
  }
}
</script>

<style scoped>
    h1{
        color : #2f3b52;
        font-weight: 900;
        margin: 2.5rem 0 1.5rem;
    }
</style>