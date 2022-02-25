@isTest
public class NM_LicenseScheduleBatchFlowHelperTest {
    @TestSetup
    static void createData(){
        RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
        Account acc = new Account(LastName='test', recordTypeId = personAccountRecordType.Id);
        insert acc;
        Contact con = BCD_TestUtility.createContact(true);
        RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Board of Barbers and Cosmetologists', false);
        regAut.ExternalId__c = 'Barbers & Cosmetologists';
        insert regAut;
            
        RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('Booth Rental', regAut.Id, true);
        BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
        bl.PeriodStart = System.Date.today().addYears(-6);
        bl.PeriodEnd = DateTime.Now().addYears(-5).addDays(1);
        bl.AccountId = acc.Id;
        bl.Authority__c  = 'Barbers & Cosmetologists';
        bl.Status = 'Active';
        bl.RegulatoryAuthorizationTypeId = rat.Id;
        bl.Reminder_Flow__c = '14 Days Before Expiry';
        insert bl;
    }
    @isTest
    static void Test_initiateConfiguration(){
        //System.assert(false,[Select Id, External_Id__c FROM RegulatoryAuthorizationType Limit 1]);
        List<BusinessLicense> busLicList = [SELECT Id,Authority__c,Regulatory_Authorization_Type__c,Reminder_Flow__c,Status,PeriodEnd,PeriodStart,AccountId FROM BusinessLicense Limit 1];
       // System.assert(false,busLicList);
       // System.assert(false,[SELECT id,Board__c,Condition_Field__c,Condition_Operator__c,Condition_Value__c,
                    //                            Date_Field_To_Consider_API__c,License__c,Time_Unit__c,Time_Value__c,
                     //                           Update_Field__c,Update_Type__c,Update_Value__c, Time_Operator__c,Additional_Information__c
                       //                         FROM License_Batch_Flow__mdt
                         //                       WHERE Active__c = True AND Board__c =: 'Barbers & Cosmetologists' AND License__c =: 'Establishment' ]);
        NM_LicenseScheduleBatchFlowHelper NMLSCBFH = new NM_LicenseScheduleBatchFlowHelper(busLicList);
        Test.startTest();
        NMLSCBFH.initiateConfiguration();
        NMLSCBFH.processData();
        NMLSCBFH.commitData();
        System.assert([Select Id FROM Debug_Log__c LIMIT 1].size() > 0);
        delete busLicList;
        delete [Select Id FROM Debug_Log__c LIMIT 1];
        NMLSCBFH.commitData();
        System.assert([Select Id FROM Debug_Log__c LIMIT 1].size() > 0);
        Test.stopTest();
    }
}