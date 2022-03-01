import { LightningElement, track } from 'lwc';
import lpiImages from "@salesforce/resourceUrl/lpiImages";

export default class LpiRequirementChecklist extends LightningElement {
    @track requirementList = [{ Id: 1, Name: "Complete Application Form", Checked: true },
                                    { Id: 2, Name: "Drug Test", Checked: false },
                                    { Id: 3, Name: "Fingerprints", Checked: false },
                                    { Id: 4, Name: "DMV Course", Checked: false },
                                    { Id: 5, Name: "24 Hour Course", Checked: false },
                                    { Id: 6, Name: "Medical Exam", Checked: false }];

    @track renewal = lpiImages + "/tlcImages/renewal.svg";
}