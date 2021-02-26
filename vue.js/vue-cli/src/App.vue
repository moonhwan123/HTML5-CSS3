<template>
  <app-header 
    v-bind:propsdata="str" 
    v-on:reNew="reNewStr"
  ></app-header>
</template>

<script>
import AppHeader from './components/AppHeader.vue'
 
export default {
  data : function(){
    return {
      str : 'PropsProps'
    }
  },
  components : {
    'app-header' : AppHeader
  },
  methods : {
    reNewStr : function(){
      this.str = 'Hi Hi Hi';
    }
  }
}
</script>

<style>

</style>  