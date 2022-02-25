import { LightningElement ,api} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
export default class LpiApproveApplication extends LightningElement {
    @api recordId;

    connectedCallback() {
        console.log('Recoerd Id: '+this.recordId);
        const fields = {};
        fields['Id'] = this.recordId;
        fields['License_Status__c'] = 'Issued';
        fields['Status'] = 'Approved';
        console.log(' HERE '+this.recordId);
        const recordInput = { fields };
        console.log('Fields'+JSON.stringify(fields));
        updateRecord(recordInput)
        .then(() => {
            console.log('Success');
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Individual Application Approved',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            console.log('Error Occured'+error);
        });
    }
}