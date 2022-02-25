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

        getApplicationList()
		.then(appResult => {
            console.log('App Data', appResult);
			this.appData = appResult;
			this.error = undefined;
		})
		.catch(error => {
			this.error = error;
			this.appData = undefined;
		})
    }

}