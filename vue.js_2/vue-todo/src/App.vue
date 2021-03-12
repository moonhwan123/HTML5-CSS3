<template>
  <div id="app">
    <TodoHeader></TodoHeader>
    <TodoInput></TodoInput>
    <TodoList></TodoList>
    <TodoFooter></TodoFooter>
  </div>
</template>

<script>
import TodoHeader from './components/TodoHeader.vue'
import TodoList from './components/TodoList.vue'
import TodoFooter from './components/TodoFooter.vue'
import TodoInput from './components/TodoInput.vue'

export default {
  components : {
    //ES5
    // 'TodoHeader' : TodoHeader,

    //ES6
    TodoHeader, 
    TodoList,
    TodoFooter,
    TodoInput
  }
}

</script>

<style>
body{
  text-align: center;
  background-color: #f6f6f6;

}
input{
  border-style: groove;
  width: 200px;
}
button{
  border-style: groove;

}
.shadow{
  box-shadow: 5px 10px 10px rgba(0,0,0,0.3);
}
</style>
