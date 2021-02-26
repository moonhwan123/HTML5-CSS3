<template>
  <div id="app">
    <TodoHeader></TodoHeader>
    <TodoInput v-on:addTodo="addTodo"></TodoInput>
    <TodoList v-bind:propsdata="todoItems" 
      v-on:removeTodo="removeTodo"
      v-on:modifyEvent="modifyTodo"></TodoList>
    <TodoClearAll v-on:removeAll="clearAll"></TodoClearAll>
    <TodoFooter></TodoFooter>
  </div>
</template>

<script>
import TodoHeader from './components/TodoHeader.vue'
import TodoInput from './components/TodoInput.vue'
import TodoList from './components/TodoList.vue'
import TodoClearAll from './components/TodoClearAll.vue'
import TodoFooter from './components/TodoFooter.vue'

export default {
  data : function(){
    return {
      todoItems : []
    }
  },
  methods : {
    addTodo : function(todoItem){
      //localstorage에 데이터를 추가하는 로직
      localStorage.setItem(todoItem,todoItem);
      this.todoItems.push(todoItem);
    },
    clearAll : function(){
      localStorage.clear();
      this.todoItems = [];
    },
    removeTodo : function(item,index){
      localStorage.removeItem(item);
      this.todoItems.splice(index,1);
    },
    modifyTodo : function(index,modifyTodo){
      console.log(index,modifyTodo);
      this.removeTodo(modifyTodo,index);
      this.addTodo(modifyTodo);
    }
  },
  created(){
    if(localStorage.length > 0) {
        for (var i = 0 ; i < localStorage.length ; i ++){
            this.todoItems.push(localStorage.key(i));
        }
    }
  },
  components : {
    'TodoHeader' : TodoHeader,
    'TodoInput' : TodoInput,
    'TodoList' : TodoList,
    'TodoClearAll' : TodoClearAll,
    'TodoFooter' : TodoFooter
  }
}
</script>

<style>
    body {
        text-align: center;
        background-color: #f6f6f8;
    }
    input {
        border-style: groove; /*할일 입력 하는 인풋 박스의 테두리 모양을 정의*/
        width: 200px;
    }
    button{
        border-style: groove;
    }
    .shadow{
        box-shadow: 5px 10px 10px rgba(0, 0, 0, 0.03); /*인풋박스와 할일 아이템 아래의 그림자 정의*/
    }
</style>
