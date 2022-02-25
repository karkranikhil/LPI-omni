public inherited sharing class MTXLPI_ProcessNewPayment {
	public class StatusResponse{
            public String Flags;
            public Date Flag_Applied_Date;
            public String Flag_Reason;
   	}    
    public static void processNewPayment(CyberSourceThankYouPageController cyberSource){
        try {
            StatusResponse sr = new StatusResponse();
            
            PreliminaryApplicationRef application = [SELECT Id, Authority__c, Status__c, Status_Reason__c, LicenseTypeId__c, Request_Type__c, LicenseTypeId__r.Name,
                                                     BusinessAccountNameId, LicenseTypeId__r.IssuingDepartment.ExternalId__c, LicenseStartDate__c, 
                                                     LicenseEndDate__c, Taken_And_Passed_NCE__c, Taken_And_Passed_NMF__c, Flags__c, Flag_Reason__c,
                                                     CEU_Completion__c,LicenseTypeId__r.External_Id__c,RecordType.DeveloperName
                                                     FROM PreliminaryApplicationRef 
                                                     WHERE Id =: cyberSource.paymentResponse.recordId];
            
            cyberSource.thankYouFlowType = 'newApplication';

            if(application.Authority__c  == 'Cannabis' &&  application.Status_Reason__c == 'Pending Application Payment'){
                cyberSource.processPendingPayment();
            } else{
                Case applicationCase = cyberSource.createCaseForApplicationIntake(application.LicenseTypeId__r.IssuingDepartment.ExternalId__c);
                
                IndividualApplication mainApplication = new IndividualApplication();
                if(application.Authority__c  == 'Cannabis'){
                    String recordTypeName = application.RecordType.DeveloperName;
                    mainApplication.RecordTypeId = Schema.SObjectType.IndividualApplication.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
                }
                else{
                    mainApplication.RecordTypeId = Schema.SObjectType.IndividualApplication.getRecordTypeInfosByDeveloperName().get('New_License').getRecordTypeId();
                }
                mainApplication.Category = 'License';
                mainApplication.ApplicationType = 'New';
                mainApplication.AppliedDate = System.now();
                mainApplication.Status = 'Submitted';
                if(application.LicenseTypeId__r.Name == 'Driver License')
                    mainApplication.RecordTypeId = '0125f000000uyOgAAI';    //forDriver License
                else if(application.LicenseTypeId__r.Name == 'Vehicle License')
                    mainApplication.RecordTypeId = '0125f000000uyOlAAI';    //for Vehicle License
                mainApplication.LicenseTypeId = application.LicenseTypeId__c;
                mainApplication.AccountId = application.BusinessAccountNameId;
                mainApplication.SavedApplicationRefId = application.Id;
                mainApplication.ApplicationCaseId = applicationCase.Id;
                mainApplication.LicenseStartDate__c = application.LicenseStartDate__c;
                mainApplication.LicenseEndDate__c = application.LicenseEndDate__c;
                
                /*if(application.LicenseTypeId__r.IssuingDepartment.ExternalId__c == 'Counseling' 
                   && (application.Taken_And_Passed_NCE__c == 'No' || application.Taken_And_Passed_NMF__c == 'No' 
                       || application.CEU_Completion__c == 'No')){
                           
                           sr = setResponseCounseling(application);
                           mainApplication.Flags__c = 'Hold';
                           mainApplication.Flag_Applied_Date__c = sr.Flag_Applied_Date;
                           mainApplication.Flag_Reason__c = sr.Flag_Reason;
                           	
                       }*/
                if(application.LicenseTypeId__r.IssuingDepartment.ExternalId__c == 'Counseling'&& 
                   application.Flags__c == 'Hold')
                {
                    mainApplication.Flags__c = 'Hold';
                    mainApplication.Flag_Applied_Date__c = System.today();
                    mainApplication.Flag_Reason__c = application.Flag_Reason__c;
                }
                if(application.LicenseTypeId__r.External_Id__c  == 'CPA' && application.Flags__c == 'Hold'){
                    mainApplication.Flags__c = 'Hold';
                    mainApplication.Flag_Applied_Date__c = System.today();
                    mainApplication.Flag_Reason__c = application.Flag_Reason__c;
                }
                
                insert mainApplication;

                // if(application.LicenseTypeId__r.Name == 'Driver License' ||
                // application.LicenseTypeId__r.Name == 'Vehicle License'){
                //     updateFilesParent(application.Id, mainApplication.Id);
                // }
                
                RegulatoryTrxnFee rtxnFee = cyberSource.createRegulatoryTrxnFee('Application Intake', mainApplication.Id, application.Id);
                
                List<Supervisor__c> supervisors = [SELECT Id, Status__c, Application_Reference__c
                                                   FROM Supervisor__c 
                                                   WHERE Status__c = 'Draft' AND Application_Reference__c =: cyberSource.paymentResponse.recordId];
                for(Supervisor__c s : supervisors){
                    s.Status__c = 'Pending'; 
                }
                update supervisors;
                
                List<RegulatoryTrxnFeeItem> rtxnFeeItemsList = cyberSource.createRegulatoryTrxnFeeItems('Application', rtxnFee.Id);
                
                Transaction_Log__c transactionLogRecord = cyberSource.createTransactionLogForPaymentResponse('SUCCESS', 'Application', rtxnFee.Id);
                if(transactionLogRecord == null) {
                    throw new VisualForceException( 'Invalid transaction.' );
                }
                
                List<Transaction_Log__c> pendingTransactionLogs = [SELECT Id, Amount__c, Transaction_Id__c, Payment_Type__c, Transaction_Response__c, 
                                                                   Application_Reference__c, Regulatory_Transaction_Fee__c, Transaction_Fee_Created__c, 
                                                                   Response_Status__c, Request_Details__c 
                                                                   FROM Transaction_Log__c 
                                                                   WHERE Application_Reference__c =: application.Id AND Regulatory_Transaction_Fee__c = null 
                                                                   AND Transaction_Fee_Created__c = false AND Transaction_Id__c != null 
                                                                   AND Response_Status__c != 'Invalid transaction.'];
                
                if(pendingTransactionLogs.size() > 0){
                    cyberSource.createPendingRegTxnFeeItemsFromTransactionLogs(pendingTransactionLogs, mainApplication.Id);
                }
                
            }
        } catch(Exception ex){
            System.debug('>>>>>>' + ex.getMessage());
            Transaction_Log__c transactionLogRecord = 
                cyberSource.createTransactionLogForPaymentResponse('FAILURE', 'Application', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        } 
    }
    public static StatusResponse setResponseCounseling(PreliminaryApplicationRef application){
        StatusResponse sr = new StatusResponse();
        sr.Flags = 'Hold';
		application.Flags__c = sr.Flags;
        sr.Flag_Applied_Date = System.today();
        if(application.Taken_And_Passed_NCE__c == 'No')
            sr.Flag_Reason = 'Has not passed NCE';
        else if(application.Taken_And_Passed_NMF__c == 'No')
            sr.Flag_Reason = 'Has not passed NMF';
        else if(application.CEU_Completion__c == 'No')
            sr.Flag_Reason = 'Continuing Education No';
        application.Flag_Reason__c = sr.Flag_Reason;
        return sr;
    }
    // public static void updateFilesParent(String prevParentId, String newParentId){
    //     List<ContentDocumentLink> cdls = new List<ContentDocumentLink>([
    //         SELECT Id, LinkedEntityId  FROM ContentDocumentLink Where LinkedEntityId =: prevParentId
    //     ]);
    //     List<ContentDocumentLink> newCDLS = new List<ContentDocumentLink>();
    //     for(ContentDocumentLink cdl: cdls){
    //         cdl.LinkedEntityId = newParentId;
    //         ContentDocumentLink newCDL = new ContentDocumentLink();
    //         newCDL.LinkedEntityId = newParentId;
    //         newCDL.ContentDocumentId = cdl.ContentDocumentId;
    //         newCDLS.add(newCDL);
    //     }
    //     if(newCDLS.size() > 0)
    //         insert newCDLS;
    // }
}