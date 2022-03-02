import { LightningElement, track } from "lwc";
import lpiImages from "@salesforce/resourceUrl/lpiImages";

export default class AuickLinks extends LightningElement {
    @track fees = lpiImages + "/tlcImages/fees.svg";
    @track newlicense = lpiImages + "/tlcImages/newlicense.svg";
    @track renewallicense = lpiImages + "/tlcImages/renewallicense.svg";
    @track summons = lpiImages + "/tlcImages/summons.svg";
    @track updatelicense = lpiImages + "/tlcImages/updatelicense.svg";

    applyLicense() {
        console.log("open License");
        window.open("./license-application", "_self");
    }

    licenseRenewal() {
        console.log("license Renewal");
        window.open("./license-renewal", "_self");
    }

    updateLicense() {
        console.log("update License");
        window.open("./update-license", "_self");
    }
    summons() {
        console.log("summons and Settlements");
        window.open("./summons-and-settlements", "_self");
    }
    raiseComplaint() {
        console.log("open License");
        window.open("./raise-complaint", "_self");
    }
}