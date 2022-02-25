@isTest
public class NM_LicenseScheduleBatchFlowTest {
    @isTest
    static void testExecute(){
        Test.startTest();
        RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
        Account acc = new Account(LastName='test', recordTypeId = personAccountRecordType.Id);
        insert acc;
        Contact con = BCD_TestUtility.createContact(true);
        RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Board of Barbers and Cosmetologists', false);
        regAut.ExternalId__c = 'Barbers & Cosmetologists';
        insert regAut;
            
        RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('Barbers & Cosmetologists', regAut.Id, true);
        BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
        bl.PeriodStart = System.Date.today().addYears(-6);
        bl.PeriodEnd = DateTime.Now().addYears(-5).addDays(1);
        bl.AccountId = acc.Id;
        bl.Authority__c  = 'Barbers & Cosmetologists';
        bl.Status = 'Active';
        bl.RegulatoryAuthorizationTypeId = rat.Id;
       	bl.Reminder_Flow__c = '14 Days Before Expiry';
        insert bl;
        NM_LicenseScheduleBatchFlow testBatch = new NM_LicenseScheduleBatchFlow();
        Id jobId = Database.executeBatch(testBatch,1);
        //NM_LicenseScheduleBatchFlow.scheduleJob('0 18 * * *');
		System.assert(jobId != null);
        NM_LicenseScheduleBatchFlow.scheduleJob('');
        testBatch.execute(null, null);
        System.assert([Select Id FROM Debug_Log__c LIMIT 1].size() > 0);
        Test.stopTest();
    }
}