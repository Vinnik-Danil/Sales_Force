/**
 * Created by daniilvinnik on 17.09.2021.
 */

import {LightningElement, api} from 'lwc';
import getAllReviews from '@salesforce/apex/BoatDataService.getAllReviews';
import {NavigationMixin} from 'lightning/navigation';
import {refreshApex} from '@salesforce/apex';

export default class BoatReviews extends NavigationMixin(LightningElement) {
    boatId;
    error;
    boatReviews = [];
    isLoading = false;

    @api get recordId() {
        return this.boatId;
    }

    set recordId(value) {
        //sets boatId attribute
        this.setAttribute('boatId', value);
        //sets boatId assignment
        this.boatId = value;
        //get reviews associated with boatId
        this.getReviews();
    }

    get reviewsToShow() {
        return this.boatReviews && this.boatReviews.length > 0 ? true : false;
    }

    @api refresh() {
        refreshApex(this.getReviews());
    }

    getReviews() {
        if (this.boatId == null || this.boatId == '') {
            return;
        }

        this.isLoading = true;
        this.error = undefined;
        getAllReviews({boatId: this.recordId})
            .then(result => {
                this.boatReviews = result;
                this.isLoading = false;
            }).catch(error => {
            this.error = error.body.message;
        }).finally(() => {
            this.isLoading = false;
        });
    }

    navigateToRecord(event) {
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: event.target.dataset.recordId,
                actionName: "view"
            }
        });
    }
}