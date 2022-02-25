import { LightningElement,track } from 'lwc';
import getLicenseDetails from '@salesforce/apex/UpdaetLicenseController.getLicenseDetails';
import updateLicenseDetails from '@salesforce/apex/UpdaetLicenseController.updateLicenseDetails';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LpiUpdateLicense extends LightningElement {
    @track parameters;
    @track data=[];

    @track accountId;

    @track cell;
    @track tel;
    @track email;
   
    @track mBuilding;
    @track mStreet;
    @track mApt;
    @track mCity;
    @track mState;
    @track mZip;
    @track mBorough;
    
    @track rBuilding;
    @track rStreet;
    @track rApt;
    @track rCity;
    @track rState;
    @track rZip;
    @track rBorough;
    

    connectedCallback() {
        this.parameters = this.getQueryParameters();
        console.log(this.parameters);
        this.getDetails();
    }

    getQueryParameters() {
        var params = {};
        var search = location.search.substring(1);

        if (search) {
            params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                return key === "" ? value : decodeURIComponent(value)
            });
        }

        return params;
    }

    handleChange(event) {
        //console.log('Changing ',event.target.name,' with value ',event.detail.value);
        switch(event.target.name){
            case 'cell': this.cell = event.detail.value; break;
            case 'tel': this.tel = event.detail.value; break;
            case 'email': this.email = event.detail.value; break;
            case 'mBuilding': this.mBuilding = event.detail.value; break;
            case 'mStreet': this.mStreet = event.detail.value; break;
            case 'mApt': this.mApt = event.detail.value; break;
            case 'mCity': this.mCity = event.detail.value; break;
            case 'mState': this.mState = event.detail.value; break;
            case 'mZip': this.mZip = event.detail.value; break;
            case 'mBorough': this.mBorough = event.detail.value; break;
            case 'rBuilding': this.rBuilding = event.detail.value; break;
            case 'rStreet': this.rStreet = event.detail.value; break;
            case 'rApt': this.rApt = event.detail.value; break;
            case 'rCity': this.rCity = event.detail.value; break;
            case 'rState': this.rState = event.detail.value; break;
            case 'rZip': this.rZip = event.detail.value; break;
            case 'rBorough': this.rBorough = event.detail.value; break;
            default: break;
        }

    }

    saveRecord(event) {
        console.log('Saving Record');
        var wrapperString = {
            Cell : this.cell != null && this.cell != "" && this.cell != undefined ? this.cell : null,
            Tel : this.tel != null && this.tel != "" && this.tel != undefined ? this.tel : null,
            Email : this.email != null && this.email !="" && this.email !== undefined ? this.email : null,
            MBuilding : this.mBuilding != null && this.mBuilding != "" && this.mBuilding != undefined ? this.mBuilding : null,
            MStreet : this.mStreet != null && this.mStreet != "" && this.mStreet != undefined ? this.mStreet : null,
            MApt : this.mApt != null && this.mApt != "" && this.mApt != undefined ? this.mApt : null,
            MCity : this.mCity != null && this.mCity != "" && this.mCity != undefined ? this.mCity : null,
            MState : this.mState != null && this.mState != "" && this.mState != undefined ? this.mState : null,
            MZip : this.mZip != null && this.mZip != "" && this.mZip != undefined ? this.mZip : null,
            MBorough : this.mBorough != null && this.mBorough != "" && this.mBorough != undefined ? this.mBorough : null,
            RBuilding : this.rBuilding != null && this.rBuilding != "" && this.rBuilding != undefined ? this.rBuilding : null,
            RStreet : this.rStreet != null && this.rStreet != "" && this.rStreet != undefined ? this.rStreet : null,
            RApt : this.rApt != null && this.rApt != "" && this.rApt != undefined ? this.rApt : null,
            RCity : this.rCity != null && this.rCity != "" && this.rCity != undefined ? this.rCity : null,
            RState : this.rState != null && this.rState != "" && this.rState != undefined ? this.rState : null,
            RZip : this.rZip != null && this.rZip != "" && this.rZip != undefined ? this.rZip : null,
            RBorough : this.rBorough != null && this.rBorough != "" && this.rBorough ? this.rBorough : null
        }
        console.log(JSON.stringify(wrapperString));
        updateLicenseDetails({
            accountId : this.accountId,
            wrapperString : JSON.stringify(wrapperString)
        }).then( data => {
            if(data == 'SUCCESS'){
                console.log('SUCCESS',data);
                    const evt = new ShowToastEvent({
                        title: 'Success',
                        message: 'Details Updated Sucessfully',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                this.dispatchEvent(evt);
                window.open("https://mtxlpi.force.com/tlcPortal/s/", '_self');
            }
        }).catch(error => {
            console.log(JSON.stringify(error));
            this.getDetails();
        });

    }

    getDetails(){
        getLicenseDetails({ businessLicenseId: this.parameters.licenseId })
            .then(result => {
                console.log('License Details ',result);
                this.data = result;
                this.accountId = result.accountId;
            })
            .catch(error => {
                console.log(error);
            });
    }

}