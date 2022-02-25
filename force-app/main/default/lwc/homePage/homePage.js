import { LightningElement, track } from "lwc";
import lpiImages from "@salesforce/resourceUrl/lpiImages";

//import globalCss from "@salesforce/resourceUrl/globalCss";

export default class HomePage extends LightningElement {

    @track bannerImage = lpiImages + "/tlcImages/bannerBg.jpeg";


}