/* @Description - Class is used for processing renewal payments and auto approving the licenses
*                if the criteria matches.
*/
public inherited sharing class MTXLPI_ProcessRenewalPayment {
    public class StatusResponse{
        public String Status;
        public String StatusReason;
        public Boolean SystemApproved = false;
    }
    public static void processRenewalPayment(CyberSourceThankYouPageController cyberSource){
        
        try{
            StatusResponse sr = new StatusResponse();
            Integer totalScore = 0;
            IndividualApplication existingApplication = new IndividualApplication();
            Case applicationCase;
            IndividualApplication mainApplication;
            String licenseeFlag = '';
            String licenseeFlagReason = '';            
            PreliminaryApplicationRef application = [SELECT Id, LicenseTypeId__c, Request_Type__c,Flags__c,Flag_Reason__c, Audited__c, Status__c, BusinessAccountNameId, Business_License__c, LicenseTypeId__r.External_Id__c, LicenseTypeId__r.IssuingDepartment.ExternalId__c,
                                                     Licensee_Responsible_For_Requested_Info__c,Currently_Providing_Supervision__c,Disciplinary_Action_in_another_State__c, LicenseStartDate__c, LicenseEndDate__c,CEU_Completion__c,Business_License__r.Category__c,
                                                     Lost_Authorization_Practice__c,Revocation_due_to_disciplinary__c,Certificate_Canceled_Revoked_Suspended__c,Participated_in_conduct_adversely__c,Public_Accountancy__c,Own_Tax_Returns__c,
                                                     Registration_Type_Changed__c,Firm_Ownership__c,EXEMPT_From_Peer_Review__c,Compliance_Certification__c,Valid_CPA_License__c,Branch_Office__c,
                                                     (Select Id FROM IndividualApplicationAppRef LIMIT 1), Business_License__r.Name,Business_License__r.PeriodEnd, Business_License__r.Renewal_Expiry_Years__c,Business_License__r.Status,Client_Tax_Returns__c,Payment_to_be_made_by_Operating_Transfer__c
                                                     FROM PreliminaryApplicationRef
                                                     WHERE Id =: cyberSource.paymentResponse.recordId];
            
            List<Flag__c> flagsList  = [SELECT id, Account__c FROM Flag__c WHERE Account__c=:application.BusinessAccountNameId AND Flag_Release_Date__c = null LIMIT 1];
            
            for(IndividualApplication app : application.IndividualApplicationAppRef){
                existingApplication.Id = app.Id;
                existingApplication.Flags__c = '';
                existingApplication.Flag_Reason__c = ''; 
            }
            // Existing application is reopened due to Pending Applicant Payment( Prev opted for OPR). Now it has been paid via Online payment.
            if(existingApplication.Id !=null){
                if(application.Flags__c !=null){
                    existingApplication.Flags__c =  'Hold';
                    existingApplication.Flag_Applied_Date__c = System.today();
                    
                    if(String.isNotEmpty(application.Flag_Reason__c)){
                        existingApplication.Flag_Reason__c = application.Flag_Reason__c.removeEnd(',');    
                    }
                }
                // auto approval decision based on the boards
                if(application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Counseling'){
                    sr = setStatusCounseling(application, existingApplication, flagsList.isEmpty(), true);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Accountancy'){
                    sr = setStatusAccountancy(application,flagsList.isEmpty(),true);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Barbers & Cosmetologists'){
                    if (application.Business_License__c != null){
                        setBusinessLicense(application.Business_License__r.Name, application.Business_License__c, application.Business_License__r.PeriodEnd, Integer.valueOf(application.Business_License__r.Renewal_Expiry_Years__c));
                    }
                    sr = setStatusBnC(application,flagsList.isEmpty(),true);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Psychology'){
                    sr = setStatusPsychology(application,flagsList.isEmpty(),true);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Real Estate Commission'){
                    sr = setStatusREC(application,flagsList.isEmpty(),true);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Social Work'){
                    sr = setStatusSocialWork(application,true);
                }
                existingApplication.Status = sr.Status;
                existingApplication.System_Approved__c = sr.SystemApproved; 
                existingApplication.Status_Reason__c = sr.StatusReason;
                update existingApplication;
                
            }
            // new application logic
            else{
                applicationCase = cyberSource.createCaseForApplicationIntake(application.LicenseTypeId__r.IssuingDepartment.ExternalId__c);
                
                mainApplication = new IndividualApplication();
                mainApplication.RecordTypeId = Schema.SObjectType.IndividualApplication.getRecordTypeInfosByDeveloperName().get('Renew_License').getRecordTypeId();
                mainApplication.LicensePermitNameId = application.Business_License__c;
                mainApplication.Category = 'License';
                mainApplication.ApplicationType = 'Renewal';
                mainApplication.AppliedDate = System.now();
                mainApplication.LicenseTypeId = application.LicenseTypeId__c;
                mainApplication.AccountId = application.BusinessAccountNameId;
                mainApplication.SavedApplicationRefId = application.Id;
                mainApplication.ApplicationCaseId = applicationCase.Id;
                mainApplication.LicenseStartDate__c = application.LicenseStartDate__c;
                mainApplication.LicenseEndDate__c = application.LicenseEndDate__c;
                mainApplication.Flags__c = '';
                mainApplication.Flag_Reason__c = '';
                if(String.isNotEmpty(application.Flags__c)){
                    mainApplication.Flags__c = 'Hold';
                    mainApplication.Flag_Applied_Date__c = System.today();
                    
                    if(String.isNotEmpty(application.Flag_Reason__c)){
                        mainApplication.Flag_Reason__c = application.Flag_Reason__c.removeEnd(',');    
                    }
                }
                // auto approval decision based on the boards
                if(application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Counseling'){
                    sr = setStatusCounseling(application, mainApplication, flagsList.isEmpty(), false);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Accountancy'){
                    sr = setStatusAccountancy(application,flagsList.isEmpty(),false);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Barbers & Cosmetologists'){
                    if (application.Business_License__c != null){
                        setBusinessLicense(application.Business_License__r.Name, application.Business_License__c, application.Business_License__r.PeriodEnd, Integer.valueOf(application.Business_License__r.Renewal_Expiry_Years__c));
                    }
                    sr = setStatusBnC(application,flagsList.isEmpty(),false);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Psychology'){
                    sr = setStatusPsychology(application,flagsList.isEmpty(),false);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Real Estate Commission'){
                    sr = setStatusREC(application,flagsList.isEmpty(),false);
                }else if (application.LicenseTypeId__r.IssuingDepartment.ExternalId__c =='Social Work'){
                    sr = setStatusSocialWork(application,false);
                }
                
                mainApplication.Status = sr.Status;
                mainApplication.System_Approved__c = sr.SystemApproved;
                insert mainApplication;
            }
            
            RegulatoryTrxnFee rtxnFee = cyberSource.createRegulatoryTrxnFee('Application Intake', existingApplication.Id !=null ? existingApplication.Id : mainApplication.Id, application.Id);
            
            List<RegulatoryTrxnFeeItem> rtxnFeeItemsList = cyberSource.createRegulatoryTrxnFeeItems('Application', rtxnFee.Id);
            
            Transaction_Log__c transactionLogRecord = cyberSource.createTransactionLogForPaymentResponse('SUCCESS', 'Application', rtxnFee.Id);
            
            if(existingApplication.Id !=null){
                List<RegulatoryTrxnFee> existingOPRFee = [SELECT id,status,parentrecordid,operating_transfer__c FROM RegulatoryTrxnFee WHERE Operating_Transfer__c = true AND ParentRecordId =:existingApplication.Id AND Status = 'DUE'];
                if(existingOPRFee.size() > 0){
                    existingOPRFee[0].Comments = 'OPR is CANCELED as Licensee made Online Payment ';
                    existingOPRFee[0].Status = 'CANCELED';
                    update existingOPRFee[0];
                    
                }
            }
            
            if(transactionLogRecord == null){  
                throw new VisualForceException( 'Invalid transaction.' );
            } 
            
            List<Transaction_Log__c> pendingTransactionLogs = [SELECT Id, Amount__c, Transaction_Id__c, Payment_Type__c, Transaction_Response__c, Application_Reference__c, Regulatory_Transaction_Fee__c, Transaction_Fee_Created__c, Response_Status__c, Request_Details__c FROM Transaction_Log__c WHERE Application_Reference__c =: application.Id AND Regulatory_Transaction_Fee__c = null AND Transaction_Fee_Created__c = false AND Transaction_Id__c != null AND Response_Status__c != 'Invalid transaction.'];
            if(pendingTransactionLogs.size() > 0){
                cyberSource.createPendingRegTxnFeeItemsFromTransactionLogs(pendingTransactionLogs, existingApplication.Id !=null ? existingApplication.Id : mainApplication.Id);
            }
            
        } catch(Exception ex){
            Transaction_Log__c transactionLogRecord = cyberSource.createTransactionLogForPaymentResponse('FAILURE', 'Application', ex.getMessage() + ' with Stack Trace: ' + ex.getStackTraceString());
        }
        
        
    }
    
    /* @Description - Logic for auto approval of licenses based on the criteria matched. If not matched then submits the application.
*/
    public static StatusResponse setStatusCounseling(PreliminaryApplicationRef application, IndividualApplication existingApplication, Boolean isflagListEmpty, Boolean isExistingApplication){
        IndividualApplication individualApplication = new IndividualApplication();
        StatusResponse sr = new StatusResponse();
        if(String.isEmpty(application.Flags__c)
           && isflagListEmpty
           && application.Licensee_Responsible_For_Requested_Info__c == 'Yes' 
           && application.Disciplinary_Action_in_another_State__c == 'No'
           && (application.Currently_Providing_Supervision__c == 'Yes' || application.Currently_Providing_Supervision__c == 'No')
          ){
              if(application.Business_License__r.Category__c =='Continuing Education Provider' || (application.Business_License__r.Category__c !='Continuing Education Provider' && application.CEU_Completion__c =='Yes')){
                  sr.Status = 'Approved';
                  sr.SystemApproved = true; 
                  sr.StatusReason = '';
              }else{
                  sr.Status = 'Submitted';
                  sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';
              }
              
          }else{
              sr.Status = 'Submitted';
              sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';
          } 
        return sr;
    }
    public static StatusResponse setStatusAccountancy(PreliminaryApplicationRef application,Boolean isflagListEmpty, Boolean isExistingApplication){
        StatusResponse sr = new StatusResponse();
        
        if((application.LicenseTypeId__r.External_Id__c =='CPA' || application.LicenseTypeId__r.External_Id__c =='Registered Public Accountant') && String.isEmpty(application.Flags__c)
           && isflagListEmpty){
               sr.Status = 'Approved';
               sr.SystemApproved = true; 
               sr.StatusReason = '';
           }else if(application.LicenseTypeId__r.External_Id__c =='Firm Permit' && String.isEmpty(application.Flags__c)
                    && isflagListEmpty){
                        sr.Status = 'Approved';
                        sr.SystemApproved = true; 
                        sr.StatusReason = '';
                    }else{
                        sr.Status = 'Submitted';
                        sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';       
                    }
        
        return sr;
    }
    public static StatusResponse setStatusBnC(PreliminaryApplicationRef application,Boolean isflagListEmpty, Boolean isExistingApplication){
        StatusResponse sr = new StatusResponse();
        if(String.isEmpty(application.Flags__c) && isflagListEmpty){
            sr.Status = 'Approved';
            sr.SystemApproved = true; 
            sr.StatusReason = '';  
        }else{
            sr.Status = 'Submitted';
            sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';       
        }
        
        return sr;
    }
    public static StatusResponse setStatusPsychology(PreliminaryApplicationRef application,Boolean isflagListEmpty, Boolean isExistingApplication){
        StatusResponse sr = new StatusResponse();
        if(String.isEmpty(application.Flags__c) && isflagListEmpty){
            sr.Status = 'Approved';
            sr.SystemApproved = true; 
            sr.StatusReason = '';  
        }else{
            sr.Status = 'Submitted';
            sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';       
        }
        
        return sr;
    }
    public static StatusResponse setStatusREC(PreliminaryApplicationRef application,Boolean isflagListEmpty, Boolean isExistingApplication){
        StatusResponse sr = new StatusResponse();
        sr.Status = 'Submitted';
        sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';
        
        return sr;
    }
    public static StatusResponse setStatusSocialWork(PreliminaryApplicationRef application, Boolean isExistingApplication){
        StatusResponse sr = new StatusResponse();
        sr.Status = 'Submitted';
        sr.StatusReason = isExistingApplication ? 'Resubmission' : 'New Submission';
        return sr;
    }
    public static void setBusinessLicense(String LicenseNumber, Id LicenseId, Datetime PeriodEnd, Integer RenewalYears){
        Integer lastDigitOfLicense = Integer.valueOf(LicenseNumber.Substring(LicenseNumber.length()-1, LicenseNumber.length()));
        Integer RenewalYear = 0;
        Date firstStartDate = Date.newInstance(2021, 01, 01);
        Date firstEndDate = Date.newInstance(2021, 07, 31);
        Date secondStartDate = Date.newInstance(2022, 01, 01);
        Date secondEndDate = Date.newInstance(2022, 07, 31);
        Date PEndDate = Date.newInstance(PeriodEnd.year(), PeriodEnd.month(), PeriodEnd.day());
        if(lastDigitOfLicense == 0 || Math.mod(lastDigitOfLicense, 2) == 1){
            if((PEndDate >= firstStartDate && PEndDate <= firstEndDate) || (PEndDate >= secondStartDate && PEndDate <= secondEndDate)){
                RenewalYear = 0;   
            }
            else{
                RenewalYear = 1;
            }
        }        
        BusinessLicense License = new BusinessLicense();
        License.Id = LicenseId;
        License.Renewal_Years__c = RenewalYear ;
        update License;
    }
}