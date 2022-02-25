@IsTest(SeeAllData = false)
public with sharing class LightningLoginFormControllerTest {

@isTest
 static void loginTest() {
    System.assertEquals(null, LightningLoginFormController.login('testUser','testPass12345','/bcd/s'));
 }

 @IsTest
 static void LightningLoginFormControllerInstantiation() {
  LightningLoginFormController controller = new LightningLoginFormController();
  System.assertNotEquals(controller, null);
 }

 @IsTest
 static void testIsUsernamePasswordEnabled() {
  System.assertEquals(true, LightningLoginFormController.getIsUsernamePasswordEnabled());
 }

 @IsTest
 static void testIsSelfRegistrationEnabled() {
  System.assertEquals(false, LightningLoginFormController.getIsSelfRegistrationEnabled());
 }

  @IsTest
 static void testGetForgotPasswordUrl() {
  System.assertEquals(null, LightningLoginFormController.getForgotPasswordUrl());
 }
    
 @IsTest
 static void testGetSelfRegistrationURL() {
  System.assertEquals(null, LightningLoginFormController.getSelfRegistrationUrl());
 }

 @IsTest
 static void testAuthConfig() {
  Auth.AuthConfiguration authConfig = LightningLoginFormController.getAuthConfig();
  System.assertNotEquals(null, authConfig);
 }
    
    @isTest
    static  void setExperienceIdTest_1(){        
        test.startTest();
        try{
            LightningLoginFormController.setExperienceId('');
        } catch(Exception e){
            System.assertEquals(e.getMessage(),'This method can be invoked only from within a community.');
        }
        test.stopTest();        
    }
    
    @isTest
    static  void setExperienceIdTest_2(){
        
        Test.startTest();
        System.assertEquals(null,LightningLoginFormController.setExperienceId(null));
        Test.stopTest();
    }

    /*@isTest
    static  void setVariablesTest(){
        String jsonString = '{"Step1":{"forgotPasswordInfo":{"forgotPasswordTest":"Test"}},"username":"testuser@mtxb2b.com"}';
        Map<String, Object> inputMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        test.startTest();
        LightningLoginFormController.setVariables('forgotPassword',inputMap);
        test.stopTest();
    }*/

    @isTest
    static  void invokeMethodTest_logInUser(){
        String jsonString = '{"loginInformation": {"password": "test@pass1234","user_name": "test.email+2222@mtxb2b.com"}}';
        Map<String, Object> inputMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        Test.startTest();
        LightningLoginFormController controller = new LightningLoginFormController();
        controller.invokeMethod('logInUser',inputMap,outputMap,options);
        Test.stopTest();
    }

    @isTest
    static  void invokeMethodTest_registerUser(){
        try{
        String jsonString = '{"userData":{"User":{"Username":"testusername@mtxb2b.com"},"Account":{"PersonMailingStreet":"test","PersonEmail":"testuser@mtxb2b.com","LastName":"TestUser"}},"Password":"test@pass1234"}';
        Map<String, Object> inputMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
            LightningLoginFormController controller1 = new LightningLoginFormController();
        	controller1.invokeMethod('registerUser',inputMap,outputMap,options);
        }
        catch(Exception e){
            System.debug('e:'+e);
        }
        
    }

    @isTest
    static  void invokeMethodTest_forgotPassword(){
        String jsonString = '{"Username": "testusername@mtxb2b.com"}';
        Map<String, Object> inputMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        Test.startTest();
        LightningLoginFormController controller = new LightningLoginFormController();
        controller.invokeMethod('forgotPassword',inputMap,outputMap,options);
        Test.stopTest();
    }
       
}