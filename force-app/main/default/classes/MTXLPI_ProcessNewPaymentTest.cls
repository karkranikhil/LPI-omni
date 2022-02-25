/**
* @description       : 
* @author            : Khushbu Pareek
* @group             : 
* @last modified on  : 10-11-2021
* @last modified by  : Osama Naaz
* Modifications Log 
* Ver   Date         Author            Modification
* 1.0   Initial Version
**/
@isTest
public without sharing class MTXLPI_ProcessNewPaymentTest {
    @testSetup
    public static void createData(){
        
        User usr = BCD_TestUtility.createCommunityUser('Customer Community User Profile');
        System.runAs(usr){
            String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
           	 	Account acc= new Account(
               RecordTypeID=recordTypeId ,
                FirstName='Test FName',
                LastName='Test LName',
                PersonMailingStreet='test@yahoo.com',
                PersonMailingPostalCode='12345',
                PersonMailingCity='SFO',
                PersonEmail='test@yahoo.com',
                PersonHomePhone='1234567',
                PersonMobilePhone='12345678'
            );
            
            insert acc;
            
            Contact contact = [SELECT Id,FirstName,AccountId FROM Contact WHERE FirstName='con1'];
          //  acc.Id = contact.AccountId;
            
            List<RegulatoryAuthority> RegulatoryAuthorityInsertList = new List<RegulatoryAuthority>();
            List<RegulatoryAuthorizationType> RegulatoryAuthorityTypeInsertList = new List<RegulatoryAuthorizationType>();
            List<PreliminaryApplicationRef> prelimList = new List<PreliminaryApplicationRef>();
            List<businessLicense> businessList = new List<businessLicense>();
            List<IndividualApplication> indAppList = new List<IndividualApplication>();
            List<Transaction_Log__c> transacList1 = new List<Transaction_Log__c>();
            List<Transaction_Log__c> transacList2 = new List<Transaction_Log__c>();
            List<RegulatoryTrxnFee> RegulatoryTrxnList = new List<RegulatoryTrxnFee>();
            List<Supervisor__c> supervisorList = new List<Supervisor__c>();
            List<String> RegulatoryAuthorityList = new List<String>{'Accountancy','Barbers & Cosmetologists','Real Estate Commission','Counseling','Social Work','Psychology'};
                for(String regA : RegulatoryAuthorityList){
                    RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority(regA, false);
                    regAut.ExternalId__c = regA;
                    RegulatoryAuthorityInsertList.add(regAut);
                }
            Insert RegulatoryAuthorityInsertList;
            
            For(RegulatoryAuthority regAuth : RegulatoryAuthorityInsertList){
                RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType(regAuth.Name, regAuth.Id, false);
                rat.RegulatoryAuthCategory = 'CPA';  
                RegulatoryAuthorityTypeInsertList.add(rat);
            }
            insert RegulatoryAuthorityTypeInsertList;
            
            for(RegulatoryAuthorizationType regType : RegulatoryAuthorityTypeInsertList){
                PreliminaryApplicationRef appRef = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
                if(regType.Name == 'Accountancy'){
                    appRef.Lost_Authorization_Practice__c = 'Yes';
                    appRef.Revocation_due_to_disciplinary__c = 'Yes';
                    appRef.Certificate_Canceled_Revoked_Suspended__c = 'Yes';
                    appRef.Participated_in_conduct_adversely__c = 'Yes';
                    appRef.Public_Accountancy__c = 'Yes';
                    appRef.Own_Tax_Returns__c = 'Yes';
                    appRef.Client_Tax_Returns__c = 'Yes';
                    appRef.CEU_Completion__c = 'No';
                    appRef.Compliance_Certification__c ='Yes';
                    appRef.Payment_to_be_made_by_Operating_Transfer__c = true;
                    appRef.Branch_Office__c = 'No';
                }
                appRef.LicenseStartDate__c = Date.today().addDays(1);
                appRef.LicenseEndDate__c = Date.today().addDays(100);
                appRef.LicenseTypeId__c = regType.Id;
                appRef.Licensee_Responsible_For_Requested_Info__c = 'Yes';
                appRef.Disciplinary_Action_in_another_State__c = 'No';
                appRef.Currently_Providing_Supervision__c = 'Yes';
                appRef.CEU_Completion__c = 'No';
                appRef.BusinessAccountNameId = acc.Id;
                prelimList.add(appRef);
                BusinessLicense businessLicense = BCD_TestUtility.createBusinessLicense(contact.Id,false);
                businessLicense.RegulatoryAuthorizationTypeId = regType.Id;
                businessLicense.Name = 'test-license';
                businessLicense.Status = 'Expired';
                businessList.add(businessLicense);
            }
            insert prelimList;
            insert businessList;
            for(PreliminaryApplicationRef prem : prelimList){
                IndividualApplication indApp = new IndividualApplication
                    (Attestation_checkbox__c = false,
                     SavedApplicationRefId = prem.Id,
                     AppliedDate = Date.today().addDays(100),
                     Category = 'License',
                     System_Approved__c = true,
                     WasReturned = false,
                     LicenseTypeid = prem.LicenseTypeId__c,
                     Status = 'Approved'
                    );
                indAppList.add(indApp);
                Transaction_Log__c trans2 = BCD_TestUtility.createTransactionLog(usr.Id,null,prem.Id,False);
                transacList2.add(trans2);
                Supervisor__c supervisor = BCD_TestUtility.createSupervisor(prem.Id, false);
                supervisorList.add(supervisor);
            }
            Insert indAppList;
            Insert transacList2;
            Insert supervisorList;
            
            for(BusinessLicense bs : businessList){
                Transaction_Log__c trans1 = BCD_TestUtility.createTransactionLog(usr.Id,bs.Id,null,False);
                trans1.Contact__c = contact.Id;
                transacList1.add(trans1);
                RegulatoryTrxnFee RegulatoryFee = BCD_TestUtility.createRegulatoryTrxnFee(bs.Id,'Paid','Application Fee',False); 
                RegulatoryTrxnList.add(RegulatoryFee);
            }
            insert transacList1;
            insert RegulatoryTrxnList;
        }
        
        
        Payment_Configuration__mdt  cyberSource = [SELECT Id, DeveloperName, CyberSource_Access_Key__c, CyberSource_Profile_Id__c,
                                                   CyberSource_Secret_Key__c, EndPoint_Url__c
                                                   FROM Payment_Configuration__mdt WHERE DeveloperName='CyberSource_ECheck' ];
        
        
    }
    
    @IsTest
    public static void method2() {
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Regulatory_Transaction_Fee__c, Transaction_Fee_Created__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Counseling' Limit 1];
        translog1.Transaction_Fee_Created__c = false;
        translog1.Regulatory_Transaction_Fee__c = null;
        translog1.Transaction_Id__c = 'testId';
        translog1.Contact__c = con1.Id;
        update translog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
		Account acc1 = new Account();
        acc1.Name = 'ABC';
        insert acc1;
        Contact contact = [SELECT Id,FirstName,AccountId FROM Contact WHERE Id=: transLog1.Contact__c];
        contact.AccountId = acc1.Id;
        update contact;        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            test.startTest();
            controller.doInit();
            MTXLPI_ProcessNewPayment.processNewPayment(controller);
            //System.assert(false, [SELECT Id, AccountId FROM Contact WHERE Id =: controller.paymentResponse.contactId LIMIT 1]);
            test.stopTest();
        }
    }
}