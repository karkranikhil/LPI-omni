import { LightningElement, api } from 'lwc';
import fetchDocuments from '@salesforce/apex/LPI_ViewDocumentController.fetchDocuments';
import {NavigationMixin} from 'lightning/navigation'
export default class LpiViewDocuments extends NavigationMixin(LightningElement){
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

    previewHandler(event){
        console.log(event.target.name);
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'filePreview'
            },
            state : {
                selectedRecordId: event.target.name
            }
        });
    }

    downloadHandler(event){
        window.open('https://mtxlpidemo.lightning.force.com/sfc/servlet.shepherd/version/download/'+event.target.name+'?operationContext=S1', '_blank');
    }

    viewHandler(event){
        window.open('https://mtxlpidemo.lightning.force.com/lightning/r/Application_Document__c/'+event.target.name+'/view', '_blank');
    }
}