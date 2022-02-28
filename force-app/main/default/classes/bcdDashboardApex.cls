public class bcdDashboardApex {
    @AuraEnabled
    public static list<WrapperClass> getDetails(){
        try {
            System.debug('Current User Id - '+UserInfo.getUserId());
            List<User> us = new List<User>([SELECT Id,ContactId,Contact.AccountId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1]);
            if(us.size()>0){
                String accountID = us[0].Contact.AccountId;
                List<WrapperClass> wc = new List<WrapperClass>();
                for(BusinessLicense ac :  [SELECT Id,Account.Name,Account.PersonEmail,License_Type__c,Account.TLC_License_number__c,
                                           PeriodEnd,Status,RegulatoryAuthorizationType.Name,Name
                                           FROM BusinessLicense 
                                           WHERE AccountId = :accountID 
                                           AND RegulatoryAuthorizationType.Name IN ('Vehicle License','Driver License','Vehicle Licensing','Driver Licensing')
                                           AND Status ='Active']){
                    WrapperClass wrapper  = new WrapperClass();
                    wrapper.Id = ac.Id;
                    wrapper.Name = ac.Account.Name;
                    wrapper.Email = ac.Account.PersonEmail;
                    wrapper.Type = ac.RegulatoryAuthorizationType.Name;
                    wrapper.status = ac.Status;
                    wrapper.tlcNumber = ac.Name;

                    if(ac.PeriodEnd != null){                     
                        DateTime dT = ac.PeriodEnd;
                        Date licenseDate = date.newinstance(dT.year(), dT.month(), dT.day());
                        wrapper.licenseDate = licenseDate;
                        if(ac.PeriodEnd < = date.today().AddDays(10) && ac.PeriodEnd > date.today()){
                            wrapper.Renew = true;
                        }
                        else{
                            wrapper.Renew = false;
                        }
                    }else{
                        wrapper.Renew = false;
                    }
                    wc.add(wrapper);
                }
                return wc;
            }
            return null;  
        }catch(Exception e){
                return null;            
        }
    }

    @AuraEnabled
    public static list<WrapperClass> getApplicationList(){
        try {
            System.debug('Current User Id - '+UserInfo.getUserId());
            List<User> us = new List<User>([SELECT Id,AccountId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1]);
            if(us.size()>0){
                String AccountId = us[0].AccountId;
                System.debug('Contact Id - '+AccountId);

                List<WrapperClass> wc = new List<WrapperClass>();
                for(IndividualApplication ia :  [SELECT Id,Name,ApplicationType, CreatedDate, Status ,LicenseType.Name
                    FROM IndividualApplication
                    WHERE AccountId  = :AccountId 
                    AND LicenseType.Name IN ('Vehicle License','Driver License','Vehicle Licensing','Driver Licensing')]){
                        WrapperClass wrapper  = new WrapperClass();
                        wrapper.Id = ia.Name;
                        wrapper.Type = ia.LicenseType.Name;
                        wrapper.status = ia.Status;               
                        DateTime dT = ia.CreatedDate;
                        Date licenseDate = date.newinstance(dT.year(), dT.month(), dT.day());
                        wrapper.licenseDate = licenseDate;
                        wc.add(wrapper);
                    }
                    return wc;
                }
                return null;
            }catch(Exception e){
                return null;            
        }
    }

    @AuraEnabled
    public static list<WrapperClass> getAllDetails(){
        try {
            System.debug('Current User Id - '+UserInfo.getUserId());
            List<User> us = new List<User>([SELECT Id,ContactId,AccountId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1]);
            if(us.size()>0){
                String accountID = us[0].AccountId;
                List<WrapperClass> wc = new List<WrapperClass>();
                for(BusinessLicense ac :  [SELECT Id,Account.Name,Account.PersonEmail,License_Type__c,Account.TLC_License_number__c,
                                           PeriodEnd,Status,Regulatory_Authorization_Type__c,Name,RegulatoryAuthorizationType.Name
                                           FROM BusinessLicense 
                                           WHERE AccountId = :accountID AND RegulatoryAuthorizationType.Name IN ('Vehicle License','Driver License','Vehicle Licensing','Driver Licensing')]){

                    WrapperClass wrapper  = new WrapperClass();
                    wrapper.Id = ac.Id;
                    wrapper.Name = ac.Account.Name;
                    wrapper.Email = ac.Account.PersonEmail;
                    wrapper.Type = ac.RegulatoryAuthorizationType.Name;
                    wrapper.status = ac.Status;
                    wrapper.tlcNumber = ac.Name;
                    if(ac.PeriodEnd != null){                     
                        DateTime dT = ac.PeriodEnd;
                        Date licenseDate = date.newinstance(dT.year(), dT.month(), dT.day());
                        wrapper.licenseDate = licenseDate;
                        if(ac.PeriodEnd < = date.today().AddDays(10) && ac.PeriodEnd > date.today()){
                            wrapper.Renew = true;
                        }
                        else{
                            wrapper.Renew = false;
                        }
                    }else{
                        wrapper.Renew = false;
                    }
                    wc.add(wrapper);
                }
                return wc;
            }
            return null;  
        }catch(Exception e){
                return null;            
        }
    }

    public class WrapperClass{
        @AuraEnabled
        public String Id;
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public String Email;
        @AuraEnabled
        public String Type;
        @AuraEnabled
        public date licenseDate;
        @AuraEnabled
        public String tlcNumber;
        @AuraEnabled
        public String status;

        @AuraEnabled
        public Boolean Renew;
    }
}