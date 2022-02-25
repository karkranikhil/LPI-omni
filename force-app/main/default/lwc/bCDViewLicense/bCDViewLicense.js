import { LightningElement,track } from 'lwc';
import getAccountList from '@salesforce/apex/bcdDashboardApex.getAllDetails';


export default class BCDDashboard extends LightningElement {

    @track data = [];
	@track rawdata = [];
	@track tempData = [];
    @track selectedItem = 'VActive';
    @track currentContent = 'VActive';

	renewURL;
	DActiveCount = 0;
	DPendingCount = 0;
	DInactiveCount = 0; 

	VActiveCount = 0;
	VPendingCount = 0;
	VInactiveCount = 0; 
    
    connectedCallback() {
		this.tempData = [];
        getAccountList()
		.then(result => {
            console.log('Data', result);
			this.rawdata = result;
			for (let i = 0; i < result.length; i++) {
				if(result[i].status == 'Active'){
					this.tempData.push(result[i]);
				}
			  }
			this.data = this.tempData;

			for(let j = 0; j < result.length; j++){
				if(result[j].status == 'Active'){
					if(result[j].Type.startsWith('Vehicle')){
						this.VActiveCount++;
					}
					if(result[j].Type.startsWith('Driver')){
						this.DActiveCount++;
					}
				}
				if(result[j].status == 'Pending'){
					if(result[j].Type.startsWith('Vehicle')){
						this.VPendingCount++;
					}
					if(result[j].Type.startsWith('Driver')){
						this.DPendingCount++;
					}
				}
				if(result[j].status == 'Inactive'){
					if(result[j].Type.startsWith('Vehicle')){
						this.VInactiveCount++;
					}
					if(result[j].Type.startsWith('Driver')){
						this.DInactiveCount++;
					}
				}
			}

			console.log('DActiveCount', this.DActiveCount);
			console.log('DPendingCount', this.DPendingCount);
			console.log('DInactiveCount', this.DInactiveCount);
			console.log('VActiveCount', this.VActiveCount);
			console.log('VPendingCount', this.VPendingCount);
			console.log('VInactiveCount', this.VInactiveCount);
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

    handleSelect(event) {
		console.log(event.detail.name);
		this.selectedItem = event.detail.name;
		this.currentContent = event.detail.name;
		var filter;
		var type;

		if(event.detail.name.startsWith('D')){
			type = 'Driver';
		}else if(event.detail.name.startsWith('V')){
			type = 'Vehicle';
		}
		

		switch(event.detail.name){
			case 'DActive':
				filter	= 'Active';
			  break;
			case 'DPending':
				filter	= 'Pending';	
			  break;
			case 'DInactive':
				filter	= 'Inactive';
			  break;
			case 'VActive':
				filter	= 'Active';
				break;
			case 'VPending':
				filter	= 'Pending';
				break;
			case 'VInactive':
				filter	= 'Inactive';
				break;
			default:
				filter	= 'Active';
		  }
		
		this.tempData = [];
		this.data = [];
		for (let i = 0; i < this.rawdata.length; i++) {
			if(this.rawdata[i].status == filter && this.rawdata[i].Type.startsWith(type)){
				this.tempData.push(this.rawdata[i]);
			}
		}
		this.data = this.tempData;
    }

}