const storage = {
    fetch(){
        const arr = [];
        if(localStorage.length > 0){
            for(let i = 0; i < localStorage.length ; i++){
                if(localStorage.key(i) !== 'loglevel:webpack-dev-server'){
                    arr.push(JSON.parse(localStorage.getItem(localStorage.key(i))));
                }
                
            }//end for
        }//end if 
        return arr;       
    }//end fetch()
};

const state = {
    headerText : 'TODO it!',
    todoItems : storage.fetch()
};

const getters = {
    getTodoItems(state){
        return state.todoItems;
    },
    getHeaderText(state){
        return state.headerText;
    }
};

const mutations = {
    addOneItem(state,newTodoItem){
            const obj = {completed:false, item : newTodoItem};
            localStorage.setItem(newTodoItem,JSON.stringify(obj));
            state.todoItems.push(obj);            
    },
    removeOneItem(state,payload){
            localStorage.removeItem(payload.todoItem.item);
            state.todoItems.splice(payload.index,1);
    },
    toggleCompleteOne(state,payload){
            state.todoItems[payload.index].completed = !state.todoItems[payload.index].completed;
            localStorage.removeItem(payload.todoItem.item);
            localStorage.setItem(payload.todoItem.item,JSON.stringify(payload.todoItem));
    },
    clearAll(state){
            localStorage.clear();
            state.todoItems = [];            
    }
};

export default {
    state,
    mutations,
    getters
};