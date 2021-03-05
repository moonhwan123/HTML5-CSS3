<template>
  <div id="app">
    <TodoHeader></TodoHeader>
    <TodoInput v-on:addTodoEvent="addOneItem"></TodoInput>
    <TodoList v-bind:propsdata="todoItems" 
      v-on:removeTodoEvent="removeOneItem" 
      v-on:toggleCompleteEvent="toggleCompleteOne"></TodoList>
    <TodoFooter v-on:clearTodoEvent="clearAll"></TodoFooter>
  </div>
</template>

<script>
import TodoHeader from './components/TodoHeader.vue'
import TodoList from './components/TodoList.vue'
import TodoFooter from './components/TodoFooter.vue'
import TodoInput from './components/TodoInput.vue'

export default {
  components : {
    'TodoHeader' : TodoHeader,
    'TodoList' : TodoList,
    'TodoFooter' : TodoFooter,
    'TodoInput' : TodoInput
  },

  data : function(){
    return {
      todoItems : [],
    }
  },
  methods:{
    addOneItem : function(newTodoItem){
      var obj = {completed:false, item : newTodoItem};
      localStorage.setItem(newTodoItem,JSON.stringify(obj));
      this.todoItems.push(obj);
    },
    removeOneItem : function(todoItem,index){
      localStorage.removeItem(todoItem.item);
      this.todoItems.splice(index,1);
    },
    toggleCompleteOne : function(todoItem,index){
      // todoItem.completed = !todoItem.completed;
      this.todoItems[index].completed = !this.todoItems[index].completed;
      localStorage.removeItem(todoItem.item);
      localStorage.setItem(todoItem.item,JSON.stringify(todoItem));
    },
    clearAll : function(){
      localStorage.clear();
      this.todoItems = [];
    }
  },
  created : function(){
        if(localStorage.length > 0){
            for(var i = 0; i < localStorage.length ; i++){
                if(localStorage.key(i) !== 'loglevel:webpack-dev-server'){
                    this.todoItems.push(JSON.parse(localStorage.getItem(localStorage.key(i))));
                }
                
            }//end for
        }//end if
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
