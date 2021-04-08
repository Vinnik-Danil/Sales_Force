import { LightningElement, api, wire, track } from 'lwc';
import sendEmail from '@salesforce/apex/EmailSenderController.sendEmailWithReport';
import getEmailAddresses from '@salesforce/apex/EmailSenderController.getUserEmails';

export default class EmailSender extends LightningElement {
    @api recordId;
    options;
    selected = [];

    connectedCallback() {
        getEmailAddresses()
			.then(result => {
                this.options = [];
                console.log('result' + JSON.stringify(result));
                result.forEach(val => {
                    console.log('val: ' + JSON.stringify(val));
                    this.options.push({ 'label': val.Name + '(' + val.Email + ')', 'value': val.Id });
                });
			});
    }


    get selected() {
        return this.selected.length ? this.selected : 'none';
    }

    handleChange(e) {
        this.selected = e.detail.value;
    }

    handleSend(){
        console.log('selectedUsers: ' + this.selected);
        sendEmail({anomalyReportId : this.recordId, selectedUsers : this.selected})
        .then((result) => {
            console.log('COOOL!');
        })
        .catch((error) => {
            console.log('error: ' + JSON.stringify(error));
        });
    }
}