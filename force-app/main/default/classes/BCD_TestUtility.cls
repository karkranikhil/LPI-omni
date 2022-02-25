/**
 * @description       : 
 * @author            : Wasef Mohiuddin
 * @group             : 
 * @last modified on  : 08-12-2021
 * @last modified by  : Wasef Mohiuddin
**/
public with sharing class BCD_TestUtility {
    
    public Static Account createAccount(String accName,Boolean isInsert){
        Account account = new Account(name = accName);
        If(isInsert){
            INSERT account;
        }
        return account;
    }
    public Static Contact createContact(Boolean isInsert){
        Account acc = createAccount('Acc1',True);
        Contact contact = new Contact(
            AccountId = acc.id, 
            FirstName = 'con1', 
            LastName = 'acc', 
            Email = 'con@gmail.com', 
            MailingStreet = '123', 
            MailingCity = 'xyz', 
            MailingState = 'Alaska',
            MailingCountry = 'US',
            MailingPostalCode = '302020');
        if(isInsert){
            INSERT contact;
        }
        return Contact;   
    }
    public Static User createCommunityUser(String ProfileName){
        Id PROFILE_ID = [select Id,name from Profile WHERE Name =:ProfileName limit 1].Id;
        User adminUser = [Select Id, UserRoleId From User
                          WHERE Id =: UserInfo.getUserId()
                          AND IsActive = true Limit 1];
        
        User user = new User();
        
        System.runAs(adminUser){
            Account account = new Account(Name='Test Account Name');
            insert account;
            Contact con = createContact(true);
            user.ProfileID = PROFILE_ID;
            user.EmailEncodingKey = 'ISO-8859-1';
            user.LanguageLocaleKey = 'en_US';
            user.TimeZoneSidKey = 'America/New_York';
            user.LocaleSidKey = 'en_US';
            user.FirstName = 'first';
            user.LastName = 'last';
            user.Username = 'test@devsos.com';
            user.CommunityNickname = 'testUser123';
            user.Alias = 't1';
            user.Email = 'no@email.com';
            user.IsActive = true;
            user.ContactId = con.Id;
            insert user;
        }
        return user;
    }
    public Static PreliminaryApplicationRef createPreliminaryApplicationRef(String accId,Boolean isInsert){
        PreliminaryApplicationRef appRef = new PreliminaryApplicationRef();
        appRef.BusinessAccountNameId = accId;
        appRef.ApplicationName = 'appName';
        appRef.ApplicationType = 'IndividualApplication';
        appRef.SavedApplicationUrl='https://xyz.com';
        IF(isInsert){
            INSERT appRef; 
        }
        return appRef;
    }
    public Static BusinessLicense createBusinessLicense(String contactId,Boolean isInsert){
        BusinessLicense businessLicense = new BusinessLicense();
        businessLicense.ContactId=contactId;
        businessLicense.Status = 'Issued';
        IF(isInsert){
            INSERT businessLicense;
        }
        return businessLicense;
    }
    public Static Transaction_Log__c createTransactionLog(String userId,String businessLicenseId,String appRefId,Boolean isInsert){
        Transaction_Log__c trans = new Transaction_Log__c(
            Amount__c = 200, 
            User__c = userId, 
            Business_License__c = businessLicenseId,
            Application_Reference__c  = appRefId,
            Payment_Type__c = 'Application Fee',
            Transaction_Id__c  = 'axced12345');
            
        trans.Request_Details__c = '{"FeeType":"Application Fees","Amount":75,"AccountCode":"44400 7000000000 416402"}';
        IF(isInsert){
            INSERT trans;
        }
        return trans;
    }
    public Static RegulatoryTrxnFee createRegulatoryTrxnFee(String transId,String Status,String FeeType,Boolean isInsert){
        RegulatoryTrxnFee RegTxn = new RegulatoryTrxnFee(
            Status = Status,
            fee_type__c = FeeType, 
            ParentRecordId = transId);
        IF(isInsert){
            INSERT RegTxn;
        }
        return RegTxn;
        
    }
    public Static RegulatoryAuthority createRegulatoryAuthority(String name, Boolean isInsert){
        RegulatoryAuthority regAut = new RegulatoryAuthority(
        	Name = name,
            Survey_Required__c = false,
            Description = 'Lorem Ipsum'
        );
        IF(isInsert){
            INSERT regAut;
        }
        return regAut;
    }
    public Static RegulatoryAuthorizationType createRegulatoryAuthorizationType(String name, String authorityId, Boolean isInsert){
        RegulatoryAuthorizationType regAutType = new RegulatoryAuthorizationType(
        	Name = name,
            External_Id__c = name,
            Issuance_Fee_Required__c = false,
            ProRatedIssuance__c = false,
            Request_Inspection__c = false,
            Description = 'Lorem Ipsum',
            IssuingDepartmentId = authorityId
        );
        IF(isInsert){
            INSERT regAutType;
        }
        return regAutType;
    }
    public Static Board_Meeting__c createBoardMeeting(Boolean isInsert, String authorityId) {
        Board_Meeting__c boardMeet = new Board_Meeting__c(
        	Name = 'test',
            Send_Email_To_All_Licenses__c = true,
            Status__c = 'Draft',
            Meeting_Type__c = 'Emergency Meeting',
            Date_of_Meeting__c = Date.today().addMonths(1),
            Regulatory_Authority__c = authorityId
        );
        IF(isInsert){
            INSERT boardMeet;
        }
        return boardMeet;
    }
    public Static User createUser(Boolean isInsert) {
        Id profileId = [select Id,name from Profile WHERE Name = 'System Administrator' limit 1].Id;
        User userRecord = new User(  firstname = 'test',
            lastName = 'user',
            email = 'testUser@test.org',
            Username = 'username@test.org',
            EmailEncodingKey = 'ISO-8859-1',
            Alias = 'tUser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            ProfileId = profileId
        );
        IF(isInsert){
            INSERT userRecord;
        }
        return userRecord;
    }
    public Static Supervisor__c createSupervisor(String premRefId, Boolean isInsert) {
        Supervisor__c supervisor = new Supervisor__c(Application_Reference__c = premRefId, Status__c = 'Draft');
        if(isInsert) {
            insert supervisor;
        }
        return supervisor;
    }
    
}