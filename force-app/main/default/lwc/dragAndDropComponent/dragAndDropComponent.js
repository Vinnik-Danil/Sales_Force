import { LightningElement, track, wire } from 'lwc';
import taskData from '@salesforce/apex/DragAndDropComponentHandler.getAllTask';
import updateTask from '@salesforce/apex/DragAndDropComponentHandler.updateTask';
import deleteTask from '@salesforce/apex/DragAndDropComponentHandler.deleteTask';

export default class DragAndDropComponent extends LightningElement {
    @track taskNewList = [];
    @track taskInProgressList = [];
    @track taskCompletedList = [];
    @track dropTaskId;

    connectedCallback(){
        this.getTaskData();
    }

    getTaskData(){
        taskData().then(result =>{
            let taskNewData = [];
            let taskInProgressData = [];
            let taskCompletedData = [];
            for(let i = 0; i < result.length; i++){
                let task = new Object();
                task.Id = result[i].Id;
                task.Subject = result[i].Subject;
                task.Status = result[i].Status;
                if(task.Status === 'Not Started'){
                    taskNewData.push(task);
                }else if(task.Status !== 'Not Started' && task.Status !== 'Completed'){
                    taskInProgressData.push(task);
                }else if(task.Status === 'Completed'){
                    taskCompletedData.push(task);
                }
            }
            this.taskNewList = taskNewData;
            this.taskInProgressList = taskInProgressData;
            this.taskCompletedList = taskCompletedData;
        });
    }

    handleClick(event){ //button delete;
        this.deleteTaskStatus(this.dropTaskId);
    }

    taskDragStart(event){
        const taskId = event.target.id.substr(0,18);
        console.log(taskId);
        //window.alert(taskId);
        this.dropTaskId = taskId;
        let draggableElement = this.template.querySelector('[data-id="' + taskId + '"]');
        draggableElement.classList.add('drag');

        console.log("IT work");
    }

    taskDragEnd(event){
        const taskId = event.target.id.substr(0,18);
        //window.alert(taskId);
        let draggableElement = this.template.querySelector('[data-id="' + taskId + '"]');
        draggableElement.classList.remove('drag');
    }

    handleDrop(event){
        this.cancel(event);
        const columnUsed = event.target.id;
        let taskNewStatus;
        if(columnUsed.includes('InProgress')){
            taskNewStatus = 'In Progress';
        }else if(columnUsed.includes('newTask')){
            taskNewStatus = 'Not Started';
        }else if(columnUsed.includes('completed')){
            taskNewStatus = 'Completed';
        }
        //window.alert(columnUsed + ' & '+ taskNewStatus);
        this.updateTaskStatus(this.dropTaskId, taskNewStatus);
        let draggableElement = this.template.querySelector('[data-role="drop-target"]');
        draggableElement.classList.remove('over');
    }

    handleDragEnter(event){
        this.cancel(event);
    }

    handleDragOver(event){
        event.preventDefault();
    }

    deleteTaskStatus(taskId){
        alert("Are you sure? ");
        deleteTask({newTaskId: taskId}).then(result =>{
            this.getTaskData();
        });
        console.log("Record is deleted");
    }

    updateTaskStatus(taskId, taskNewStatus){
        updateTask({newTaskId: taskId, newStatus: taskNewStatus}).then(result =>{
            this.getTaskData();
        });
    }

    cancel(event) {
        if (event.stopPropagation) event.stopPropagation();
        if (event.preventDefault) event.preventDefault();
        return false;
    };
}