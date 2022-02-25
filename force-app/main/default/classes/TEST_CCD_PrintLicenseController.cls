@isTest
public class TEST_CCD_PrintLicenseController {
    @testSetup
    private static void createPrintLicenseData() {
        try{
            Account acc = BCD_TestUtility.createAccount('accName', true);
            Contact con = BCD_TestUtility.createContact(true);
            RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Cannabis Control Division', true);
            RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('LNPP License Renewal', regAut.Id, true); 
            RegulatoryAuthorizationType manufacturerRAT = BCD_TestUtility.createRegulatoryAuthorizationType('Cannabis Manufacturer', regAut.Id, true);
            RegulatoryAuthorizationType VICERAT = BCD_TestUtility.createRegulatoryAuthorizationType('Vertically Integrated Cannabis Establishment', regAut.Id, true);
            List<BusinessLicense> businessLicenseList = new List<BusinessLicense>();
            BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
            bl.Name = 'CCDTest-2021-0001';
            bl.PeriodStart = system.now();
            bl.PeriodEnd = system.now()+365;
            bl.AccountId = acc.Id;
            bl.RegulatoryAuthorizationTypeId = rat.Id;
            insert bl;
            BusinessLicense parentBL = BCD_TestUtility.createBusinessLicense(con.Id, false);
            parentBL.Name = 'CCDTest-VICE-2021-0001';
            parentBL.PeriodStart = system.now();
            parentBL.PeriodEnd = system.now()+365;
            parentBL.AccountId = acc.Id;
            parentBL.RecordTypeId = Schema.SObjectType.BusinessLicense.getRecordTypeInfosByDeveloperName().get('Vice_License').getRecordTypeId();
            parentBL.RegulatoryAuthorizationTypeId = VICERAT.Id;
            insert parentBL;
            BusinessLicense bl2 = BCD_TestUtility.createBusinessLicense(con.Id, false);
            bl2.Name = 'CCDTest-VICE-MANU-2021-0001';
            bl2.PeriodStart = system.now();
            bl2.PeriodEnd = system.now()+365;
            bl2.AccountId = acc.Id;
            bl2.Parent_Business_License__c = parentBL.Id;
            bl2.RegulatoryAuthorizationTypeId = manufacturerRAT.Id;
            insert bl2;
            BusinessLicense subLicense = BCD_TestUtility.createBusinessLicense(con.Id, false);
            subLicense.Name = 'CCDTest-VICE-MANU-2021-0001-001';
            subLicense.PeriodStart = system.now();
            subLicense.PeriodEnd = system.now()+365;
            subLicense.AccountId = acc.Id;
            subLicense.Parent_Business_License__c = bl2.Id;
            subLicense.License_Type__c = 'Sub license';
            subLicense.RegulatoryAuthorizationTypeId = manufacturerRAT.Id;
            insert subLicense;
            
            List<PreliminaryApplicationRef> PARList = new List<PreliminaryApplicationRef>();
            PreliminaryApplicationRef par = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
            par.Business_License__c = bl.Id;
            par.Is_Physical_Address_Different__c = false;
            PARList.add(par);
            
            Business_Information__c businessInfo = new Business_Information__c();
            businessInfo.Business_Legal_Name__c = 'Legal Name Test';
            businessInfo.Doing_Business_As_DBA__c  = 'DBA Test';
            businessInfo.Mailing_Address_Check__c  = false;
            businessInfo.Account__c  = acc.Id;
            insert businessInfo;
            
            PreliminaryApplicationRef VICEPAR = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
            VICEPAR.Business_License__c = bl2.Id;
            VICEPAR.Is_Physical_Address_Different__c = false;
            VICEPAR.Business_Information__c = businessInfo.Id;
            PARList.add(VICEPAR);
            insert PARList;
            
            List<Schema.Location> locationList = new List<Schema.Location>();
            Schema.Location loc = new Schema.Location();
        	loc.Name = 'Business Contact Location';
            loc.LocationType = 'Physical';
            loc.Preliminary_Application_Ref__c = par.Id;
            locationList.add(loc);
            
            Schema.Location physicalLocation = new Schema.Location();
        	physicalLocation.Name = 'Business Contact Location';
            physicalLocation.LocationType = 'Physical';
            physicalLocation.Business_Information__c = businessInfo.Id;
            locationList.add(physicalLocation);
            insert locationList;
            
            List<Schema.Address> addressList = new List<Schema.Address>();
            for(Schema.Location locVar : locationList){
                Schema.Address add = new Schema.Address();
                add.LocationType = 'Physical';
                add.Street = 'Test Street1';
                add.Street_2__c = 'Test';
                add.City = 'Test City1';
                add.State = 'New Mexico';
                add.ParentId = locVar.Id;
                addressList.add(add);
            }
            
            insert addressList;
            
            User testUser = BCD_TestUtility.createUser(true);
            System.runAs(testUser){
                
                Blob bodyBlob=Blob.valueOf('Unit Test'); 
                
                ContentVersion contentVersion_1 = new ContentVersion(
                    Title='Internal Test', 
                    PathOnClient ='SampleTitle.jpg',
                    VersionData = bodyBlob, 
                    origin = 'H'
                );
                insert contentVersion_1;
                
                ContentVersion contentVersion_2 = [SELECT Id, Title, ContentDocumentId 
                                                   FROM ContentVersion WHERE Id = :contentVersion_1.Id LIMIT 1];
                
                ContentDocumentLink contentlink = new ContentDocumentLink();
                contentlink.LinkedEntityId = bl.Id;
                contentlink.contentdocumentid = contentVersion_2.contentdocumentid;
                contentlink.ShareType = 'V';
                insert contentlink;
            }
            
        } catch(Exception e) {
            system.debug('Exception in createBoardMeetingData method : '+e.getStackTraceString()+'\n'+e.getLineNumber());
        }
    }
    
