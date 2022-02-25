public without sharing class UserRegistrationController {
    @AuraEnabled
    public static string createPortalUser(String input){
        try {     
            UserDetails wrapper = (UserDetails) JSON.deserialize(input, UserDetails.Class); 
            List<User> uList = [SELECT ID,Email FROM User WHERE Email =: wrapper.userEmail];
            if(!uList.isEmpty()){
                return 'The Email Address you are trying to register with already has an account';
            }
            // Id standardRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
            Id personAccountRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
            // Id standardRecordTypeId = '0125f000000uMBJAA2';
            
            List<Account> newAccountList = new List<Account>();
            if(wrapper.companyName != '') {
                 newAccountList = [Select Id From Account where Name=:wrapper.companyName limit 1];
            }
            Account newAccount;
            if(newAccountList==null || newAccountList.isEmpty()) {
                newAccount = new Account(
                    FirstName = wrapper.userFirstName,
                    LastName = wrapper.userLastName,
                    // Name = wrapper.userFirstName + wrapper.userLastName , 
                    OwnerId = '0055f000005s2Gu',
                    RecordTypeId = personAccountRecordTypeId);
              insert newAccount;
            } else {
                newAccount = newAccountList[0];
            }
            Account a = [Select PersonContactId From Account Where Id = :newAccount.Id];
            // Contact newContact = new Contact(
            //     AccountId = newAccount.Id, 
            
            //     LastName = wrapper.userLastName,
            //     FirstName = wrapper.userFirstName,
            //     Email = wrapper.userEmail
            //  );
            // insert newContact;

            Profile prof;
            prof = [select id,userType from Profile where name='LPI Customer Community User Profile' limit 1];
           
            
            String alias = (wrapper.userFirstName != null ? wrapper.userFirstName.substring(0,1).toUpperCase() :'') + 
                (wrapper.userLastName.length() > 6 ? wrapper.userLastName.substring(0,6) : wrapper.userLastName);
            String nickname = ((wrapper.userFirstName != null && wrapper.userFirstName.length() > 0) ? wrapper.userFirstName.substring(0,1) : '' ) + wrapper.userLastName.substring(0,1);
            nickname = nickname + String.valueOf(Crypto.getRandomInteger()).substring(1,7);

            User userObj = new User(
                Username   = wrapper.userEmail+'.lpi',
                Email      = wrapper.userEmail,
                FirstName  = wrapper.userFirstName,
                LastName   = wrapper.userLastName,
                ProfileId = prof.id,
                contactId = a.PersonContactId,
                emailEncodingKey  = 'UTF-8',
                languageLocaleKey ='en_US',
                localesIdKey = 'en_CA',
                alias = alias,
                CommunityNickname= nickname,
                TimeZoneSidKey='America/New_York'
                );
            String networkId = Network.getNetworkId();
            /**If using site to host the community the user should not hit s1 after logging in from mobile. */
            if(networkId != null && siteAsContainerEnabled(networkId)) userObj.put('UserPreferencesHideS1BrowserUI',true);
            INSERT userObj;
            setPermissions(userObj.Id);
            
            return '';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @future
    public static void setPermissions(Id userId){
        // giving permission set 
        //Licensing and Permitting Management For Communities
        List<PermissionSetAssignment> permissionSetList = new List<PermissionSetAssignment>();
        PermissionSetAssignment  psa1 = new PermissionSetAssignment 
        (PermissionSetId = '0PS5f0000049WvN', AssigneeId = userId);
        permissionSetList.add(psa1);

        // Boards & Commission User
        PermissionSetAssignment  psa2 = new PermissionSetAssignment 
        (PermissionSetId = '0PS5f0000049WvC', AssigneeId = userId);
        permissionSetList.add(psa2);

        insert permissionSetList;
    }
    @TestVisible
    private static boolean siteAsContainerEnabled(Id networkId) {
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(networkId,'');
        return authConfig.isCommunityUsingSiteAsContainer();
    }
    public class UserDetails {
        @AuraEnabled
        public String userFirstName;
        @AuraEnabled
        public String userLastName;
        @AuraEnabled
        public String userEmail;
        @AuraEnabled
        public String userPhone;
        @AuraEnabled
        public Date userBirthdate;
        @AuraEnabled
        public UserAddress address;
        @AuraEnabled
        public String alternateContact;
        @AuraEnabled
        public boolean smsCommunication;
        @AuraEnabled
        public boolean emailCommunication;
        @AuraEnabled
        public String organizationName;
        @AuraEnabled
        public String corporateNumber;
        @AuraEnabled
        public String role;
        @AuraEnabled
        public String gender;
        @AuraEnabled
        public String pronoun;
        @AuraEnabled
        public String companyName;
        @AuraEnabled
        public String designation;
    }

    public class UserAddress{
        @AuraEnabled
        public String street;
        @AuraEnabled
        public String city;
        @AuraEnabled
        public String state;
        @AuraEnabled
        public String country;
        @AuraEnabled
        public String postalCode;
    }
}