public class bcdDashboardApex {
    @AuraEnabled
    public static list<WrapperClass> getDetails(){
        try {
            System.debug('Current User Id - '+UserInfo.getUserId());
            List<User> us = new List<User>([SELECT Id,ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1]);
            if(us.size()>0){
                String contactID = us[0].ContactId;
                List<WrapperClass> wc = new List<WrapperClass>();
                for(BusinessLicense ac :  [SELECT Id,Account.Name,Account.PersonEmail,License_Type__c,Account.TLC_License_number__c,PeriodEnd,Status,Regulatory_Authorization_Type__c,Name FROM BusinessLicense WHERE ContactId = :contactID AND Regulatory_Authorization_Type__c IN ('Vehicle Licensing','Driver Licensing')]){
                    WrapperClass wrapper  = new WrapperClass();
                    wrapper.Id = ac.Id;
                    wrapper.Name = ac.Account.Name;
                    wrapper.Email = ac.Account.PersonEmail;
                    wrapper.Type = ac.License_Type__c;
                    wrapper.status = ac.Status;
                    wrapper.tlcNumber = ac.Name;

                    if(ac.PeriodEnd != null){
                        
                        DateTime dT = ac.PeriodEnd;
                        Date licenseDate = date.newinstance(dT.year(), dT.month(), dT.day());
                        wrapper.licenseDate = licenseDate;

                        if(date.today().AddDays(-10) < = ac.PeriodEnd){
                            wrapper.Renew = true;
                        }else{
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
    public static list<IndividualApplication> getApplicationList(){
        try {
            System.debug('Current User Id - '+UserInfo.getUserId());
            List<User> us = new List<User>([SELECT Id,AccountId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1]);
            if(us.size()>0){
                String AccountId = us[0].AccountId;
                System.debug('Contact Id - '+AccountId);
                list<IndividualApplication> lA = [SELECT Id,Name,ApplicationType, CreatedDate, Status FROM IndividualApplication where AccountId  = :AccountId];
                
                if(lA.size()>0){
                    System.debug('IndividualApplication - '+lA[0]);
                    return lA;
                }else{
                    return null;
                }
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