/**
* @description       : Controller to pass data to internal and external license pages of BCD
* @author            : Gopal Jangir
* @group             : MTX Ltd.
* @last modified on  : 08-24-2021
* @last modified by  : Shobhit Pant
* Modifications Log
* Ver   Date         Author            Modification
* 1.0 Gopal Jangir		Initial Version
* 2.0 Shobhit Pant  	Changes to Alignment, other fixes, added comments 
**/

public with sharing class BCD_PrintLicenseController {
    
    //Global variables
    String isSave;															
    public string recordId;
    public List<BusinessLicense> businessLicenseList{get;set;}
    public List<DataWrapper> displayData{get;set;}
    
    public Map<String, DataWrapper> displayDataMap;
    
    /**
    * Public Constructor for getting and setting license information
    */
    public BCD_PrintLicenseController(){
        
        displayDataMap = new Map<String, DataWrapper>();
        
        List<BusinessLicense> licensesWithAccount = new List<BusinessLicense>();	//only contain the licenses that have Account (Organization) populted
        isSave = ApexPages.currentPage().getParameters().get('dosavethepdf');	//get the isSave param from the passed URL
        recordId = ApexPages.currentPage().getParameters().get('Id');	//Ids could be a multiple - as a list
        
        //Create a list of the ids passed in the URL
        List<String> recordIdList = recordId.split(',');
        
        //Get business license information from the ids
        businessLicenseList = new List<BusinessLicense>( [Select id, AccountId, TemporaryLicense__c, Status, Account.FirstName,Account.MiddleName, Account.LastName, Name, RegulatoryAuthorizationType.Name, RegulatoryAuthorizationType.External_Id__c, Account.PersonMailingStreet ,
                                                          Account.PersonMailingCity, PeriodStart , PeriodEnd,Account.PersonMailingState,Account.PersonMailingPostalCode,Account.Mailing_Street_Address_2__c,
                                                          RegulatoryAuthorizationType.IssuingDepartment.Name,Trade_Name__c, Business_Name__c, Physical_Street_1__c, Physical_Street_2__c, License_Type__c, RegulatoryAuthorizationType.IssuingDepartment.ExternalId__c 
                                                          from BusinessLicense Where id IN : recordIdList] );
        
        //for each license, create the pdf information
        for(BusinessLicense bLicense : businessLicenseList) {
            
            if(bLicense.AccountId == null) {
                continue;
            }
            //create a new datawrapper object
            DataWrapper dw = new DataWrapper();
            
            //format the address
            bLicense.Account.PersonMailingStreet = (String.isNotEmpty(bLicense.Account.PersonMailingStreet)&&String.isNotBlank(bLicense.Account.PersonMailingStreet))?bLicense.Account.PersonMailingStreet+'':'';
            bLicense.Account.Mailing_Street_Address_2__c = (String.isNotEmpty(bLicense.Account.Mailing_Street_Address_2__c)&&String.isNotBlank(bLicense.Account.Mailing_Street_Address_2__c))?bLicense.Account.Mailing_Street_Address_2__c+'':'';
            bLicense.Account.PersonMailingCity = (String.isNotEmpty(bLicense.Account.PersonMailingCity)&&String.isNotBlank(bLicense.Account.PersonMailingCity))?bLicense.Account.PersonMailingCity+'':'';
            bLicense.Account.PersonMailingState = (String.isNotEmpty(bLicense.Account.PersonMailingState)&&String.isNotBlank(bLicense.Account.PersonMailingState))?bLicense.Account.PersonMailingState+'':'';
            //format the name
            bLicense.Account.FirstName = (String.isNotEmpty(bLicense.Account.FirstName)&&String.isNotBlank(bLicense.Account.FirstName))?bLicense.Account.FirstName:'';
            bLicense.Account.MiddleName = (String.isNotEmpty(bLicense.Account.MiddleName)&&String.isNotBlank(bLicense.Account.MiddleName))?bLicense.Account.MiddleName:'';
            bLicense.Account.LastName = (String.isNotEmpty(bLicense.Account.LastName)&&String.isNotBlank(bLicense.Account.LastName))?bLicense.Account.LastName:'';
            bLicense.Account.Name = bLicense.Account.FirstName+' '+bLicense.Account.MiddleName+' '+bLicense.Account.LastName;
            //format dates
            if(bLicense.PeriodStart != null) {
                dw.StartDate = bLicense.PeriodStart.format('MM/dd/yyyy','America/Los_Angeles');
            }
            if(bLicense.PeriodEnd != null) {
                dw.EndDate = bLicense.PeriodEnd.format('MM/dd/yyyy','America/Los_Angeles');
            }
            
            dw.RegAuthName = bLicense.RegulatoryAuthorizationType.Name;
            
            //for BNC, show license type rather than Authurization type
            if(bLicense.RegulatoryAuthorizationTypeId != null && bLicense.RegulatoryAuthorizationType.IssuingDepartmentId != null && bLicense.RegulatoryAuthorizationType.IssuingDepartment.ExternalId__c == 'Barbers & Cosmetologists' && !String.isBlank(bLicense.License_Type__c)){
                //bLicense.RegulatoryAuthorizationType.Name = bLicense.License_Type__c;
                dw.RegAuthName = bLicense.License_Type__c;
            }
            //If its a CPA license and is Inactive - display it on the PDF
            if (!String.isblank(bLicense.RegulatoryAuthorizationTypeId) && bLicense.RegulatoryAuthorizationTypeId != null && (bLicense.RegulatoryAuthorizationType.External_Id__c == 'CPA'|| bLicense.RegulatoryAuthorizationType.External_Id__c == 'Registered Public Accountant') && bLicense.Status == 'Inactive') {
                //bLicense.RegulatoryAuthorizationType.Name  = 'Inactive - '+bLicense.RegulatoryAuthorizationType.Name;
                dw.RegAuthName = 'Inactive - '+bLicense.RegulatoryAuthorizationType.Name;
            }
            //If its a temporary license, show temporary for C&T and Provisional for SW
            if (bLicense.RegulatoryAuthorizationTypeId != null && bLicense.RegulatoryAuthorizationType.IssuingDepartmentId != null && bLicense.TemporaryLicense__c == true){
				//if the license belongs to C&T board
                if(bLicense.RegulatoryAuthorizationType.IssuingDepartment.ExternalId__c == 'Counseling') {
                    dw.RegAuthName = 'Temporary '+dw.RegAuthName;
                } else if (bLicense.RegulatoryAuthorizationType.IssuingDepartment.ExternalId__c == 'Social Work'){
                    dw.RegAuthName = 'Provisional '+dw.RegAuthName;
                }
            }
            if (bLicense.RegulatoryAuthorizationTypeId != null && bLicense.RegulatoryAuthorizationType.IssuingDepartmentId != null && bLicense.RegulatoryAuthorizationType.IssuingDepartment.ExternalId__c == 'Accountancy'){
                dw.ShowBoardNameOnWalletLicense = false;
            } else {
                dw.ShowBoardNameOnWalletLicense = true;
            }
            
            //For firm permit, establishment and school show additional data
            if(bLicense.RegulatoryAuthorizationType.External_Id__c == 'Establishment' || bLicense.RegulatoryAuthorizationType.External_Id__c == 'Firm Permit' || bLicense.RegulatoryAuthorizationType.External_Id__c == 'School') {
                dw.ShowAdditionalInfo = true;
            } else {
                dw.ShowAdditionalInfo = false;
            }
            
            licensesWithAccount.add(bLicense);
            dw.licenseToDisplay = bLicense;
            displayDataMap.put(bLicense.Id, dw);
        }
        String myGeneratedFileName = 'licensePdf'; 
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+myGeneratedFileName+'.pdf');
        Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename='+myGeneratedFileName+'.pdf');
    }
    /*
    * Page action method for internal page
    */
    public void initInternal(){
        setDisplayData();
        initHelper('Internal');
    }
    /*
    * Page action method for external page
    */
    public void initExternal(){
        setDisplayData();
        initHelper('External');
    }
    
    public void setDisplayData() {
        Map<String, String> licenseIdToAttachmentIdMap = generateAttachmentsOnLicenses(displayDataMap.keySet());
        if(displayDataMap.size()>0 && licenseIdToAttachmentIdMap.size()>0) {
            for(String licenseId : displayDataMap.keySet()) {
                if(licenseIdToAttachmentIdMap.containsKey(licenseId)){
                    displayDataMap.get(licenseId).AttachmentId = licenseIdToAttachmentIdMap.get(licenseId);
                }
            }
        }
        displayData = displayDataMap.values();
    }
    /**
    * This method is used to create license pdf
    * and attach to the parent record as a file
    * deletes any already existing versions of the license
    * @param String flow - can only contain internal or external as values
    * @return void
    */
    private void initHelper(String flow){
        //only proceed if isSave param is null (set not null for batch)
        if( isSave == null && businessLicenseList.size()>0){
            //Step 1: Delete documents from the same day and from the same users
            List<ContentDocument> dd_Del = new List<ContentDocument>();
            
            for( ContentDocumentLink cDoc : [SELECT id,ContentDocumentId FROM ContentDocumentLink 
                                             Where LinkedEntityId =: businessLicenseList[0].Id 
                                             AND ContentDocument.CreatedDate = Today
                                             AND ContentDocument.OwnerId =: UserInfo.getUserId()
                                             And ContentDocument.Title LIKE: '%'+ flow +'%'] ){
                                                 dd_Del.add( new ContentDocument(Id = cDoc.ContentDocumentId ) );
                                                 
                                             }
            
            if( !dd_Del.isEmpty() ){
                delete dd_Del;
            }
            
            //Step 2: Create Content Document
            
            //A: Generate PDF from VF
            PageReference pagePdf; 
            if(flow == 'Internal'){
                pagePdf = Page.BCD_PrintLicenseInternal; 
            } else {
                pagePdf = Page.BCD_PrintLicenseExternal; 
            }
            pagePdf.getParameters().put('Id', businessLicenseList[0].Id); 
            pagePdf.getParameters().put('dosavethepdf', 'yes'); 
            
            //B: Creating ContentVersion
            ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
            cVersion.PathOnClient = flow+'_License_' + businessLicenseList[0].Name+ '.pdf';//File name with extention
            cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
            cVersion.Title = flow+'_License_' + businessLicenseList[0].Name+ '.pdf';//Name of the file
            cVersion.VersionData = Test.isRunningTest() ? Blob.valueOf('UNIT.TEST') : pagePdf.getContentAsPdf();//File content
            insert cVersion;
            
            //C: Create Content Document Link
            ContentVersion cVer = [SELECT ContentDocumentId,VersionData FROM ContentVersion WHERE Id = :cVersion.Id];
            ContentDocumentLink cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = cVer.ContentDocumentId;//Add ContentDocumentId
            cDocLink.LinkedEntityId = businessLicenseList[0].Id;//Add attachment parentId
            cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
            insert cDocLink;
        }
    }
    public Map<String, String> generateAttachmentsOnLicenses (Set<String> licenseIds) {
        Map<String, String> parToLicenseMap = new Map<String, String>();
        Map<String, String> licenseToAttachmentMap = new Map<String, String>();
        Map<String, String> appDocToParMap = new Map<String, String>();
        Map<String, String> contentDocToParMap = new Map<String, String>();
        List<Attachment> attachmentList = new List <Attachment>();
        
        for(IndividualApplication ia : [SELECT Id, LicensePermitNameId, SavedApplicationRefId FROM IndividualApplication WHERE LicensePermitNameId IN : licenseIds ORDER By CreatedDate DESC]){
            //dont add if record already exists
            if(!parToLicenseMap.containsKey(ia.SavedApplicationRefId)) {
                //Add the most recent application's PAR to the license map
                parToLicenseMap.put(ia.SavedApplicationRefId, ia.LicensePermitNameId);
            }
        }
        system.debug(parToLicenseMap);
        //get all the attachments associated to the PAR
        for(PreliminaryApplicationRef par : [SELECT Id, (SELECT Id, Name FROM Attachments WHERE Name LIKE '%Photograph%'), (SELECT Id FROM Application_Documents__r WHERE Metadata_Document_Category__c LIKE '%Passport%Photo%' OR Metadata_Document_Category__c = 'Photograph') FROM PreliminaryApplicationRef WHERE Id IN : parToLicenseMap.keySet()]) {
            if(par.Attachments != null && par.Attachments.size()>0) {
                licenseToAttachmentMap.put(parToLicenseMap.get(par.Id), par.Attachments.get(0).Id);
            } else if (par.Application_Documents__r.size()>0) {
                appDocToParMap.put(par.Application_Documents__r.get(0).Id, par.Id);
            }
        }
        if(appDocToParMap.size()>0) {
            for(ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId IN : appDocToParMap.keySet()]) {
                contentDocToParMap.put(cdl.ContentDocumentId, appDocToParMap.get(cdl.LinkedEntityId));
            }
        }
        if(contentDocToParMap.size()>0) {
            for(ContentVersion cv : [SELECT VersionData, Id, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN : contentDocToParMap.keySet()]) {
                Attachment att=new Attachment();
                att.Body= cv.VersionData;
                att.Name= 'Photograph' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.jpg';
                att.parentId=contentDocToParMap.get(cv.ContentDocumentId);
                attachmentList.add(att);
                if(!licenseToAttachmentMap.containsKey(parToLicenseMap.get(contentDocToParMap.get(cv.ContentDocumentId)))) {
                    licenseToAttachmentMap.put(parToLicenseMap.get(contentDocToParMap.get(cv.ContentDocumentId)), att.Id);
                }
            }
        }
        if(attachmentList.size()>0) {
            insert attachmentList;
            //get the attachment ids
            for(PreliminaryApplicationRef par : [SELECT Id, (SELECT Id, Name FROM Attachments WHERE Name LIKE '%Photograph%') FROM PreliminaryApplicationRef WHERE Id IN : appDocToParMap.values()]) {
                if(par.Attachments != null && par.Attachments.size()>0) {
                    licenseToAttachmentMap.put(parToLicenseMap.get(par.Id), par.Attachments.get(0).Id);
                }
            }
        }
        system.debug(licenseToAttachmentMap);
        return licenseToAttachmentMap;
    }
    
    public class DataWrapper{
        public BusinessLicense licenseToDisplay {get;set;}
        public String StartDate {get;set;}
        public String EndDate {get;set;}
        public String AttachmentId{get;set;}
        public String RegAuthName {get;set;}
        public Boolean ShowAdditionalInfo {get;set;}
        public Boolean ShowBoardNameOnWalletLicense {get;set;}
    }
}