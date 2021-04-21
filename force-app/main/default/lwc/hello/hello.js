import { LightningElement } from 'lwc';

export default class Hello extends LightningElement {
    great = 'hello';

    numberOfEmployees = null;
    handleChange(event) {
        this.numberOfEmployees = event.detail.value;
    }   
}