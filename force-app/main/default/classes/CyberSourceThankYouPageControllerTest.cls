/**
* @description       : 
* @author            : Khushbu Pareek
* @group             : 
* @last modified on  : 09-27-2021
* @last modified by  : Wasef Mohiuddin
* Modifications Log 
* Ver   Date         Author            Modification
* 1.0   Initial Version
**/
@isTest
public without sharing class CyberSourceThankYouPageControllerTest {
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
                rat.RegulatoryAuthCategory = 'Continuing Education Provider';  
                RegulatoryAuthorityTypeInsertList.add(rat);
            }
            insert RegulatoryAuthorityTypeInsertList;
            
            for(RegulatoryAuthorizationType regType : RegulatoryAuthorityTypeInsertList){
                PreliminaryApplicationRef appRef = BCD_TestUtility.createPreliminaryApplicationRef(acc.Id,false);
                if(regType.Name == 'Accountancy'){
                    appRef.Lost_Authorization_Practice__c = 'No';
                    appRef.Revocation_due_to_disciplinary__c = 'No';
                    appRef.Certificate_Canceled_Revoked_Suspended__c = 'No';
                    appRef.Participated_in_conduct_adversely__c = 'No';
                    appRef.Public_Accountancy__c = 'No';
                    appRef.Own_Tax_Returns__c = 'No';
                    appRef.Registration_Type_Changed__c = 'No';
                    appRef.Firm_Ownership__c = 'No';
                    appRef.EXEMPT_From_Peer_Review__c = 'Yes';
                    appRef.Compliance_Certification__c ='Yes';
                    appRef.Valid_CPA_License__c = 'Yes';
                    appRef.Branch_Office__c = 'No';
                }
                appRef.LicenseStartDate__c = Date.today().addDays(1);
                appRef.LicenseEndDate__c = Date.today().addDays(100);
                appRef.LicenseTypeId__c = regType.Id;
                appRef.Licensee_Responsible_For_Requested_Info__c = 'Yes';
                appRef.Disciplinary_Action_in_another_State__c = 'No';
                appRef.Currently_Providing_Supervision__c = 'Yes';
                //      appRef.Flags__c = 'hold';
                appRef.CEU_Completion__c = 'Yes';
                //     appRef.Flag_Reason__c = 'test;';
                prelimList.add(appRef);
                BusinessLicense businessLicense = BCD_TestUtility.createBusinessLicense(contact.Id,false);
                businessLicense.RegulatoryAuthorizationTypeId = regType.Id;
                businessLicense.Name = 'test-license';
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
    
    @isTest 
    static void test_doInitDecisionAcceptForNewPaymentFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c,Request_Details__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }

    @isTest 
    static void test_doInitDecisionAcceptForNewPaymentFeeNonCommunityUser() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('req_amount', 'null');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
            Test.startTest();
            controller.doInit();
            Test.stopTest();
    }
    
    @isTest 
    static void test_doInitDecisionAcceptPendingFeeCannabis() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        Account acc = [SELECT Id,FirstName From Account WHERE FirstName = 'Test FName'];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Application Fee';
        PreliminaryApplicationRef application = [SELECT Id, Authority__c,Status_Reason__c, LicenseTypeId__c, Request_Type__c FROM PreliminaryApplicationRef WHERE Id =: transLog1.Application_Reference__c];
        application.Authority__c = 'Cannabis';
        application.Status__c = 'Pending Applicant Action';
        application.Status_Reason__c = 'Pending Application Payment';
        update application;
        IndividualApplication mainApplication =  [SELECT Id, Status, License_Status__c, SavedApplicationRefId FROM IndividualApplication WHERE SavedApplicationRefId =: application.Id LIMIT 1];
        mainApplication.Status = 'Pending Applicant Action';
        mainApplication.Authority__c = 'Cannabis';
        mainApplication.Status_Reason__c = 'Pending Application Payment';
        mainApplication.License_Status__c = '';
        mainApplication.Pending_Applicant_Action_Comments__c = 'Test Comments';
        update mainApplication;
        RegulatoryTrxnFee feeRecord = BCD_TestUtility.createRegulatoryTrxnFee(mainApplication.Id,'Due','Application Fee',false);
        feeRecord.Mode_Of_Payment__c = NULL;
        feeRecord.Application_Reference__c = application.Id;
        feeRecord.AccountId = acc.Id;
        insert feeRecord;
        transLog1.Regulatory_Transaction_Fee__c = feeRecord.Id;
        update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        
            Test.startTest();
            controller.doInit();
            Test.stopTest();
    }
    
    @isTest 
    static void test_doInitDecisionFailureForNewPaymentFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '102');
        pageRef.getParameters().put('decision', 'ERROR');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    
    @isTest 
    static void test_newPaymentPendingTransaction() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Regulatory_Transaction_Fee__c, Transaction_Fee_Created__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        translog1.Transaction_Fee_Created__c = false;
        translog1.Regulatory_Transaction_Fee__c = null;
        translog1.Transaction_Id__c = 'testId';
        update translog1;
        
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    
    @isTest 
    static void test1_newPaymentPendingTransaction() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c, Regulatory_Transaction_Fee__c, Transaction_Fee_Created__c, Application_Reference__r.LicenseTypeId__c, Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        translog1.Transaction_Fee_Created__c = false;
        translog1.Regulatory_Transaction_Fee__c = null;
        translog1.Transaction_Id__c = null;
        update translog1;
        
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', null);
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Counseling' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest
    static void test_doInitDecisionAcceptForNewFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Counseling' Limit 1];
        transLog1.Payment_Type__c = 'Application Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFeeAccountancy() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Application_Reference__r.LicenseTypeId__r.Id,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Accountancy' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        RegulatoryAuthorizationType regAugType = new RegulatoryAuthorizationType();
        regAugType.Id = transLog1.Application_Reference__r.LicenseTypeId__r.Id;
        regAugType.External_Id__c = 'CPA';
        update regAugType;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFeeAccountancy2() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Application_Reference__r.LicenseTypeId__r.Id,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Accountancy' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        RegulatoryAuthorizationType regAugType = new RegulatoryAuthorizationType();
        regAugType.Id = transLog1.Application_Reference__r.LicenseTypeId__r.Id;
        regAugType.External_Id__c = 'Firm Permit';
        update regAugType;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFeePsychology() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Psychology' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFeeBarbers() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Barbers & Cosmetologists' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFeeRealEstate() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Real Estate Commission' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFeeSocialWork() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Social Work' Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
        
        
    }
    @isTest 
    static void test_doInitDecisionAcceptForRenewalFee2() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        PreliminaryApplicationRef appRef = [SELECT Id,Flag_Reason__c,Flags__c FROM PreliminaryApplicationRef LIMIT 1].get(0);
        appRef.Flag_Reason__c = '';
        appRef.Flags__c = '';
        update appRef;
        
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_AcceptForRenewalFeeNoIndividualApplication() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Social Work' Limit 1];
        Delete [SELECT Id FROM IndividualApplication WHERE SavedApplicationRefId =: transLog1.Application_Reference__c LIMIT 1];
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_AcceptForRenewalFeeNoIndividualApplication2() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Counseling' Limit 1];
        delete [SELECT Id FROM IndividualApplication WHERE SavedApplicationRefId =: transLog1.Application_Reference__c LIMIT 1];
        
        transLog1.Payment_Type__c = 'Renewal Fee';
        update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_AcceptForRenewalFeeNoIndividualApplication3() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Real Estate Commission' Limit 1];
        Delete [SELECT Id FROM IndividualApplication WHERE SavedApplicationRefId =: transLog1.Application_Reference__c LIMIT 1];
        
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_AcceptForRenewalFeeNoIndividualApplication4() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Accountancy' Limit 1];
        Delete [SELECT Id FROM IndividualApplication WHERE SavedApplicationRefId =: transLog1.Application_Reference__c LIMIT 1];
        
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_AcceptForRenewalFeeNoIndividualApplication5() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Barbers & Cosmetologists' Limit 1];
        Delete [SELECT Id FROM IndividualApplication WHERE SavedApplicationRefId =: transLog1.Application_Reference__c LIMIT 1];
        
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_AcceptForRenewalFeeNoIndividualApplication6() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null AND Application_Reference__r.LicenseTypeId__r.IssuingDepartment.ExternalId__c = 'Psychology' Limit 1];
        Delete [SELECT Id FROM IndividualApplication WHERE SavedApplicationRefId =: transLog1.Application_Reference__c LIMIT 1];
        
        transLog1.Payment_Type__c = 'Renewal Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_doInitDecisionAcceptForIssuanceFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        IndividualApplication app = [SELECT Id, Status, SavedApplicationRefId, License_Status__c FROM IndividualApplication WHERE SavedApplicationRefId=:transLog1.Application_Reference__c];
        app.Status = 'Approved';
        app.License_Status__c = 'Pending Issuance Fee';
        update app;
        transLog1.Payment_Type__c = 'Issuance Fee';
        update transLog1;
        System.runAs( communityUsr1 ){
            
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+communityUsr1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_doInitDecisionAcceptForPenaltyFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Business_License__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Penalty Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Business_License__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }

    @isTest 
    static void test_doInitDecisionAcceptForPenaltyFee1() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Penalty Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Business_License__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }

    @isTest 
    static void test_doInitDecisionAcceptForAmendmentFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Business_License__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Amendment Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Business_License__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    @isTest 
    static void test_doInitDecisionAcceptForAmendmentFee1() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Amendment Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Business_License__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            try{
                controller.doInit();
                controller.additionalThankYouParams = 'xyz';
            } catch(Exception ex) {}
            Test.stopTest();
        }
    }
    @isTest 
    static void test_doInitDecisionAcceptForExaminationFee() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Payment_Type__c = 'Examination Fee';
        Update transLog1;
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    }
    
    @isTest 
    static void test_doInitDecisionError() { 
        Contact con1 = [SELECT Id FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c FROM Transaction_Log__c WHERE Business_License__c!=null Limit 1];
        
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ERROR');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+transLog1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.doInit();
            Test.stopTest();
        }
    } 
    
    @isTest
    static void createPendingRegTxnFeeItemsFromTransactionLogstest(){
        Contact con1 = [SELECT Id,AccountId FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        List<Transaction_Log__c> transLog2 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c FROM Transaction_Log__c ];
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+communityUsr1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            controller.createPendingRegTxnFeeItemsFromTransactionLogs(new List<Transaction_Log__c>{}, transLog1.Application_Reference__c);
            Test.stopTest();
        }
    }

    @isTest
    static void createPendingRegTxnFeeItemsFromTransactionLogstest1(){
        Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        Contact con1 = [SELECT Id,AccountId FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        con1.AccountId = acc.Id;
        update con1;
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        
        transLog1.Contact__c = con1.Id;
        update transLog1;
        PreliminaryApplicationRef application = [SELECT Id, Authority__c,Status_Reason__c, LicenseTypeId__c, Request_Type__c, Business_License__c  FROM PreliminaryApplicationRef WHERE Id =: transLog1.Application_Reference__c];
        BusinessLicense bl = [select id from BusinessLicense LIMIT 1 ];
        application.Business_License__c = bl.Id;
        update application;
        
        List<Transaction_Log__c> transLog2 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c, Transaction_Id__c FROM Transaction_Log__c ];
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+communityUsr1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            try{
                controller.doInit();
                //controller.createPendingRegTxnFeeItemsFromTransactionLogs(transLog2, transLog1.Application_Reference__c);
                controller.createPendingRegTxnFeeItemsFromTransactionLogs(transLog2, application.Business_License__c);
            } catch (Exception ex){
                system.debug('ex '+ex.getMessage());
            }
            Test.stopTest();
        }
    }

    @isTest
    static void createPendingRegTxnFeeItemsFromTransactionLogstest2(){
        Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        Contact con1 = [SELECT Id,AccountId FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        con1.AccountId = acc.Id;
        update con1;
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c,Request_Details__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Request_Details__c = 'abc';
        update transLog1;
        List<Transaction_Log__c> transLog2 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c FROM Transaction_Log__c ];
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+communityUsr1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            try{
                controller.createRegulatoryTrxnFeeItems(null, null);
            } catch (Exception ex){}
            Test.stopTest();
        }
    }

    @isTest
    static void createPendingRegTxnFeeItemsFromTransactionLogstest3(){
        Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        Contact con1 = [SELECT Id,AccountId FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        con1.AccountId = acc.Id;
        update con1;
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c,Request_Details__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Request_Details__c = '[]';
        update transLog1;

        List<Transaction_Log__c> transLog2 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c FROM Transaction_Log__c ];
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+communityUsr1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            try{
                RegulatoryTrxnFee RegulatoryFee = BCD_TestUtility.createRegulatoryTrxnFee(transLog1.Application_Reference__c,'Paid','Application Fee',true); 
                controller.createRegulatoryTrxnFeeItems('[]',transLog1.Id);
            } catch (Exception ex){}
            Test.stopTest();
        }
    }

    @isTest
    static void createPendingRegTxnFeeItemsFromTransactionLogstest4(){
        Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        Contact con1 = [SELECT Id,AccountId FROM Contact WHERE FirstName = 'con1' LIMIT 1];
        con1.AccountId = acc.Id;
        update con1;
        User communityUsr1 = [SELECT Id FROM USER WHERE ContactId=:con1.Id LIMIT 1];
        Transaction_Log__c transLog1 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c,Request_Details__c FROM Transaction_Log__c WHERE Application_Reference__c!=null Limit 1];
        transLog1.Request_Details__c = '[]';
        update transLog1;

        List<Transaction_Log__c> transLog2 = [SELECT Id,Contact__c,Application_Reference__c,Amount__c,Payment_Type__c, Business_License__c,Transaction_Response__c FROM Transaction_Log__c ];
        PageReference pageRef = Page.CyberSourceThankYouPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('reason_code', '100');
        pageRef.getParameters().put('decision', 'ACCEPT');
        pageRef.getParameters().put('message', 'test message');
        pageRef.getParameters().put('req_reference_number', '3343');
        pageRef.getParameters().put('transaction_id', '87898789');
        pageRef.getParameters().put('req_issuer_additional_data', ''+transLog1.Contact__c+'__'+transLog1.Application_Reference__c+'__'+transLog1.Payment_Type__c+'__'+communityUsr1.Id+'__'+transLog1.Id);
        
        CyberSourceThankYouPageController controller = new CyberSourceThankYouPageController();
        System.runAs( communityUsr1 ){
            Test.startTest();
            try{
                RegulatoryTrxnFee RegulatoryFee = BCD_TestUtility.createRegulatoryTrxnFee(transLog1.Application_Reference__c,'Paid','Application Fee',true); 
                controller.createRegulatoryTrxnFeeItems('[]',RegulatoryFee.Id);
            } catch (Exception ex){}
            Test.stopTest();
        }
    }
}