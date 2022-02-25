public without sharing class TLC_PaymentController {

    @AuraEnabled
    public static Id createTransactionLog(){
        try {
            Transaction_Log__c tx = new Transaction_Log__c();
            tx.Account_Code__c = 'N/A';
            tx.Amount__c = 50;
            //tx.Application_Reference__c = '0go5f000000kBK3AAM';
            //tx.Business_License__c = '0cE5f000000PqdpEAC';
            //tx.Summon__c = 'a7e5f000000i9MyAAI';
            tx.Settlement__c = 'a7g5f000000LLqlAAG';
            tx.Payment_Type__c = 'Application Fee';
            tx.Request_Details__c = '{"RevenueCode":"Trade & Professions Licenses","FundCode":"43900","FeeType":"'+tx.Payment_Type__c+'","DepartmentCode":"7300000000","Amount":'+tx.Amount__c+',"AccountCode":"416402"}';
            tx.User__c = UserInfo.getUserId();
            tx.Type__c = 'Request';

            insert tx;

            return tx.Id;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}