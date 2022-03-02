import { LightningElement } from "lwc";
import SaveForLateExisting from "vlocity_ins/omniscriptSaveForLaterAcknowledge";
import tmpl from "./customSFLVehicle.html";

export default class CustomSFLVehicle extends SaveForLateExisting {
    render() {
        return tmpl;
    }

    handleBackToHomeButton() {
        window.open("/tlcPortal/s", "_self");
    }
}