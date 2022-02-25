/**
* @description       : Perform operations and save data in Salesforce based on the response from the CyberSource Portal.
* @author            : Wasef Mohiuddin
* @group             : MTX
* @last modified on  : 09-28-2021
* @last modified by  : Wasef Mohiuddin
* Modifications Log 
* Ver   Date         Author            Modification
* 1.0   05-26-2021   Wasef Mohiuddin   Initial Version
* 2.0   09-28-2021   Wasef Mohiuddin   Added Comments and Method Descriptions
**/
public without sharing class CyberSourceThankYouPageController {
    
    // Global Variables and their Definitions to be used in the entire class
    Map <String, String> params;
    public PaymentResponse paymentResponse {get; set;}
    public Boolean processCompleted {get; set;}
    public Boolean reloadWindowCheck {get; set;}
    public String message {get; set;}
    public String transactionResponse {get; set;}
    public String requestDetails {get; set;}
    public String thankYouFlowType {get; set;}
    public String additionalThankYouParams {get; set;}
    public String cybersourceResponse {
        get {
            return JSON.serialize(paymentResponse);
        }
    }
    
    // Constructor used to initialize the Payment Response that would be passed on from the CyberSource Portal with data as needed.
    public CyberSourceThankYouPageController(){
        paymentResponse = new PaymentResponse();
    }
    
    // Payment Response Wrapper Class
    public class PaymentResponse {
        public Decimal auth_amount {get; set;}
        public Integer reason_code {get; set;}
        public String decision {get; set;}
        public String referenceNumber {get; set;}
        public String message {get; set;}
        public String transactionid {get; set;}
        public String paymentMethod {get; set;}
        public String contactId {get; set;}
        public String recordId {get; set;}
        public String paymentType {get; set;}
        public String transactionLogId {get; set;}
    }
    
    // Fee Item Response Wrapper Class
    public class FeeItem {
        public String FeeType {get; set;}
        public Decimal Amount {get; set;}
        public String AccountCode {get; set;}
        public String FundCode {get; set;}
        public String DepartmentCode {get; set;}
        public String RevenueCode {get; set;}
        public String CaseId {get; set;}
    }
    
    // Initialises Wrapper Classes, Method Implementations and Performs operations to save data in Salesforce
    public void doInit(){
        
        params = ApexPages.currentPage().getParameters();
        transactionResponse = JSON.serialize (ApexPages.currentPage().getParameters());
        Integer reason_code = Integer.valueOf( params.get('reason_code') != null ? params.get('reason_code') : '0' );
        String decision = params.get('decision');
        
        paymentResponse.decision = params.get('decision');
        paymentResponse.message = params.get('message');
        paymentResponse.reason_code = reason_code;
        paymentResponse.referenceNumber = params.get('req_reference_number');
        paymentResponse.paymentMethod = params.get('req_payment_method');        
        
        if( params.get( 'req_issuer_additional_data' ) != null) {
            
            List<String> data = params.get( 'req_issuer_additional_data' ).split('__');
            
            paymentResponse.contactId = data[0];
            paymentResponse.paymentType = data[2];
            paymentResponse.recordId = data[1];
            paymentResponse.transactionLogId = data[4];
            system.debug('TransactionLogId>>>'+paymentResponse.transactionLogId);
            requestDetails = [SELECT Id, Request_Details__c FROM Transaction_Log__c WHERE Id =: paymentResponse.transactionLogId].Request_Details__c;
            
            if( decision != null && decision == 'ACCEPT' && reason_code == 100 ) {
                
                try {
                    
                    paymentResponse.transactionid = params.get('transaction_id');
                    paymentResponse.auth_amount = params.get('req_amount') != null ? Decimal.valueOf((params.get('req_amount') + '')) : null;
                    
                    reloadWindowCheck = true;
                    
                    List<Transaction_Log__c> recurringTransactionLogs = [SELECT Id, Transaction_Id__c, Business_License__c 
                                                                         FROM Transaction_Log__c 
                                                                         WHERE Transaction_Id__c =: paymentResponse.transactionid];

                    List<Transaction_Log__c> tLogs = [
                        SELECT Id, Transaction_Id__c, Business_License__c 
                                                                         FROM Transaction_Log__c 
                                                                         WHERE Id =: paymentResponse.transactionLogId
                    ];
                    system.debug('TransactionLogSize>>'+tLogs.size());
                    system.debug('PaymentType>>'+paymentResponse.paymentType);
                    if(tLogs.size() > 0 && paymentResponse.paymentType == 'Renewal'){
                            List<BusinessLicense> bls = new List<BusinessLicense>();
                            for(Transaction_Log__c tl: tLogs){
                                BusinessLicense bl = new BusinessLicense();
                                bl.Id = tl.Business_License__c;
                                bl.PeriodStart = System.today();
                                bl.PeriodEnd = System.today().AddDays(365);
                                bls.add(bl);
                            }
                            update bls;
                    }

                    
                    if(recurringTransactionLogs.isEmpty()) {
                        if (paymentResponse.paymentType == 'Application Fee'){
                            MTXLPI_ProcessNewPayment.processNewPayment(this);
                        } 
                         else if (paymentResponse.paymentType == 'Renewal Fee') {
                            thankYouFlowType = 'newRenewal';
                            MTXLPI_ProcessRenewalPayment.processRenewalPayment(this);
                        } else if (paymentResponse.paymentType == 'Settlement Fee'){
                            processSettlementPayment();
                        } else if (paymentResponse.paymentType == 'Summon Fee'){
                            processSummonPayment();
                        } else if (paymentResponse.paymentType == 'Issuance Fee'){
                            processIssuancePayment();
                        } else if (paymentResponse.paymentType == 'Penalty Fee'){
                            processPenaltyPayment();
                        } else if (paymentResponse.paymentType == 'Amendment Fee'){
                            processAmendmentPayment();
                        } else if (paymentResponse.paymentType == 'Examination Fee'){
                            reloadWindowCheck = false;
                            processExaminationPayment();
                        }

                        processCompleted = true;
                    } else {
                        paymentResponse.decision = 'ERROR';
                        
                        message = '<p class="slds-text-heading_small">Your payment has already been completed successfully. Please contact NM B&C Support with the following details: </p>';
                        message += '<br/>Transaction Id: ' + params.get('transaction_id');
                        message += '<br/>Reference Number: ' + params.get('req_reference_number');
                        message += '<br/>Paid Amount: $' + paymentResponse.auth_amount;
                        message += '<br/>Payment Type: ' + paymentResponse.paymentType;
                        message += '<br/><br/><br/>To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status with the Business Center.';   
                        
                        processCompleted = false;
                    }
                } catch (Exception ex) {
                    
                    paymentResponse.decision = 'ERROR';
                    
                    message = '<p class="slds-text-heading_small">Your payment has been processed successfully but the system failed to record it. Please contact NM B&C Support with the following details: </p>';
                    message += '<br/>Transaction Id: ' + params.get('transaction_id');
                    message += '<br/>Reference Number: ' + params.get('req_reference_number');
                    message += '<br/>Paid Amount: $' + paymentResponse.auth_amount;
                    message += '<br/>Payment Type: ' + paymentResponse.paymentType;
                    message += '<br/>Error: ' + ex.getMessage();
                    message += '<br/><br/><br/>To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status with the Business Center.';   
                    
                    processCompleted = false;
                }
            } else if( decision != null ) {
                
                message = '<p>Transaction Failed!</p>';
                message += '<p>Your payment request has failed due to the following error: </p>';
                message += '<p>Error Code: ' + paymentResponse.reason_code + '</p>';
                message += '<p>Reference Number: ' + paymentResponse.referenceNumber + '</p>';
                message += '<br/>Error: ';
                message += '<p>' + paymentResponse.message + '</p>';
                
                Transaction_Log__c toBeUpdatedLog = new Transaction_Log__c();
                toBeUpdatedLog.Id = paymentResponse.transactionLogId;
                toBeUpdatedLog.Transaction_Response__c = transactionResponse;
                toBeUpdatedLog.Response_Code__c = Integer.valueOf( params.get('reason_code') != null ? params.get('reason_code') : '0' ) + '';
                toBeUpdatedLog.Response_Time__c = Datetime.now();

                update toBeUpdatedLog;
            }
        }
    } 

    // Method that is used to Process New Application(Intake) Payments
    //
    
    // Method that is used to Process Issauance of new Business License Payments
    public void processIssuancePayment(){
        
        try {
            PreliminaryApplicationRef application = [SELECT Id, LicenseTypeId__c, Request_Type__c 
                                                     FROM PreliminaryApplicationRef 
                                                     WHERE Id =: paymentResponse.recordId];

            IndividualApplication mainApplication =  [SELECT Id, Status, License_Status__c, SavedApplicationRefId 
                                                      FROM IndividualApplication 
                                                      WHERE SavedApplicationRefId =: paymentResponse.recordId AND Status = 'Approved' 
                                                      AND License_Status__c='Pending Issuance Fee' LIMIT 1];

            RegulatoryTrxnFee rtxnFee = createRegulatoryTrxnFee('Application Intake', mainApplication.Id, application.Id);
            
            List<RegulatoryTrxnFeeItem> rtxnFeeItemsList = createRegulatoryTrxnFeeItems('Application', rtxnFee.Id);
            
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'Application', rtxnFee.Id);
            
            if(transactionLogRecord != null) {                
                mainApplication.Status = 'Approved';
                mainApplication.License_Status__c = 'Issued';
                
                update mainApplication;
                
            } else {
                throw new VisualForceException( 'Invalid transaction.' );
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'Application', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }
    
    // Method that is used to Process Penalty Payments related to a Business License record
    public void processPenaltyPayment(){
        try {
            BusinessLicense businessLicenseRecord = [SELECT Id, Total_Fine__c 
                                                     FROM BusinessLicense 
                                                     WHERE Id =: paymentResponse.recordId];
            
            RegulatoryTrxnFee rtxnFee = createRegulatoryTrxnFee('Business License', businessLicenseRecord.Id, null);
            
            List<RegulatoryTrxnFeeItem> feeItemList = createRegulatoryTrxnFeeItems('License Penalty', rtxnFee.Id);
            
            
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'License', rtxnFee.Id);
            
            if(transactionLogRecord != null) {
                businessLicenseRecord.Total_Fine__c = 0;
                
                upsert businessLicenseRecord;  
            } else{
                throw new VisualForceException( 'Invalid transaction.' );
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'License', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }

    // Method that is used to Process Settlement Payments related to a Settlement record
    public void processSettlementPayment(){
        try {
            Settlement__c settlementRecord = [SELECT Id 
                                                     FROM Settlement__c 
                                                     WHERE Id =: paymentResponse.recordId];
            
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'Settlement', null);
            
            if(transactionLogRecord != null) {
                settlementRecord.Status__c = 'Granted';
                upsert settlementRecord;
            } else{
                throw new VisualForceException( 'Invalid transaction.' );
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'Settlement', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }

    // Method that is used to Process Summon Payments related to a Summon record
    public void processSummonPayment(){
        try {
            Summon__c summonRecord = [SELECT Id 
                                                     FROM Summon__c 
                                                     WHERE Id =: paymentResponse.recordId];
            
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'Summon', null);
            
            if(transactionLogRecord != null) {
                //upsert summonRecord;
            } else{
                throw new VisualForceException( 'Invalid transaction.' );
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'Summon', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }


    
    // Method that is used to Process Amendment Payments related to a Business License record
    public void processAmendmentPayment(){
        try {
            BusinessLicense businessLicenseRecord = [SELECT Id FROM BusinessLicense WHERE Id =: paymentResponse.recordId];
            
            RegulatoryTrxnFee rtxnFee = createRegulatoryTrxnFee('Business License', businessLicenseRecord.Id, null);
            
            List<RegulatoryTrxnFeeItem> feeItemList = createRegulatoryTrxnFeeItems('License Amendment', rtxnFee.Id);
            
            thankYouFlowType = 'Amendment';
            
            if(feeItemList!= null && feeItemList.size() > 0 && feeItemList[0].Case__c!= null){
                Case caseRec = [SELECT caseNumber FROM Case WHERE Id =: feeItemList[0].Case__c LIMIT 1];
                additionalThankYouParams  = caseRec.caseNumber;
            }
            
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'License', rtxnFee.Id);
            
            if(transactionLogRecord == null) {
                throw new VisualForceException( 'Invalid transaction.' );
            } 
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('FAILURE', 'License', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }
    
    // Method that is used to Process Examination Payments related to an IndividualApplication record
    public void processExaminationPayment(){
        try {
            
            PreliminaryApplicationRef application = [SELECT Id, Exam_Payment_Status__c 
                                                     FROM PreliminaryApplicationRef 
                                                     WHERE Id =: paymentResponse.recordId];
            
            List<IndividualApplication> mainApplication =  [SELECT Id, SavedApplicationRefId 
                                                            FROM IndividualApplication 
                                                            WHERE SavedApplicationRefId =: paymentResponse.recordId LIMIT 1];
            
            Transaction_Log__c transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'Application Exam', null);
            
            if(transactionLogRecord != null) {
                application.Exam_Payment_Status__c = 'Paid';
                
                update application;
            } else {
                throw new VisualForceException( 'Invalid transaction.' );
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'Application', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }
    
    // Method that is used to Process Pending Payments related to a Cannabis Applocation record
    public void processPendingPayment(){
        
        try {
            
            PreliminaryApplicationRef application = [SELECT Id, LicenseTypeId__c, Request_Type__c 
                                                     FROM PreliminaryApplicationRef 
                                                     WHERE Id =: paymentResponse.recordId LIMIT 1];
            
            IndividualApplication mainApplication =  [SELECT Id, Status,Status_Reason__c, License_Status__c, SavedApplicationRefId 
                                                      FROM IndividualApplication 
                                                      WHERE SavedApplicationRefId =: paymentResponse.recordId AND Status = 'Pending Applicant Action' 
                                                      AND Status_Reason__c= 'Pending Application Payment' LIMIT 1];
            
            RegulatoryTrxnFee rtxnFee = [SELECT Id, Application_Reference__c, ParentRecordId, Status, Mode_Of_Payment__c 
                                         FROM RegulatoryTrxnFee 
                                         WHERE ParentRecordId =: mainApplication.Id AND Application_Reference__c =: application.Id AND Status = 'Due' 
                                         AND Mode_Of_Payment__c = NULL LIMIT 1];
            
            
            Transaction_Log__c transactionLogRecord;
            Map<String, Object> transactionResponseMap = (Map<String, Object>)JSON.deserializeUntyped(transactionResponse);
        	String reqReferenceNumber;
        	if(transactionResponseMap.containsKey('req_reference_number'))
        	{
            reqReferenceNumber  = (String)transactionResponseMap.get('req_reference_number');
        	}
            if(rtxnFee != null) {
                rtxnFee.Status = 'Paid';
                rtxnFee.Transaction_Response__c = transactionResponse;
                rtxnFee.Req_Reference_Number__c  = transactionResponse;
                rtxnFee.transaction_Id__c = params.get('transaction_id') != null ? params.get('transaction_id') + '' : 'Transaction Fail';
                rtxnFee.Fee_Type__c = paymentResponse.paymentType;
                rtxnFee.Mode_Of_Payment__c = paymentResponse.paymentMethod;
                
                update rtxnFee;
                
                transactionLogRecord = createTransactionLogForPaymentResponse('SUCCESS', 'Application', rtxnFee.Id);
            }                      
            
            if(transactionLogRecord != null) {   
                mainApplication.Status = 'Submitted';             
                mainApplication.Status_Reason__c = 'Payment Submitted';
                
                update mainApplication;
            } else {
                throw new VisualForceException( 'Invalid transaction.' );
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'Application', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }
    
    // Method that is used to create Transaction Logs based on Payment Response being a Success or Failure
    public Transaction_Log__c createTransactionLogForPaymentResponse(String responseType, String flowType, String additionalParameter){
        
        if(responseType == 'SUCCESS'){
            
            Transaction_Log__c logRecord = new Transaction_Log__c(
                Id = paymentResponse.transactionLogId,
                Type__c = 'Response',
                Payment_Type__c = paymentResponse.paymentType,
                Regulatory_Transaction_Fee__c = additionalParameter,
                Contact__c = paymentResponse.contactId,
                User__c = UserInfo.getUserId(),
                Response_Time__c = DateTime.now(),
                Response_Code__c = Integer.valueOf( params.get('reason_code') != null ? params.get('reason_code') : '0' ) + '',
                Response_Status__c = params.get('decision'),
                Transaction_Id__c = paymentResponse.transactionid,
                Merchant_Reference_Number__c = paymentResponse.referenceNumber,
                Transaction_Response__c = transactionResponse
            );
            
            if(flowType == 'Application'){
                logRecord.Application_Reference__c = paymentResponse.recordId;
                logRecord.Transaction_Fee_Created__c = true;
            } else if(flowType == 'License'){
                logRecord.Business_License__c = paymentResponse.recordId;
                logRecord.Transaction_Fee_Created__c = true;
            } else if(flowType == 'Application Exam'){
                logRecord.Application_Reference__c = paymentResponse.recordId;
                logRecord.Transaction_Fee_Created__c = false;
            } else if(flowType == 'Summon'){
                logRecord.Summon__c = paymentResponse.recordId;
                logRecord.Transaction_Fee_Created__c = false;
            } else if(flowType == 'Settlement'){
                logRecord.Settlement__c = paymentResponse.recordId;
                logRecord.Transaction_Fee_Created__c = false;
            } 
            
            update logRecord;
            
            return logRecord;
            
        } else if(responseType == 'FAILURE'){
            Transaction_Log__c logRecord = new Transaction_Log__c(
                Id = paymentResponse.transactionLogId,
                Type__c = 'Response',
                User__c = UserInfo.getUserId(),
                Response_Time__c = DateTime.now(),
                Response_Code__c = Integer.valueOf( params.get('reason_code') != null ? params.get('reason_code') : '0' ) + '',
                Response_Status__c = 'Invalid transaction.',
                Transaction_Response__c = transactionResponse,
                SalesforceExceptions__c = additionalParameter
            );
            
            update logRecord;
            
            return logRecord;
            
        } else {
            return null;
        }
    }
    
    // Method that is used to create Case related to an IndividualApplication record
    public Case createCaseForApplicationIntake(String authority){
        
        Case applicationCase = new Case();
        applicationCase.Origin = 'Web';
        applicationCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Application_Intake').getRecordTypeId();
        applicationCase.Authority__c = authority;
        
        insert applicationCase;
        
        return applicationCase;
        
    }
    
    // Method that is used to create Regulatory Transaction Fees related to a Parent record to store Payment Data
    public RegulatoryTrxnFee createRegulatoryTrxnFee(String flowType, String parentRecordId, String additionalParameter){
        
    	Map<String, Object> transactionResponseMap = (Map<String, Object>)JSON.deserializeUntyped(transactionResponse);
        String reqReferenceNumber;
        if(transactionResponseMap.containsKey('req_reference_number')){
    	reqReferenceNumber  = (String)transactionResponseMap.get('req_reference_number');
        }
        if (flowType == 'Application Intake'){
            
            RegulatoryTrxnFee rtxnFee = new RegulatoryTrxnFee(
                ParentRecordId = parentRecordId,
                Status = 'Paid',
                Application_Reference__c = additionalParameter,
                AccountId = [SELECT Id, AccountId FROM Contact WHERE Id =: paymentResponse.contactId LIMIT 1].AccountId,
                Transaction_Response__c = transactionResponse,
                Req_Reference_Number__c = reqReferenceNumber,
                transaction_Id__c = params.get('transaction_id') != null ? params.get('transaction_id') + '' : 'Transaction Fail',
                Fee_Type__c = paymentResponse.paymentType,
                Mode_Of_Payment__c = paymentResponse.paymentMethod
            );
            
            insert rtxnFee;
            
            return rtxnFee;
            
        } else if (flowType == 'Business License'){
            
            RegulatoryTrxnFee rtxnFee = new RegulatoryTrxnFee(
                ParentRecordId = parentRecordId,
                Status = 'Paid',
                AccountId = [SELECT Id, AccountId FROM Contact WHERE Id =: paymentResponse.contactId LIMIT 1].AccountId,
                Transaction_Response__c = transactionResponse,
                Req_Reference_Number__c = reqReferenceNumber,
                transaction_Id__c = params.get('transaction_id') != null ? params.get('transaction_id') + '' : 'Transaction Fail',
                Fee_Type__c = paymentResponse.paymentType
            );
            
            insert rtxnFee;
            
            return rtxnFee;
            
        } else{
            return null;
        }
    }
    
    // Method that is used to create Regulatory Transaction Fee Items related to related RegulatoryTrxnFee Record
    public List<RegulatoryTrxnFeeItem> createRegulatoryTrxnFeeItems(String flowType, String parentRecordId){
        try{
            
            List<FeeItem> ft = new List<FeeItem>();
            List<Case> casesList = new List<Case>();
            List<RegulatoryTrxnFeeItem> rtxnFeeItemsList = new List<RegulatoryTrxnFeeItem>();
            
            if(requestDetails != null){
                
                if (requestDetails.startsWith('[') && requestDetails.endsWith(']'))
                    ft = (List<FeeItem>) JSON.deserialize(requestDetails, List<FeeItem>.class);
                else
                    ft = (List<FeeItem>) JSON.deserialize('['+requestDetails+']', List<FeeItem>.class);
                
                for(FeeItem fItems : ft){
                    
                    RegulatoryTrxnFeeItem rtxnFeeItem = new RegulatoryTrxnFeeItem();
                    rtxnFeeItem.RegulatoryTrxnFeeId = parentRecordId;
                    rtxnFeeItem.FeeAmount = fItems.Amount;
                    rtxnFeeItem.Fee_Name__c = fItems.FeeType;
                    rtxnFeeItem.Account_Code__c = fItems.AccountCode;
                    rtxnFeeItem.Fund_Code__c = fItems.FundCode;
                    rtxnFeeItem.Department_Code__c = fItems.DepartmentCode;
                    rtxnFeeItem.Revenue_Code_Description__c = fItems.RevenueCode;
                    
                    if(flowType == 'License Penalty'){
                        rtxnFeeItem.Case__c = fItems.CaseId;
                        Case caseRec = new Case();
                        caseRec.Id = fItems.CaseId;
                        caseRec.Penalty_Status__c = 'Paid';
                        caseRec.Penalty_Paid_Date_Time__c = System.now();
                        
                        casesList.add(caseRec);
                        
                    } else if(flowType == 'License Amendment'){
                        rtxnFeeItem.Case__c = fItems.CaseId;
                        Case caseRec = new Case();
                        caseRec.Id = fItems.CaseId;
                        caseRec.Status = 'New';
                        
                        casesList.add(caseRec);
                        
                    }
                    
                    rtxnFeeItem.Name = params.get('transaction_id') != null ? params.get('transaction_id') + '' : 'Transaction Fail';
                    rtxnFeeItemsList.add(rtxnFeeItem);
                    
                }
                
                if(!rtxnFeeItemsList.isEmpty()){
                    insert rtxnFeeItemsList;
                    if(!casesList.isEmpty()){
                        upsert casesList;
                    }
                    return rtxnFeeItemsList;
                } else {
                    return null;
                }
                
            } else {
                return null;
            }
        } catch (Exception ex){
            Transaction_Log__c transactionLogRecord = 
                createTransactionLogForPaymentResponse('FAILURE', 'Application', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
            
            return null;
        }
    }
    
    // Method that is used to create pending Regulatory Transaction Fee Items related to a Parent record to store Payment Data
    public void createPendingRegTxnFeeItemsFromTransactionLogs(List<Transaction_Log__c> pendingTransactionLogs, String parentRecordId){
        List<RegulatoryTrxnFee> trxnFeesList = new List<RegulatoryTrxnFee>();
        List<RegulatoryTrxnFeeItem> rtxnFeeItemsList = new List<RegulatoryTrxnFeeItem>();
        Map<Id, RegulatoryTrxnFee> logIdToRTFMap = new Map<Id, RegulatoryTrxnFee>();
        
        // Create Regulatory Transaction Fee records, in a separate loop
        for(Transaction_Log__c log: pendingTransactionLogs){
            Map<String, Object> transactionResponseMap = (Map<String, Object>)JSON.deserializeUntyped(log.Transaction_Response__c);
        	String reqReferenceNumber;
        	if(transactionResponseMap.containsKey('req_reference_number'))
        	{
            reqReferenceNumber  = (String)transactionResponseMap.get('req_reference_number');
        	}
            RegulatoryTrxnFee rtxnFee = new RegulatoryTrxnFee(
                ParentRecordId = parentRecordId,
                Status = 'Paid',
                Application_Reference__c = paymentResponse.recordId,
                AccountId = [SELECT Id, AccountId FROM Contact WHERE Id=:paymentResponse.contactId LIMIT 1].AccountId,
                transaction_Id__c = log.Transaction_Id__c,
                Fee_Type__c = log.Payment_Type__c,
                Transaction_Response__c = log.Transaction_Response__c,
                Req_Reference_Number__c = reqReferenceNumber
            );
            
            logIdToRTFMap.put(log.Id, rtxnFee);
        }
        
        // Insert the Regulatory Transaction Fee records to get Ids
        if(logIdToRTFMap.size() > 0) {
            insert logIdToRTFMap.values();
        }
        
        // Now since we have the Ids, update the Logs and create associated Regulatory Transaction Fee Items
        for(Transaction_Log__c log: pendingTransactionLogs){
            if(logIdToRTFMap.containsKey(log.Id)) {
                log.Transaction_Fee_Created__c = true;
                log.Regulatory_Transaction_Fee__c = logIdToRTFMap.get(log.Id).Id;
                log.Response_Time__c = Datetime.now();
                log.Response_Status__c = params.get('decision');
            }
            
            if(log.Request_Details__c != null){
                List<FeeItem> ft;
                
                if (log.Request_Details__c.startsWith('[') && log.Request_Details__c.endsWith(']'))
                    ft = (List<FeeItem>) JSON.deserialize(log.Request_Details__c, List<FeeItem>.class);
                else
                    ft = (List<FeeItem>) JSON.deserialize('['+log.Request_Details__c+']', List<FeeItem>.class);
                
                for(FeeItem fItems : ft){
                    RegulatoryTrxnFeeItem rtxnFeeItem = new RegulatoryTrxnFeeItem();
                    rtxnFeeItem.RegulatoryTrxnFeeId = logIdToRTFMap.get(log.Id).Id;
                    rtxnFeeItem.FeeAmount = fItems.Amount;
                    rtxnFeeItem.Fee_Name__c = fItems.FeeType;
                    rtxnFeeItem.Account_Code__c = fItems.AccountCode;
                    rtxnFeeItem.Fund_Code__c = fItems.FundCode;
                    rtxnFeeItem.Department_Code__c = fItems.DepartmentCode;
                    rtxnFeeItem.Revenue_Code_Description__c = fItems.RevenueCode;
                    rtxnFeeItem.Name = log.Transaction_Id__c;
                    
                    rtxnFeeItemsList.add(rtxnFeeItem);
                }
            }
            
        }
        
        if(rtxnFeeItemsList.size() > 0){
            
            update pendingTransactionLogs;

            insert rtxnFeeItemsList;
        }   
    }
}