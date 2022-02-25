import { LightningElement,track } from 'lwc';
import getAccountList from '@salesforce/apex/bcdDashboardApex.getAllDetails';


export default class BCDDashboard extends LightningElement {

    data = [];
   
	renewURL;
    
    connectedCallback() {
        console.log("connectedCallback");
        getAccountList()
		.then(result => {
            console.log('Data', result);
			this.data = result;
			this.error = undefined;
		})
		.catch(error => {
			this.error = error;
			this.data = undefined;
		})
       
    }

	onClick(event) {
		console.log(event.target.name);
		this.renewURL = 'https://mtxlpi.force.com/tlcPortal/s/license-renewal?licenseId='+event.target.name;
		window.open(this.renewURL, '_self');
	}

}