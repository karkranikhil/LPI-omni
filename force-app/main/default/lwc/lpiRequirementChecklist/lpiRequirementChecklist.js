import { LightningElement, track } from 'lwc';
import lpiImages from "@salesforce/resourceUrl/lpiImages";

export default class LpiRequirementChecklist extends LightningElement {
    @track dueDate;
    @track requirementList; 

    @track isVehicle = false;

    @track renewal = lpiImages + "/tlcImages/renewal.svg";
    connectedCallback() {
        const param = 'isVehicle';
        if(this.getUrlParamValue(window.location.href, param) == 'true'){
            this.isVehicle = true;
        }else if(this.getUrlParamValue(window.location.href, param) == null){
            this.isVehicle = true;
        }

        console.log('>>>>>>>>>>> ', this.getUrlParamValue(window.location.href, param));
        
        var today = new Date();
        var tomorrow = new Date();
        tomorrow.setDate(today.getDate()+31);
    //this.date=today.toISOString();
        console.log(today.toLocaleDateString("en-US"));
        this.dueDate = tomorrow.toLocaleDateString("en-US");
       this.requirementList = [{ Id: 1, Name: "Complete Application Form", Checked: true, date:"" },
                                    { Id: 2, Name: "Drug Test", Checked: false , date:this.dueDate},
                                    { Id: 3, Name: "Fingerprints", Checked: false, date:this.dueDate },
                                    { Id: 4, Name: "DMV Course", Checked: false, date:this.dueDate },
                                    { Id: 5, Name: "24 Hour Course", Checked: false, date:this.dueDate },
                                    { Id: 6, Name: "Medical Exam", Checked: false, date:this.dueDate }];
    }

    getUrlParamValue(url, key) {
        return new URL(url).searchParams.get(key);
    }
}