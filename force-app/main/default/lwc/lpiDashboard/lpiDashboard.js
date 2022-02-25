import { LightningElement, track } from 'lwc';
import lpiImages from "@salesforce/resourceUrl/lpiImages";
import getAccountList from '@salesforce/apex/bcdDashboardApex.getDetails';
import getApplicationList from '@salesforce/apex/bcdDashboardApex.getApplicationList';

export default class LpiDashboard extends LightningElement {

    @track licensing = lpiImages + "/tlcImages/licensing-iocn.svg";
    @track vehicle = lpiImages + "/tlcImages/vehicle.svg";
    @track renewal = lpiImages + "/tlcImages/renewal.svg";
    @track date = lpiImages + "/tlcImages/date.svg";

    data = [];
    appData = [];
	renewURL;
	ActiveLicenseCount = 0;
	ActiveVehicleCount = 0;
	PendingRenewalCount = 0;
	ExpiringLicenseCount = 0;
    
    connectedCallback() {
        console.log("connectedCallback");
        getAccountList()
		.then(result => {
            console.log('Data', result);
			this.data = result;
			this.ActiveLicenseCount = result.length;

			for (let i = 0; i < result.length; i++) {
				if(result[i].Renew == true){
					this.ExpiringLicenseCount = this.ExpiringLicenseCount +1;
				}
				if(result[i].Type == 'Vehicle License'){
					this.ActiveVehicleCount = this.ActiveVehicleCount +1;
			  }
			}

			this.error = undefined;
		})
		.catch(error => {
			this.error = error;
			this.data = undefined;
		})

        getApplicationList()
		.then(appResult => {
            console.log('App Data', appResult);
			this.appData = appResult;

			for (let i = 0; i < appResult.length; i++) {
				if(appResult[i].status == 'Submitted'){
					this.PendingRenewalCount = this.PendingRenewalCount +1;
				}
			  }
			this.error = undefined;
		})
		.catch(error => {
			this.error = error;
			this.appData = undefined;
		})

    }

	onClick(event) {
		console.log('Renew License ',event.target.name);
		this.renewURL = 'https://mtxlpi.force.com/tlcPortal/s/license-renewal?licenseId='+event.target.name;
		window.open(this.renewURL, '_self');
	}

	onUpdate(event){
		console.log('Update License ',event.target.name);
		window.open('https://mtxlpi.force.com/tlcPortal/s/update-license?licenseId='+event.target.name, '_self');
	}

}