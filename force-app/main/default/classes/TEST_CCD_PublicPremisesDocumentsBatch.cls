@isTest
public with sharing class TEST_CCD_PublicPremisesDocumentsBatch {
    
    @testSetup
    public static void createData(){
        
        User usr = BCD_TestUtility.createCommunityUser('Customer Community User Profile');
        Schema.Location premise1 = new Schema.Location();
        Schema.Location premise2 = new Schema.Location();
        System.runAs(usr){
            String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
            Account acc= new Account(
                RecordTypeID=recordTypeId ,
                FirstName='Test FName',
                LastName='Test LName',
                PersonMailingStreet='test@yahoo.com',
                PersonMailingPostalCode='12345',
                PersonMailingCity='SFO',
                PersonEmail='test@yahoo.com',
                PersonHomePhone='1234567',
                PersonMobilePhone='12345678'
            );
            
            insert acc;
            Contact contact = [SELECT Id,FirstName,AccountId FROM Contact WHERE FirstName='con1'];
            List<RegulatoryAuthority> RegulatoryAuthorityInsertList = new List<RegulatoryAuthority>();
            List<RegulatoryAuthorizationType> RegulatoryAuthorityTypeInsertList = new List<RegulatoryAuthorizationType>();
            List<PreliminaryApplicationRef> prelimList = new List<PreliminaryApplicationRef>();
            List<String> RegulatoryAuthorityList = new List<String>{'Cannabis'};
                for(String regA : RegulatoryAuthorityList){
                    RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority(regA, false);
                    regAut.ExternalId__c = regA;
                    RegulatoryAuthorityInsertList.add(regAut);
                }
            Insert RegulatoryAuthorityInsertList;
            
            for(RegulatoryAuthority regAuth : RegulatoryAuthorityInsertList){
                RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType(regAuth.Name, regAuth.Id, false);
                rat.RegulatoryAuthCategory = 'License';  
                RegulatoryAuthorityTypeInsertList.add(rat);
            }
            insert RegulatoryAuthorityTypeInsertList;
            
            	RegulatoryAuthorizationType regulatoryType = [SELECT Id from RegulatoryAuthorizationType LIMIT 1];
                PreliminaryApplicationRef appRef = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
                appRef.LicenseTypeId__c = regulatoryType.Id;
                appRef.Firm_Name__c = 'Test Business Name1';
            	prelimList.add(appRef);
            	PreliminaryApplicationRef appRef2 = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
                appRef2.LicenseTypeId__c = regulatoryType.Id;
                appRef2.Firm_Name__c = 'Test Business Name2';
                prelimList.add(appRef2);
            insert prelimList;
            
            List<Schema.Location> premisesList = new List<Schema.Location>();
            premise1.Preliminary_Application_Ref__c = appRef.Id;
            premise1.Name = 'Premise Details';
            premise1.LocationType = 'Premise'; 
            premisesList.add(premise1);
            premise2.Preliminary_Application_Ref__c = appRef2.Id;
            premise2.Name = 'Premise Details2';
            premise2.LocationType = 'Premise';
            premisesList.add(premise2);
            insert premisesList;
        }
        
       Blob bodyBlob=Blob.valueOf('Unit Test');
        	ContentVersion cVersion = new ContentVersion(
            Title='Internal Test', 
            PathOnClient ='SampleTitle.jpg',
            VersionData = bodyBlob, 
            origin = 'H');
            insert cVersion;
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;

        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;
        cDocLink.LinkedEntityId = premise1.Id;
        cDocLink.ShareType = 'V';
        cDocLink.Visibility = 'AllUsers';
        Insert cDocLink;
            
       // Blob bodyBlob=Blob.valueOf('Unit Test');
        ContentVersion cVersion2 = new ContentVersion(
			Title='Internal Test', 
            PathOnClient ='SampleTitle.jpg',
            VersionData = bodyBlob, 
            origin = 'H');
        insert cVersion2;

        Id conDocument2 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion2.Id].ContentDocumentId;

        ContentDocumentLink cDocLink2 = new ContentDocumentLink();
        cDocLink2.ContentDocumentId = conDocument2;
        cDocLink2.LinkedEntityId = premise2.Id;
        cDocLink2.ShareType = 'V';
        cDocLink2.Visibility = 'AllUsers';
        Insert cDocLink2;
            
    }
    
     @isTest(seeAllData=false)
    public static void premisesDocumentBatchTest(){
        test.startTest();
            Database.executeBatch(new CCD_PublicPremisesDocumentsDataLoadBatch(),100);
        test.stopTest();
    }

}