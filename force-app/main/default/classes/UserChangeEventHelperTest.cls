/**
* @description       : Test Class for UserChangeEventHelper of UserChangeEvent trigger.
* @author            : Shashank Kumar
* @Created on  : 2 November 2021
**/
@isTest
public with sharing class UserChangeEventHelperTest {
    
    @testSetup static void setup()
    {
        Test.enableChangeDataCapture();
        //Create a Community User Record.
        String Profile='Customer Community User Profile';
        User userRecord =BCD_TestUtility.createCommunityUser(Profile);
        Test.getEventBus().deliver();
    }  
    
    @isTest public static void test(){
        test.startTest();
        User u=[select user.id, user.Email, user.FirstName, user.LastName, user.profile.name FROM
                user WHERE user.profile.name='Customer Community User Profile' 
                AND user.Email ='no@email.com' LIMIT 1];    
        u.Email='mtxtest@gmail.com';
        update u;
        test.stopTest();
        Test.getEventBus().deliver();
    }
}