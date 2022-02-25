import { LightningElement, track, wire } from 'lwc';
import isGuest from "@salesforce/user/isGuest";
import NAME_FIELD from "@salesforce/schema/User.Name";
import USER_ID from "@salesforce/user/Id";
import basePath from "@salesforce/community/basePath";
import { getRecord } from "lightning/uiRecordApi";
import fetchUserDetail from "@salesforce/apex/ManageUserController.fetchUserDetail";
import lpiLogo from "@salesforce/resourceUrl/lpiLogo";
import { NavigationMixin } from 'lightning/navigation';




export default class LpiHeader extends NavigationMixin(LightningElement) {

    @track showSpinner;
    @track logo;
    @track profileUrl;
    value = 'English';
    @track name;


    @wire(getRecord, {
        recordId: USER_ID,
        fields: [NAME_FIELD],
    })
    wireuser({ error, data }) {
        if (error) {
            console.log('error :>> ', error);
            // this.showSpinner = false;
        } else if (data) {
            this.name = data.fields.Name.value;
            console.log('this.name :>> ', this.name);
            // this.showSpinner = false;
        }
    }

    connectedCallback() {

        // this.showSpinner = true;
        this.getProfilePicture();
        this.logo = lpiLogo;
    }

    get options() {
        return [
            { label: 'English', value: 'English' },
            { label: 'Hindi', value: 'Hindi' },
            { label: 'Spanish', value: 'Spanish' },
        ];
    }

    get license() {
        return [
            { label: 'View License', value: 'View License' },
            { label: 'Apply For License', value: 'Apply For License' },
        ];
    }

    // get summons() {
    //     return [
    //         { label: 'summons', value: 'Summons' },
    //         { label: 'summons', value: 'summons' },
    //         { label: 'summons', value: 'summons' },
    //     ];
    // }

    get complaints() {
        return [
            { label: 'Raise a Complaint', value: 'Raise a Complaint' },
            { label: 'View Complaints', value: 'View Complaints' },
        ];
    }



    handleNotification() {
        console.log("Navigate");
        window.open("/tlcPortal/s/", "_self");
    }

    navigateToHome() {
        window.open("/tlcPortal/s/", "_self");
    }

    navigateToPage() {
        window.open("/tlcPortal/s/summons-and-settlements", "_self");
    }

    handleChange(event) {
        this.value = event.detail.value;
        if (event.target.name == 'license') {
            if (event.target.value == 'Apply For License') {
                window.open("/tlcPortal/s/license-application/", "_self");
            }
            else if (event.target.value == 'View License') {
                window.open("/tlcPortal/s/view-license", "_self");
            }
        }
        if (event.target.name == 'complaints') {
            if(event.target.value == 'Raise a Complaint'){
                window.open("https://mtxlpi.force.com/tlcPortal/s/raise-complaint","_self");
            }
        }
    }

    // logout
    get isGuest() {
        return isGuest;
    }

    get logoutLink() {
        const sitePrefix = basePath.replace(/\/s$/i, ""); // site prefix is the site base path without the trailing "/s"
        return sitePrefix + "/secur/logout.jsp";
    }
    getProfilePicture() {
        this.showSpinner = true;
        fetchUserDetail()
            .then((result) => {
                // console.log('result :>> ', result.FullPhotoUrl);
                this.profileUrl = result.FullPhotoUrl;
                this.showSpinner = false;
            })
            .catch((error) => {
                // console.log("Error", error);
                this.showSpinner = false;
            });
    }
}