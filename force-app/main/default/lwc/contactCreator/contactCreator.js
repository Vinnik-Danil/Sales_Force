import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import CONTACT_OBJECT from '@salesforce/schema/Contact';
//import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
//import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
//import EMAIL_FIELD from '@salesforce/schema/Contact.Email';


export default class ContactCreator extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track fields = ['FirstName', 'LastName', 'Email'];

    handleSuccess(event){
        
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }

}