import { LightningElement, track,wire } from 'lwc';
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import updateManageAccountDetails from '@salesforce/apex/lpiManageAccountController.updateManageAccount';
import getManageAccountDetails from '@salesforce/apex/lpiManageAccountController.getManageAccountDetails';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import STATE_FIELD from "@salesforce/schema/PreliminaryApplicationRef.Issuance_State__c";

export default class LpiMyAccount extends LightningElement {

    @track showSpinner;
    @track getData = {
        FirstName: "",
        LastName: "",
        Cell_Phone: "",
        PersonEmail: "",
        PersonBirthdate: "",
        PersonMailingStreet: "",
        PersonMailingCity: "",
        PersonMailingState: "",
        PersonMailingPostalCode: "",
    };
    @wire(getPicklistValues, {
        recordTypeId: "012000000000000AAA",
        fieldApiName: STATE_FIELD,
    })
    statePicklist;

    get showCombobox() {
        if (
            this.statePicklist.data != null &&
            this.statePicklist.data.values != null 
        )
            return true;
        return false;
    }
    handleChange(event) {
        let changeName = event.target.name;
        let changeValue = event.target.value;
        this.getData[changeName] = changeValue;
    }
    connectedCallback() {
        this.showSpinner = true;
        this.getAccountData();
    }
    getAccountData() {
        getManageAccountDetails().then(data => {
            var result = JSON.parse(data);
            this.getData = result;
            console.log('result :>> ', JSON.stringify(this.getData));
            this.showSpinner = false;
        })
            .catch(error => {
                console.log('error :>> ', error);
                this.showSpinner = false;
            });
    }

    handleSave() {
        console.log('getData :>> ', JSON.stringify(this.getData));
        this.showSpinner = true;

        updateManageAccountDetails({
            manageAccData: JSON.stringify(this.getData)
        }).then(data => {
            console.log('object :>> ', data);
            this.showToast("Success", "Details updated successfully", "success");
            this.getAccountData();
            this.showSpinner = false;
            location.reload();
        })
            .catch(error => {
                console.log('error :>> ', error);
                this.showSpinner = false;
            });
    }

    // show toast
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}