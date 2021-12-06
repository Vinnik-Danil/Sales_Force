/**
 * Created by daniilvinnik on 16.09.2021.
 */

// imports
// import getBoatTypes from the BoatDataService => getBoatTypes method';
// import getBoatTypes from '@salesforce/apex/BoatDataService.getBoatTypes';
// imports
// import getBoatTypes from the BoatDataService => getBoatTypes method';
// export default class BoatSearchForm extends LightningElement {
//     selectedBoatTypeId = '';
//
//     // Private
//     error = undefined;
//
//     searchOptions;
//
//     // Wire a custom Apex method
//     boatTypes({ error, data }) {
//         if (data) {
//             this.searchOptions = data.map(type => {
//                 // TODO: complete the logic
//             });
//             this.searchOptions.unshift({ label: 'All Types', value: '' });
//         } else if (error) {
//             this.searchOptions = undefined;
//             this.error = error;
//         }
//     }
//
//     // Fires event that the search option has changed.
//     // passes boatTypeId (value of this.selectedBoatTypeId) in the detail
//     handleSearchOptionChange(event) {
//         // Create the const searchEvent
//         // searchEvent must be the new custom event search
//         searchEvent;
//         this.dispatchEvent(searchEvent);
//     }
// }

import { LightningElement, wire } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import getBoatTypes from '@salesforce/apex/BoatDataService.getBoatTypes';
import Boats from '@salesforce/apex/BoatDataService.getBoats';

export default class BoatSearchForm extends NavigationMixin(LightningElement) {
    isLoading = false;
    searchOptions;
    error = undefined;
    selectedBoatTypeId='';
    value='';
    label;

    createNewBoat(){
        this[NavigationMixin.Navigate]({
            type:'standard__objectPage',
            attributes:{
                objectApiName:'Boat__c',
                actionName:'new'
            },
        });
    }
    @wire(getBoatTypes)
    boatTypes({data,error}){
        if(data){
            this.searchOptions = data.map(type=>{
                return {
                    label:type.Name,
                    value:type.Id
                }
            });
            this.searchOptions.unshift({ label: 'All Types', value: '' });
        }
        else if (error) {
            this.searchOptions = undefined;
            this.error = error;
        }
    }

    handleLoading(){
    }
    handleDoneLoading(){

    }
    handleSearchOptionChange(event) {
        this.selectedBoatTypeId=event.detail.value;
        // Create the const searchEvent
        // searchEvent must be the new custom event search
        const searchEvent= new CustomEvent('search',{detail:{boatTypeId:this.selectedBoatTypeId}});
        this.dispatchEvent(searchEvent);
    }

}