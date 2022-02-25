/**
 * @description       : 
 * @author            : Wasef Mohiuddin
 * @group             : 
 * @last modified on  : 07-14-2021
 * @last modified by  : Wasef Mohiuddin
 * Modifications Log 
 * Ver   Date         Author            Modification
 * 1.0   07-14-2021   Wasef Mohiuddin   Initial Version
**/
global without sharing class LightningLoginFormController implements vlocity_ins.VlocityOpenInterface{

    public LightningLoginFormController() {
        
    }

    @AuraEnabled
    public static String login(String username, String password, String startUrl) {
        try{
            ApexPages.PageReference lgn = Site.login(username, password, startUrl);
            aura.redirect(lgn);
            return null;
        }
        catch (Exception ex) {return ex.getMessage();            
        }
    }
    
    @AuraEnabled
    public static Boolean getIsUsernamePasswordEnabled() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getUsernamePasswordEnabled();
    }

    @AuraEnabled
    public static Boolean getIsSelfRegistrationEnabled() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getSelfRegistrationEnabled();
    }

    @AuraEnabled
    public static String getSelfRegistrationUrl() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        if (authConfig.getSelfRegistrationEnabled()) {
            return authConfig.getSelfRegistrationUrl();
        }
        return null;
    }

    @AuraEnabled
    public static String getForgotPasswordUrl() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getForgotPasswordUrl();
    }
    
    @TestVisible
    private static Auth.AuthConfiguration getAuthConfig(){
        Id networkId = Network.getNetworkId();
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(networkId,'');
        return authConfig;
    }

    @AuraEnabled
    global static String setExperienceId(String expId) {
        // Return null if there is no error, else it will return the error message 
        try {
            if (expId != null) {
                Site.setExperienceId(expId);
            }
            return null; 
        } catch (Exception ex) {
            return ex.getMessage();            
        }
    }
    
    
  
    private static final String LOGIN_USER_METHOD = 'logInUser';
    private static final String FORGOT_PASSWORD_METHOD = 'forgotPassword';

    //Variables
    private static String methodName;
    private static String userName;
    private static String userNameFP;
    private static String password;
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){
        Boolean result = false;
        String returnUrl;
        try{
           // setVariables(methodName, inputMap);
            system.debug('inputMap ' + inputMap);
            if(methodName == 'logInUser'){
                logInUser(inputMap, outMap);               
            }else if(methodName == 'forgotPassword'){
                forgotPassword(inputMap, outMap);
            }else if(methodName == 'RegisterUser'){
              registerUser(inputMap, outMap);               
            }   
            result = true;
        }catch(Exception e) {
            system.debug('The error is ' + e.getMessage());
        }
        
        return result;
    }

  /*  @TestVisible
    private static void setVariables(String methodNameParam, Map<String,Object> options){
        system.debug('options :: '+options);
        methodName = methodNameParam;
     
        if(methodName == 'forgotPassword'){
            Map<String,Object>  step1Info = (Map<String,Object> )options.get('Step1');
            Map<String,Object> FPOptions = (Map<String,Object> )step1Info.get('forgotPasswordInfo');//(Map<String,Object> )options.get('forgotPasswordBlock');
           // userNameFP = String.valueOf(FPOptions.get('Username'));//String.valueOf(FPOptions.get('userNameFP'));
            userNameFP = String.valueOf(options.get('username'));
            system.debug('userNameFP :: '+userNameFP);
        }
    }*/

    
    private static void logInUser(Map<String,Object> options, Map<String,Object> outMap){
        string communityUrl = '';
        String redirectUrl='';
        Map<String,Object>  loginOptions = (Map<String,Object> )options.get('loginInformation');
        userName = String.valueOf(loginOptions.get('user_name'));
        password = String.valueOf(loginOptions.get('password'));    
        
        if(password != null && (password).length() > 1) {
            communityUrl =  '/bcd/s/';
        }
        
        try{
            ApexPages.PageReference lgn = Site.login(userName,password,communityUrl);
            if(!Test.isRunningTest()) {
                redirectUrl = lgn.getUrl();
                outMap.put('success',true);
                outMap.put('url',redirectUrl);
            }
        } catch (Exception ex) {
            outMap.put('success',false);
        } 
        
    }
    
    private static void forgotPassword(Map<String, Object> options, Map<String, Object> outMap) {
        String url = './CheckPasswordResetEmail';
        String checkEmailRefUrl='';
        system.debug('input Map ' + options);
        userNameFP = String.valueOf(options.get('username'));
            system.debug('userNameFP :: '+userNameFP);
        Map<String,Object> FPOptions = (Map<String,Object> )options.get('forgotPasswordInfo');
        try {
            
            List<User> users = [SELECT Id FROM User WhERE UserName =: userNameFP];
            if(!users.isEmpty()){
                //outMap.put('url',returnUrl);
                 //Site.forgotPassword(userNameFP);
                 System.resetPassword(users[0].Id, true);
                outMap.put('success','Yes');
            }else{
                outMap.put('success','No');
                outMap.put('msg', 'Username not found in the system');
            }
       
            system.debug('outMap :: '+ outMap);
        }
        catch (Exception ex) {
            outMap.put('success','No');
           outMap.put('msg', ex.getMessage());
        } 
    }
    
    private void  registerUser(Map<String,Object> inputMap, Map<String,Object> outMap){
        try{
            
            Map<String , Object > parentNode = ( Map<String , Object >) inputMap.get('userData');
            String password = String.valueOf(inputMap.get('Password'));
            system.debug('password ' + password);
            String json_user = JSON.serialize(parentNode.get('User'));            
            String json_account = JSON.serializePretty(parentNode.get('Account'));             
            Account account = (Account)JSON.deserialize(json_account, Account.class);
            String email = account.PersonEmail;
            List<User> users = [SELECt Id FROM User WHERE Email =: email];
            if(users.isEmpty()){
                Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId(); 
                account.RecordTypeId = recordTypeId;
                insert account;
                Profile p = [SELECT Id FROM Profile WHERE Name =: Label.Community_Profile_Name LIMIT 1];
                User user = (User)JSON.deserialize(json_user, User.class);
                user.profileId = p.Id ;              
               
                // DEBUGS
                system.debug('inputMap ' + inputMap);
                System.debug('Searlized User '+ json_user);
                System.debug('Searlized Account ' + json_account);
                System.debug('deserialized Account : '+account);
                System.debug('deserialized User : '+ user);
                                       
                Id sid = Site.createPortalUser(user, account.Id, password, false);
                System.debug('Id '+ sid); 
                
                List<Id> ids = new List<Id>();
                //PublicSectorAccessPSL-> Old permission set 
                for(PermissionSet ps : [SELECT Id FROM PermissionSet WHERE Name IN ('Licensing_and_Permitting_Management_For_Communities', 'Boards_Commission_User','IndustriesVisit')]){
                   ids.add(ps.Id);
                }
                assignPS(sid, ids);
                
                String communityUrl = '/bcd/s/';
                String redirectUrl;
                ApexPages.PageReference lgn = Site.login(user.Username,password,communityUrl);
                if(!Test.isRunningTest()) {
                    redirectUrl = lgn.getUrl();
                    outmap.put('success', true);
                    outmap.put('url', redirectUrl);
                }
             
            }else{
                outmap.put('success', false);
                outmap.put('msg', 'User with same email already exists. Click login to login with your existing credentials');
               
            }             
        }catch(Exception e){
            outmap.put('success', false);
            outmap.put('msg', e.getMessage());
        }
       
    } 
    
    @future 
    public static void assignPS(String userId, List<Id> PSIds){
        try{
        List<PermissionSetAssignment> PS_AssignmentList = new List<PermissionSetAssignment>();
                for(Id i : PSIds){
                    PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = i, AssigneeId = userId);
                    PS_AssignmentList.add(psa);
                }
                
                if(!PS_AssignmentList.isEmpty())
                    upsert PS_AssignmentList;
        }catch(Exception e){
        }
    }
}