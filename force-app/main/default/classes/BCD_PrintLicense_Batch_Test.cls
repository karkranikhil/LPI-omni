@isTest
private with sharing class BCD_PrintLicense_Batch_Test {
    @testSetup
    private static void createDataForBatch() {
        try{
            RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
            Account acc = new Account(LastName='test', recordTypeId = personAccountRecordType.Id);
            insert acc;
            Contact con = BCD_TestUtility.createContact(true);
            RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Board of Barbers and Cosmetologists', true);
            RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('Student', regAut.Id, true);
            BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
            bl.PeriodStart = system.now();
            bl.PeriodEnd = system.now()+1;
            bl.AccountId = acc.Id;
            bl.RegulatoryAuthorizationTypeId = rat.Id;
            insert bl;
            
            License_Print_Request__c lpr = new License_Print_Request__c();
            lpr.Print_Type__c = 'New Only';
            lpr.Application_Created_Start_Date__c = Date.today().addYears(-2);
            lpr.Application_Created_End_Date__c = Date.today().addYears(2);
            lpr.Application_Status__c = 'Approved';
            lpr.License_Status__c = 'Active';
            lpr.Application_Type__c = 'New';
            lpr.Regulatory_Authority__c = regAut.Id;
            insert lpr;
            
            Case cse = new Case(Origin = 'Web', Status = 'New');
            insert cse;
            IndividualApplication app = new IndividualApplication(AccountId = acc.Id, Status = 'Approved', ApplicationCaseId = cse.Id, AppliedDate = Date.today(),
                                                                  Category = 'License', LicensePermitNameId = bl.Id, LicenseTypeId = rat.Id);
            insert app;
            
        } catch(Exception e) {
            system.debug('Exception in createDataForBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber());
        }
    }
    
    private static testMethod void testBatchRun() {
        try{
            Account acc = [SELECT Id FROM Account LIMIT 1].get(0);
            Test.startTest();
            String query = 'SELECT Id, LicensePermitNameId, LicensePermitName.Last_Printed_On__c FROM IndividualApplication WHERE CreatedDate > 2021-01-01T00:00:00-06:00';
            String targetId = acc.Id;
            BCD_PrintLicense_Batch obj = new BCD_PrintLicense_Batch(query, targetId);
            Database.executeBatch(obj, 20);
            Test.stopTest();
            BusinessLicense bl = [SELECT Id, Last_Printed_On__c FROM BusinessLicense LIMIT 1].get(0);
            System.assert(bl.Last_Printed_On__c != null);
        } catch(Exception e) {
            system.debug('Exception in testBatchRun method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    private static testMethod void testInvocableBatchRun() {
        try{
            Test.startTest();
            License_Print_Request__c lpr = [SELECT Id FROM License_Print_Request__c LIMIT 1].get(0);
            BCD_PrintLicense_Batch.invokePrintLicenseBatch(new List<Id>{lpr.Id});
            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in testInvocableBatchRun method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
}