@JsonAccess(serializable='always')
global without sharing class FetchUserDetailsForPublicVehicle implements vlocity_ins.VlocityOpenInterface2{
    global String invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        // Savepoint sp = null;
        // try{
        //     sp = Database.setSavepoint();
        //     id userId = UserInfo.getUserId();
        //     User u = [select id, contactId from User where id = : userId];
        //     id getContactId = u.contactId;
        //     Contact ConDetails = [select id, AccountId from contact where id = :getContactId ];
        //     id accountid = ConDetails.AccountId;
        //     system.debug('getContactId' + getContactId);
        //     system.debug('getAccounttId' + accountid);
        //     output.put('contactId',getContactId);
        //     output.put('accountId',accountid);
        //     output.put('res','test');
        //     return 'Anup';
        // }
        // catch (Exception exp) {
        //     Database.rollback(sp);
        //     return exp.getMessage(); 
        // }
        if(methodName == 'createNewRecord'){
            PreliminaryApplicationRef newObj = new PreliminaryApplicationRef();
            String ApplicationType = (String)input.get('ApplicationType');
            String LicenseType = (String)input.get('LicenseType');
            newObj.Application_Type__c = ApplicationType;
            newObj.License_Type__c = LicenseType;
            newObj.SavedApplicationUrl = 'NAanup';
            newObj.ApplicationType = 'IndividualApplication';
            newObj.ApplicationName = 'Vehicle License Application';
            // IndividualApplication
            // Vehicle License Application
            insert newObj;
            return (String)newObj.id;
        }
        return null;
    }
}