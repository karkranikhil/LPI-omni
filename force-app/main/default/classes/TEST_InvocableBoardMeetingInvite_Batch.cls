@isTest
private with sharing class TEST_InvocableBoardMeetingInvite_Batch {
    @testSetup
    private static void createBoardMeetingData() {
        try{
            RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Board of Barbers and Cosmetologists', true);
            RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('Student', regAut.Id, true);
            Contact con = BCD_TestUtility.createContact(true);
            BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
            bl.RegulatoryAuthorizationTypeId = rat.Id;
            bl.Status = 'Active';
            insert bl;
            Board_Meeting__c bm = BCD_TestUtility.createBoardMeeting(true, regAut.Id);
            
        } catch(Exception e) {
            system.debug('Exception in createBoardMeetingData method : '+e.getStackTraceString()+'\n'+e.getLineNumber());
        }
    }
    
    private static testMethod void runInvocableBatch() {
        try{
            //get the board meeting id
            String boardMeetingId = [SELECT Id FROM Board_Meeting__c LIMIT 1].get(0).Id;
            InvocableBoardMeetingInvite_Batch.Request requestVar = new InvocableBoardMeetingInvite_Batch.Request();
            requestVar.recordId = boardMeetingId;
            Test.startTest();
            	InvocableBoardMeetingInvite_Batch.sendMeetingInvite(new List<InvocableBoardMeetingInvite_Batch.Request>{requestVar});
            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber());
        }
    }
}