    private static testMethod void runInvocableBatch() {
        try{
            //get the business license Id
            String businessLicenseId = [SELECT Id FROM BusinessLicense WHERE RegulatoryAuthorizationType.Name = 'LNPP License Renewal' LIMIT 1].get(0).Id;
            User u = [SELECT Id FROM User LIMIT 1].get(0);
            Test.startTest();
            System.runAs(u) {
                PageReference pageRef = Page.CCD_PrintLicenseExternal;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('Id', businessLicenseId);
                CCD_PrintLicenseController obj = new CCD_PrintLicenseController();
                obj.initExternal();
                obj.initInternal();
            }

            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    
        private static testMethod void runInvocableBatch_Test2() {
        try{
            //get the business license Id
            String businessLicenseId = [SELECT Id FROM BusinessLicense WHERE RegulatoryAuthorizationType.Name = 'LNPP License Renewal' LIMIT 1].get(0).Id;
            PreliminaryApplicationRef par = [SELECT Id,Is_Physical_Address_Different__c,Business_Information__c FROM PreliminaryApplicationRef WHERE Business_Information__c = NULL LIMIT 1];
            par.Is_Physical_Address_Different__c = true;
            update par;
            Schema.Location loc = new Schema.Location();
        	loc.Name = 'Mailing Location';
            loc.LocationType = 'Mailing';
            loc.Preliminary_Application_Ref__c = par.Id;
            insert loc;
            
            Schema.Address add = new Schema.Address();
            add.LocationType = 'Mailing';
            add.Street = 'Test Street';
            add.Street_2__c = 'Test Street2';
            add.City = 'Test City';
            add.State = 'New Mexico';
            add.ParentId = loc.Id;
            insert add;
            User u = [SELECT Id FROM User LIMIT 1].get(0);
            Test.startTest();
            System.runAs(u) {
                PageReference pageRef = Page.CCD_PrintLicenseExternal;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('Id', businessLicenseId);
                CCD_PrintLicenseController obj = new CCD_PrintLicenseController();
                obj.initExternal();
                obj.initInternal();
            }

            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    
        private static testMethod void runInvocableBatch_VICE() {
        try{
            //get the business license Id
            String businessLicenseId = [SELECT Id FROM BusinessLicense WHERE RegulatoryAuthorizationType.Name = 'Vertically Integrated Cannabis Establishment' LIMIT 1].get(0).Id;
            User u = [SELECT Id FROM User LIMIT 1].get(0);
            Test.startTest();
            System.runAs(u) {
                PageReference pageRef = Page.CCD_PrintLicenseExternal;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('Id', businessLicenseId);
                CCD_PrintLicenseController obj = new CCD_PrintLicenseController();
                obj.initExternal();
                obj.initInternal();
            }

            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    
            private static testMethod void runInvocableBatch_VICESubLicense() {
        try{
            //get the business license Id
            String businessLicenseId = [SELECT Id FROM BusinessLicense WHERE RegulatoryAuthorizationType.Name = 'Cannabis Manufacturer' AND License_Type__c != 'Sub license' LIMIT 1].get(0).Id;
            User u = [SELECT Id FROM User LIMIT 1].get(0);
            Test.startTest();
            System.runAs(u) {
                PageReference pageRef = Page.CCD_PrintLicenseExternal;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('Id', businessLicenseId);
                CCD_PrintLicenseController obj = new CCD_PrintLicenseController();
                obj.initExternal();
                obj.initInternal();
            }

            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    
    private static testMethod void runInvocableBatch_VICESubLicenseMailing() {
        try{
            //get the business license Id
            String businessLicenseId = [SELECT Id FROM BusinessLicense WHERE RegulatoryAuthorizationType.Name = 'Cannabis Manufacturer' AND License_Type__c != 'Sub license' LIMIT 1].get(0).Id;
            PreliminaryApplicationRef par = [SELECT Id,Is_Physical_Address_Different__c,Business_Information__c FROM PreliminaryApplicationRef WHERE Business_Information__c != NULL LIMIT 1];
            par.Is_Physical_Address_Different__c = true;
            update par;
            Schema.Location loc = new Schema.Location();
        	loc.Name = 'Mailing Location';
            loc.LocationType = 'Mailing';
            loc.Business_Information__c = par.Business_Information__c;
            insert loc;
            
            Schema.Address add = new Schema.Address();
            add.LocationType = 'Mailing';
            add.Street = 'Test Street';
            add.Street_2__c = 'Test Street2';
            add.City = 'Test City';
            add.State = 'New Mexico';
            add.ParentId = loc.Id;
            insert add;
            User u = [SELECT Id FROM User LIMIT 1].get(0);
            Test.startTest();
            System.runAs(u) {
                PageReference pageRef = Page.CCD_PrintLicenseExternal;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('Id', businessLicenseId);
                CCD_PrintLicenseController obj = new CCD_PrintLicenseController();
                obj.initExternal();
                obj.initInternal();
            }

            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
     
    
}