@isTest
private with sharing class TEST_BCD_PrintLicenseController {
    @testSetup
    private static void createPrintLicenseData() {
        try{
            Account acc = BCD_TestUtility.createAccount('accName', true);
            Contact con = BCD_TestUtility.createContact(true);
            RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Board of Barbers and Cosmetologists', true);
            RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('Student', regAut.Id, true);
            BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
            bl.PeriodStart = system.now();
            bl.PeriodEnd = system.now()+1;
            bl.AccountId = acc.Id;
            bl.RegulatoryAuthorizationTypeId = rat.Id;
            insert bl;
            
            PreliminaryApplicationRef par = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
            par.Business_License__c = bl.Id;
            par.Is_Physical_Address_Different__c = false;
            par.LicenseTypeId__c = rat.Id;
            insert par;
            
            IndividualApplication indApp = new IndividualApplication
                (Attestation_checkbox__c = false,
                 SavedApplicationRefId = par.Id,
                 AppliedDate = Date.today().addDays(100),
                 Category = 'License',
                 System_Approved__c = true,
                 WasReturned = false,
                 LicenseTypeid = rat.Id,
                 LicensePermitNameid=bl.Id,
                 Status = 'Approved'
                );
            insert indApp;
            
            //Create Application Document
            Application_Document__c AppDoc=new Application_Document__c(
                Application_Reference__c=par.Id,
                Metadata_Document_Category__c='Passport Photo');
            insert AppDoc;
            
            ContentVersion content=new ContentVersion(); 
            content.Title='Photo'; 
            content.PathOnClient='/' + content.Title + '.jpg'; 
            Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
            content.VersionData=bodyBlob; 
            content.origin = 'H';
            insert content;
            
            ContentDocumentLink contentlink=new ContentDocumentLink();
            contentlink.LinkedEntityId=AppDoc.id;
            contentlink.contentdocumentid=[select contentdocumentid from contentversion where id =: content.id].contentdocumentid;
            contentlink.ShareType = 'I';
            contentlink.Visibility = 'AllUsers'; 
            insert contentlink;
        } catch(Exception e) {
            system.debug('Exception in createBoardMeetingData method : '+e.getStackTraceString()+'\n'+e.getLineNumber());
        }
    }
    
    private static testMethod void runInvocableBatch() {
        try{
            //get the business license Id
            String businessLicenseId = [SELECT Id FROM BusinessLicense LIMIT 1].get(0).Id;
            User u = [SELECT Id FROM User LIMIT 1].get(0);
            Test.startTest();
            System.runAs(u) {
                PageReference pageRef = Page.BCD_PrintLicenseExternal;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('Id', businessLicenseId);
                BCD_PrintLicenseController obj = new BCD_PrintLicenseController();
                obj.initExternal();
                obj.initInternal();
            }
            
            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    
}