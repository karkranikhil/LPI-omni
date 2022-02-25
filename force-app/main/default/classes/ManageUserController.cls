public with sharing class ManageUserController {
    @AuraEnabled
    public static User fetchUserDetail(){
        try {
            return [Select id,Name,SmallPhotoUrl, FullPhotoUrl
            From User
            Where Id =: Userinfo.getUserId()];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}