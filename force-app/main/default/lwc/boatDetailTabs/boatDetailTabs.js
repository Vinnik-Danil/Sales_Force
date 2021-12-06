/**
 * Created by daniilvinnik on 17.09.2021.
 */

import { LightningElement, api,wire } from 'lwc';
import labelDetails from '@salesforce/label/c.Details';
import labelReviews from '@salesforce/label/c.Reviews';
import labelAddReview from '@salesforce/label/c.Add_Review';
import labelFullDetails from '@salesforce/label/c.Full_Details';
import labelPleaseSelectABoat from '@salesforce/label/c.Please_select_a_boat';
import BOAT_ID_FIELD from '@salesforce/schema/Boat__c.Id';
import BOAT_NAME_FIELD from '@salesforce/schema/Boat__c.Name';
import { getRecord,getFieldValue } from 'lightning/uiRecordApi';
import BOATMC from '@salesforce/messageChannel/BoatMessageChannel__c';
import { APPLICATION_SCOPE,MessageContext, subscribe } from 'lightning/messageService';
import BoatReviews from 'c/boatReviews';
const BOAT_FIELDS = [BOAT_ID_FIELD, BOAT_NAME_FIELD];
import {NavigationMixin} from 'lightning/navigation';

export default class BoatDetailTabs extends NavigationMixin(LightningElement) {
    @api boatId;
    label = {
        labelDetails,
        labelReviews,
        labelAddReview,
        labelFullDetails,
        labelPleaseSelectABoat,
    };

    get detailsTabIconName() {
        return this.wiredRecord && this.wiredRecord.data ? 'utility:anchor' : null;
    }

    @wire(getRecord,{recordId: '$boatId', fields: BOAT_FIELDS})
    wiredRecord;
    get boatName() {
        return getFieldValue(this.wiredRecord.data, BOAT_NAME_FIELD);
    }

    subscription = null;
    @wire(MessageContext)
    messageContext;
    subscribeMC() {
        if(this.subscription) { return; }
        this.subscription = subscribe(
            this.messageContext,
            BOATMC,
            (message) => {
                this.boatId = message.recordId;
            },
            { scope: APPLICATION_SCOPE }
        );
    }

    connectedCallback() {
        this.subscribeMC();
    }

    navigateToRecordViewPage() {
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: this.boatId,
                actionName: "view"
            }
        });
    }

    handleReviewCreated() {
        this.template.querySelector('lightning-tabset').activeTabValue = 'reviews';
        this.template.querySelector('c-boat-reviews').refresh();
    }
}