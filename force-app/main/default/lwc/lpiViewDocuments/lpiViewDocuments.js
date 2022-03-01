import { LightningElement, api } from 'lwc';
import fetchDocuments from '@salesforce/apex/LPI_ViewDocumentController.fetchDocuments';

export default class LpiViewDocuments extends LightningElement {
    @api recordId;
    showSpinner;
    showDocument;
    dataList =[];
    isModalOpen;
    fileData;

    connectedCallback() {
       this.showSpinner = true;
       this.showDocument = false;
       this.isModalOpen = false;
       console.log('Record Id',this.recordId);
       fetchDocuments({ recordId: this.recordId })
       .then(result => {
           console.log('Result form APEX' ,result);
           if(result.length > 0){
            this.dataList = result.map((obj,index)=> ({ ...obj, 
                maverickscore: Math.floor(Math.random() * (100 - 98 + 1) ) + 98,
             }));
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