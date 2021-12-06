import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/Accountcls.getAccountList';
export default class Dragger_Component extends LightningElement {
    @wire(getAccounts) accounts;
    handleDragStart(event){
        event.dataTransfer.setData("account_id", event.target.dataset.item);
        console.log("Drag Start");
        // let id = event.dataTransfer.setData("account_id", event.target.id);
        // console.log("Id "+id);
    }


    allowDrop(event){
        event.preventDefault();
    }

    drop(event){
        event.preventDefault();
        let divId = event.dataTransfer.getData("account_id");
        
        console.log(divId);

        let draggedElement = this.template.querySelector('.card');
        console.log(draggedElement);

        event.target.appendChild(draggedElement);
    }


}