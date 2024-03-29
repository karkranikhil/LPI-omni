@isTest 
public class PermAssignPostDeployBatchTest 
{
    @testSetup 
    static void dataSetUp() 
    {
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'batman',
            Email='bruce.wayne@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        Database.insert(portalAccountOwner1);
        System.runAs ( portalAccountOwner1 ) {
            //Create account
            Account portalAccount1 = new Account(
                Name = 'TestAccount',
                OwnerId = portalAccountOwner1.Id
            );
            Database.insert(portalAccount1);
            
            //Create contact
            Contact contact1 = new Contact(
                FirstName = 'Test',
                Lastname = 'McTesty',
                AccountId = portalAccount1.Id,
                Email = System.now().millisecond() + 'test@test.com'
            );
            Database.insert(contact1);
            
            //Create user
            Profile portalProfile = [SELECT Id,Name FROM Profile WHERE Name = 'Customer Community User Profile'];
            User user1 = new User(
                Username = System.now().millisecond() + 'test12345@test.com',
                ContactId = contact1.Id,
                ProfileId = portalProfile.Id,
                Alias = 'test123',
                Email = 'test12345@test.com',
                EmailEncodingKey = 'UTF-8',
                LastName = 'McTesty',
                CommunityNickname = 'test12345',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US'
            );
            Database.insert(user1);
        }
    }
    static testMethod void permTestMethod() 
    {
        // String query = 'Select id from User  Where ProfileId = \'00et0000000gokmAAA\' and isActive = true ';
        String query = 'Select id from User  Where isActive = true Limit 10';
        List<PermissionSet> lstPermissionSet= [SELECT Id, Name, Label, LicenseId, ProfileId FROM PermissionSet];
        List<Id > PermissionSetIdList= new List<Id>();
        PermissionSetIdList.add(lstPermissionSet[0].Id);
        Test.startTest();
        
        PermAssignPostDeployBatch obj = new PermAssignPostDeployBatch(query,PermissionSetIdList);
        DataBase.executeBatch(obj,100); 
        
        Test.stopTest();
    }
}