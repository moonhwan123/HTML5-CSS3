<template>
<div class="inputBox shadow">
  <input type="text" v-model="newTodoItem" v-on:keyup.enter="addTodo" /> 
  <span class="addContainer" v-on:click="addTodo">
      <i class="fas fa-plus addBtn"></i>
  </span>
  <Modal v-if="showModal" @close="showModal = false">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <h3 slot="header">
      Warning!
      <i class="closeModalBtn fas fa-window-close" v-on:click="closeModal()"></i>
    </h3>

    <p slot="body">Please Insert Content!</p>

  </Modal>
</div>
</template>

<script>
import Modal from './common/Modal.vue'

export default {
    data() {
        return {
            newTodoItem : "",
            showModal : false
        };
    },
    methods : {
        addTodo() {
            if(this.newTodoItem !== ''){
              // this.$emit('addTodoEvent',this.newTodoItem);
              this.$store.commit('addOneItem',this.newTodoItem);
              this.clearInput();
            }else{
              this.showModal = !this.showModal;
            }

        },
        clearInput(){
          this.newTodoItem = '';
        },
        closeModal(){
          this.showModal = !this.showModal;
        }
    },
    components : {
      //ES5
      // Modal : Modal

      //ES6
      Modal
    }
}
</script>

<style scoped>
input:focus {
  outline: none;
}  
.inputBox {
  background: white;
  height: 50px;
  line-height: 50px;
  border-radius: 5px;
}
.inputBox input {
  border-style: none;
  font-size: 0.9rem;
}
.addContainer {
  float: right;
  background: linear-gradient(to right, #6478FB, #8763FB);
  display: block;
  width: 3rem;
  border-radius: 0 5px 5px 0;
}
.addBtn {
  color: white;
  vertical-align: middle;
}
.closeModalBtn {
  color: #42b983;
}
</style>