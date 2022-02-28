public without sharing class TLC_PaymentController {

    @AuraEnabled
    public static List<Settlement__c> fetchSettlements(){
        Id contactId = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()].ContactId;
        try {
            return [SELECT Id,Summon__r.Name,Business_License__r.Name,Points__c,Fines__r.X1st_Violation__c,Fines__r.X2nd_Violation__c,Fines__r.X3rd_Violation__c,Status__c
                FROM Settlement__c 
                WHERE Summon__r.Business_License__r.ContactId = :contactId
                ORDER BY createdDate DESC LIMIT 20];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Summon__c> fetchSummons(){
        Id contactId = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()].ContactId;

        try {
            return [SELECT Id,Business_License__r.Name,Date_of_Offense__c,Date_Issued__c,TLC_Driver_Number__c,TLC_Vehicle_Number__c
                FROM Summon__c
                WHERE Business_License__r.ContactId = :contactId
                ORDER BY createdDate DESC LIMIT 20];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Id createTransactionLog(Id parentId,String objName){
        try {
            Transaction_Log__c tx = new Transaction_Log__c();
            tx.Account_Code__c = 'N/A';
            tx.Amount__c = 50;
            //tx.Application_Reference__c = '0go5f000000kBK3AAM';
            //tx.Business_License__c = '0cE5f000000PqdpEAC';
            //tx.Summon__c = 'a7e5f000000i9MyAAI';
            if(objName == 'summon'){
                tx.Summon__c = parentId;
                tx.Payment_Type__c = 'Summon Fee';

            }
            if(objName == 'settlement'){
                tx.Settlement__c = parentId;
                tx.Payment_Type__c = 'Settlement Fee';
            }
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