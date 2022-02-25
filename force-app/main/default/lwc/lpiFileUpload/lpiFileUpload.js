import { LightningElement, api, track } from 'lwc';

export default class LpiFileUpload extends LightningElement {
    @api myRecordId;
    @track showFiles = false;
    @track fileName;
    @track uploadedFiles;

    get acceptedFormats() {
        return ['.pdf', '.png', '.pdf'];
    }

    handleUploadFinished(event) {
        this.showFiles = true;
        this.uploadedFiles = event.detail.files;
        this.fileName = this.uploadedFiles[0].name;
        console.log('uploadedFiles :>> ', this.fileName);
        console.log('No. of files uploaded : ' + JSON.stringify(this.uploadedFiles));
    }
    handleDeleteFile() {
        this.showFiles = false;
        this.fileName = '';
    }
    handlePreviewFile() {
        let baseURL = "https://" + location.host + "/";
        var docId = this.uploadedFiles[0].contentVersionId;
        let fileURL = baseURL +
            "sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=" +
            docId;
        window.open(fileURL, "_blank");
        console.log('fileURL :>> ', fileURL);
    }
}