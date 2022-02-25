public with sharing class TLC_DashboardController {
    @AuraEnabled
    public static List<PreliminaryApplicationRef> fetchApplications(){
        try {
            return [Select id,Name,Status__c,Account_Email__c,FEIN_SSN__c from PreliminaryApplicationRef order by CreatedDate DESC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}