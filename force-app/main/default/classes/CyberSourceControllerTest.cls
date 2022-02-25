/**
* @description       : 
* @author            : Khushbu Pareek
* @group             : 
* @last modified on  : 06-30-2021
* @last modified by  : Wasef Mohiuddin
* Modifications Log 
* Ver   Date         Author            Modification
* 1.0   06-17-2021   Wasef Mohiuddin   Initial Version
**/
@isTest
public with sharing class CyberSourceControllerTest {
    
    @testSetup
    public static void createData(){
        
        User usr = BCD_TestUtility.createCommunityUser('Customer Community User Profile');
        System.runAs(usr){
            Contact contact = [SELECT Id,FirstName FROM Contact WHERE FirstName='con1'];
            
            Account account = [SELECT Id,Name FROM Account WHERE Name='Test Account Name'];
            
            PreliminaryApplicationRef appRef = BCD_TestUtility.createPreliminaryApplicationRef(account.Id,True); 
            
            BusinessLicense businessLicense = BCD_TestUtility.createBusinessLicense(contact.Id,True); 
            
            Transaction_Log__c trans1 = BCD_TestUtility.createTransactionLog(usr.Id,businessLicense.Id,null,True);
            
            Transaction_Log__c trans2 = BCD_TestUtility.createTransactionLog(usr.Id,null,appRef.Id,True);
            
            RegulatoryTrxnFee RegulatoryFee = BCD_TestUtility.createRegulatoryTrxnFee(businessLicense.Id,'Paid','Application Fee',True);
            
            Payment_Configuration__mdt  cyberSource = [SELECT Id, DeveloperName, CyberSource_Access_Key__c, CyberSource_Profile_Id__c,
                                                       CyberSource_Secret_Key__c, EndPoint_Url__c
                                                       FROM Payment_Configuration__mdt WHERE DeveloperName='CyberSource_ECheck' ];
            
            
        }
        
    }
    
    @isTest
    public static void testPaymentWithCard1(){
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Amount__c,Payment_Type__c, Business_License__c, Application_Reference__c FROM Transaction_Log__c WHERE Business_License__c!=null Limit 1];
        Transaction_Log__c transLog2 = [SELECT Id,Amount__c,Payment_Type__c, Business_License__c, Application_Reference__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        PageReference pageRef = Page.CyberSourcePayment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('tid', String.valueOf(transLog1.Id));
        pageRef.getParameters().put('paymenttype', transLog1.Payment_Type__c);
        pageRef.getParameters().put('mode', 'card');
        system.debug('shashank1++'+String.valueOf(transLog1.Id)+'----'+transLog1.Payment_Type__c);
        Test.startTest();
        CyberSourceController obj = new CyberSourceController();
        //pageRef.getParameters().put('paymenttype', transLog1.Payment_Type__c);
        System.assertEquals(200, obj.amount);
        Test.stopTest();
        
    }
    @isTest
    public static void testPaymentWithCard2(){
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        
        Transaction_Log__c transLog2 = [SELECT Id,Amount__c,Payment_Type__c, Business_License__c, Application_Reference__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        PageReference pageRef = Page.CyberSourcePayment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('tid', String.valueOf(transLog2.Id));
        pageRef.getParameters().put('paymenttype', transLog2.Payment_Type__c);
        pageRef.getParameters().put('mode', 'card');
        Test.startTest();
        CyberSourceController obj = new CyberSourceController();
        pageRef.getParameters().put('paymenttype', transLog2.Payment_Type__c);
        System.assertEquals(200, obj.amount);
        Test.stopTest();
        
    }
    @isTest
    public static void testPaymentWithEcheck(){
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog = [SELECT Id,Amount__c,Payment_Type__c, Business_License__c, Application_Reference__c FROM Transaction_Log__c WHERE Amount__c=200 Limit 1];
        PageReference pageRef = Page.CyberSourcePayment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('tid', String.valueOf(transLog.Id));
        pageRef.getParameters().put('paymenttype', transLog.Payment_Type__c);
        pageRef.getParameters().put('mode', 'echeck');
        Test.startTest();
        CyberSourceController obj = new CyberSourceController();
        pageRef.getParameters().put('paymenttype', transLog.Payment_Type__c);
        System.assertEquals(200, obj.amount);
        Test.stopTest();
        
    }
    @isTest
    public static void signTest(){
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog = [SELECT Id,Amount__c,Payment_Type__c, Business_License__c, Application_Reference__c FROM Transaction_Log__c WHERE Business_License__c!=null Limit 1];
        PageReference pageRef = Page.CyberSourcePayment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('tid', String.valueOf(transLog.Id));
        pageRef.getParameters().put('paymenttype', transLog.Payment_Type__c);
        pageRef.getParameters().put('mode', 'card');
        Test.startTest();
        CyberSourceController obj2 = new CyberSourceController();
        String response='';
        response = CyberSourceController.sign(new Map<String,String>{'signed_field_names' => 'test1,test2'});
        Test.stopTest();
        System.assert(response != '');
    }
    @isTest
    public static void testOtherMethods(){
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog = [SELECT Id,Amount__c,Payment_Type__c, Business_License__c, Application_Reference__c FROM Transaction_Log__c WHERE Business_License__c!=null Limit 1];
        PageReference pageRef = Page.CyberSourcePayment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('tid', String.valueOf(transLog.Id));
        pageRef.getParameters().put('paymenttype', transLog.Payment_Type__c);
        pageRef.getParameters().put('mode', 'card');
        Test.startTest();
        CyberSourceController obj2 = new CyberSourceController();
        String response1 = obj2.getUUID();
        String response2 = obj2.getUTCDateTime();
        String response3 = obj2.getParametersValuesHidden();
        String response4 = obj2.getSignedData();
        String response = '';
        response = CyberSourceController.sign(new Map<String,String>{'signed_field_names' => 'test1,test2'});
        Test.stopTest();
        System.assert(response != '');
        System.assert(response1 != '');
        System.assert(response2 != '');
        System.assert(response3 != '');
        System.assert(response4 != '');
    }
    /*
    @isTest
    public static void getUUIDTest(){
        Test.startTest();
        system.debug('shashankmtx++4'+String.valueOf(transLog1.Id)+'----'+transLog1.Payment_Type__c);
        CyberSourceController obj = new CyberSourceController();
        String response = obj.getUUID();
        Test.stopTest();
        System.assert(response != '');
    }
    @isTest
    public static void getUTCDateTimeTest(){
        Test.startTest();
        CyberSourceController obj = new CyberSourceController();
        String response = obj.getUTCDateTime();
        Test.stopTest();
        System.assert(response != '');
    }
    
    @isTest
    public static void getParametersValuesHiddenTest(){
        Test.startTest();
        CyberSourceController obj = new CyberSourceController();
        String response = obj.getParametersValuesHidden();
        Test.stopTest();
        System.assert(response == '');
    }
    @isTest
    public static void getSignedDataTest(){
        Test.startTest();
        CyberSourceController obj = new CyberSourceController();
        String response = obj.getSignedData();
        Test.stopTest();
        System.assert(response != '');
    }
*/
}