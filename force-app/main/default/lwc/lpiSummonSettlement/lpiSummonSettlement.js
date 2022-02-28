import { LightningElement, track } from 'lwc';
import fetchSettlements from '@salesforce/apex/TLC_PaymentController.fetchSettlements';
import fetchSummons from '@salesforce/apex/TLC_PaymentController.fetchSummons';
import createTransactionLog from '@salesforce/apex/TLC_PaymentController.createTransactionLog';
import { NavigationMixin } from 'lightning/navigation';

export default class LpiSummonSettlement extends NavigationMixin(LightningElement) {
    @track settlements = [];
    @track summons = [];
    connectedCallback() {
        fetchSettlements()
            .then(data => {
                this.settlements = data;
            })
            .catch(error => {
                console.log(error);
            });

        fetchSummons()
            .then(data => {
                this.summons = data;
            })
            .catch(error => {
                console.log(error);
            });
    }

    viewRecord(event) {
        let parentId = event.currentTarget.dataset.id;
        
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Summon_Flow__c'
            },
            state:
            {
                Info: parentId
            }
        });
    }

    viewSettlement(event) {
        let parentId = event.currentTarget.dataset.id;
        
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Settlement_Flow__c'
            },
            state:
            {
                Info: parentId
            }
        });
    }

    handlePayment(event) {
        let parentId = event.currentTarget.dataset.id;
        let objName = event.currentTarget.dataset.name;
        console.log(parentId,objName);
        createTransactionLog({ parentId: parentId, objName: objName })
            .then(result => {
                window.open('https://mtxlpi.force.com/tlcPortal/CyberSourcePayment?mode=card&tid=' + result);
            })
            .catch(error => {
                console.log(error);
            });
    }
}