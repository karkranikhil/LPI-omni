public with sharing class lpiManageAccountController {
    //To get Acccount details
    @AuraEnabled
    public static string getManageAccountDetails(){
        try {
            Id contactId = [SELECT ID,ContactId FROM User WHERE Id = :UserInfo.getUserId()]?.ContactId;
            Id accountId = [SELECT ID,AccountId,Email FROM Contact WHERE Id = :contactId]?.AccountId;
            
            Account acc = [SELECT Id,FirstName,LastName,Cell_Phone__c,PersonEmail,PersonBirthdate,PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode FROM Account WHERE Id = :accountId];
            ManageAccountEmployerWrapper manageWrapper = new ManageAccountEmployerWrapper();
            manageWrapper.Id = acc.Id;
            manageWrapper.FirstName = acc.FirstName;
            manageWrapper.LastName = acc.LastName;
            manageWrapper.Cell_Phone = acc.Cell_Phone__c;
            manageWrapper.PersonEmail = acc.PersonEmail;
            manageWrapper.PersonBirthdate = acc.PersonBirthdate;

            manageWrapper.PersonMailingStreet = acc.PersonMailingStreet;
            manageWrapper.PersonMailingCity = acc.PersonMailingCity;
            manageWrapper.PersonMailingState = acc.PersonMailingState;
            manageWrapper.PersonMailingPostalCode = acc.PersonMailingPostalCode;

            return JSON.serialize(manageWrapper);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string updateManageAccount(String manageAccData){
        try {
            ManageAccountEmployerWrapper wrapperList = (ManageAccountEmployerWrapper)JSON.deserialize(manageAccData, ManageAccountEmployerWrapper.class);
           
            Id contactId = [SELECT ID,ContactId FROM User WHERE Id = :UserInfo.getUserId()]?.ContactId;
            Account acc = new Account();
            acc.Id = wrapperList.Id;
            acc.FirstName = wrapperList.FirstName;
            acc.LastName = wrapperList.LastName;
            acc.Cell_Phone__c = wrapperList.Cell_Phone;
            acc.PersonEmail = wrapperList.PersonEmail;
            acc.PersonMailingStreet = wrapperList.PersonMailingStreet;
            acc.PersonMailingCity = wrapperList.PersonMailingCity;
            acc.PersonMailingState = wrapperList.PersonMailingState;
            acc.PersonMailingPostalCode = wrapperList.PersonMailingPostalCode;
            acc.PersonBirthdate = wrapperList.PersonBirthdate;

            update acc;

            User user = new User();
            user.Id = UserInfo.getUserId();
            user.FirstName = wrapperList.FirstName;
            user.LastName = wrapperList.LastName;
            update user;
            return 'success';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    public class ManageAccountEmployerWrapper {
        @AuraEnabled Public String Id;
        @AuraEnabled Public String FirstName;
        @AuraEnabled Public String LastName;
        @AuraEnabled Public String Cell_Phone;
        @AuraEnabled Public String PersonEmail;
        @AuraEnabled Public String PersonMailingStreet;
        @AuraEnabled Public String PersonMailingCity;
        @AuraEnabled Public String PersonMailingState;
        @AuraEnabled Public String PersonMailingPostalCode;
        @AuraEnabled Public Date PersonBirthdate;
    }
}