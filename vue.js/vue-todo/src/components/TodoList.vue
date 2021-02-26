<template>
    <section>
        <transition-group name='list' tag='ul'>
            <li v-for="(item,index) in propsdata" v-bind:key="item">
                <i class='checkBtn fas fa-check' aria-hidden="true"></i>
                <span v-on:click="popUp(item,index)">{{item}}</span>
                <span class='removeBtn' type='button' @click="romoveTodo(item,index)">
                    <i class='far fa-trash-alt' aria-hidden="true"></i>
                </span>
            </li>
        </transition-group>
        <modal v-if="showModal" @close="showModal = false">
            <h3 slot="header">Modify</h3>
            <h5 slot="body">수정하실 할 일을 입력 해 주세요</h5>
            <span slot="footer">
                <input type='text' v-model="modifyTodo">
                <br> 
                <i class='checkBtn fas fa-check' aria-hidden="true"  @click="modify"></i>
            </span>
        </modal>
    </section>
</template>

<script>
import Modal from './commmon/Modal.vue'
export default {
    data : function(){
        return {
            todoItems : [],
            showModal : false,
            item : '',
            index : null,
            modifyTodo : ''
        }
    },

    props : ['propsdata'],

    components : {
        'Modal' : Modal
    },

    methods : {
        romoveTodo : function(item,index){
            this.$emit('removeTodo',item,index);
        },
        popUp : function(item,index){
            console.log(item,index);
            this.item = item;
            this.index = index;
            this.showModal = !this.showModal; 
        },
        modify : function(){
            this.$emit('modifyEvent',this.index,this.modifyTodo)
            this.showModal = !this.showModal;
            this.clearInput();
        },
        clearInput : function(){
            this.modifyTodo = '';
        }
    }
}
</script>

<style scoped>
    ul{
        list-style-type: none;
        padding-left: 0px;
        margin-top: 0;
        text-align: center;
    }
    li{
        display: flex;
        min-height: 50px;
        height: 50px;
        line-height: 50px;
        margin: 0.5rem 0;
        padding: 0 0.9rem;
        background: white;
        border-radius: 5px;
    }

    .list-enter-active, .list-leave-active{
        transition: all 1s;
    }
    .list-enter, .list-leave-to{
        opacity: 0;
        transform: translateY(30px);
    }
    .checkBtn{
        line-height: 50px;
        color : #62acde;
        margin-right: 5px;
    }
    .removeBtn {
        margin-left: auto;
        color : #de4343;
    }

</style>