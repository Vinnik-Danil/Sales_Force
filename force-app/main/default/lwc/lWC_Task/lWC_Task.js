import { LightningElement } from 'lwc';

export default class LWC_Task extends LightningElement {
    falseVar = false;

    drag(event){
        event.dataTransfer.setData("divId", event.target.id);
    }

    allowDrop(event){
        event.preventDefault();
    }

    drop(event){
        event.preventDefault();
        let divId = event.dataTransfer.getData("divId");
        console.log("DIV ID= "+divId);
        console.log("ELEMENT ID"+document.getElementById(event.target.id));
        let draggedElement = this.template.querySelector('#' +divId);
        console.log("DRAGGED ELEMENT "+draggedElement);
        // let idParent = this.template.parentNode.id;

        // console.log(idParent);

        if(draggedElement.classList.contains('completed')){
            draggedElement.classList.remove('completed'); 
        }else{
            draggedElement.classList.add('completed'); 
        }

        event.target.appendChild(draggedElement);
    }
}