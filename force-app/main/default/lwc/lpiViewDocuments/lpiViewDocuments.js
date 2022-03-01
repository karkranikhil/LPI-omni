import { LightningElement, api } from 'lwc';
import fetchDocuments from '@salesforce/apex/LPI_ViewDocumentController.fetchDocuments';

export default class LpiViewDocuments extends LightningElement {
    @api recordId;
    showSpinner;
    showDocument;
    dataList =[];

    connectedCallback() {
       this.showSpinner = true;
       this.showDocument = false;
       console.log('Record Id',this.recordId);
       fetchDocuments({ recordId: this.recordId })
       .then(result => {
           console.log('Result form APEX' ,result);
           if(result.length > 0){
            this.dataList = result;
            this.showDocument = true;
           }else{
            this.showDocument = false;
           }
       })
       .catch(error => {
           console.error('**** error **** \n ', error);
       })
       .finally(() => {
           this.showSpinner = false;
       });
    }
}