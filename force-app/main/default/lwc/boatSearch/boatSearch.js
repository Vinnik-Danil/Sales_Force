/**
 * Created by daniilvinnik on 16.09.2021.
 */

import { LightningElement , track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'

export default class BoatSearch extends NavigationMixin(LightningElement) {
    @track isLoading = false;

    handleLoading(event) {
        this.isLoading = true;
    }

    handleDoneLoading(event) {
        this.isLoading = false;
    }

    searchBoats(event) {
        const boatTypeId = event.detail.boatTypeId;
        this.template.querySelector("c-boat-search-results").searchBoats(boatTypeId);
    }

    createNewBoat() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Boat__c',
                actionName: 'new'
            }
        });
    }
}