import { LightningElement } from 'lwc';
import createTransactionLog from '@salesforce/apex/TLC_PaymentController.createTransactionLog';

export default class LpiPayment extends LightningElement {
    handlePayment() {
        createTransactionLog()
            .then(result => {
                window.open('https://mtxlpi.force.com/tlcPortal/CyberSourcePayment?mode=card&tid='+result);
            })
            .catch(error => {
                console.log(error);
            });
    }
}