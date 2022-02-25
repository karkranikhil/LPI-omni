public class BCD_CorrectiveActionReportController {
    public Visit inspection{get; set;}
    public List<ChecklistCategoryWrapper> correctiveActionsList{get;set;}
    public List<ViolationsWrapper> regulatoryCodeViolationsList{get;set;}
    public InfoWrapper infoWrapper{get;set;}
    public List<Attachment> attachmentList;
    public Boolean inspectionCompleted {get;set;}
    
    public BCD_CorrectiveActionReportController(){
        String inspectionId = apexpages.currentpage().getparameters().get('InspectionId');
        infoWrapper = new InfoWrapper();
        
        inspection = [SELECT Id, ActualVisitStartTime, Status, Inspection_Result__c, License__c, StatusRemarks
                      , (SELECT Id, Name FROM Attachments)
                      , License__r.Name, License__r.Trade_Name__c, License__r.RegulatoryAuthorizationType.Name, License__r.RegulatoryAuthorizationType.IssuingDepartment.Name
                      , Account.Name, Account.PersonMailingStreet, Account.Mailing_Street_Address_2__c, Account.PersonMailingCity, Account.PersonMailingState, Account.PersonMailingPostalCode 
                      FROM Visit WHERE Id =: inspectionId LIMIT 1].get(0);
        
        if(inspection.Status != 'Completed') {
            inspectionCompleted = false;
        } else {
            inspectionCompleted = true;
        }
        String formattedAddress1='';
        String formattedAddress2='';
        //Set the address of the firm
        if(inspection != null && inspection.Account != null) {
            formattedAddress1 = inspection.Account.PersonMailingStreet;
            if(!String.isBlank(inspection.Account.PersonMailingStreet)) {
                formattedAddress1+=', '+inspection.Account.Mailing_Street_Address_2__c+',';
            } else {
                formattedAddress1+=inspection.Account.Mailing_Street_Address_2__c+',';
            }
            formattedAddress2 = inspection.Account.PersonMailingCity;
            if(!String.isBlank(inspection.Account.PersonMailingCity)) {
                formattedAddress2+=', '+inspection.Account.PersonMailingPostalCode;
            } else {
                formattedAddress2+=+inspection.Account.PersonMailingPostalCode;
            }
        }
       
        infoWrapper.formattedAddress1 = formattedAddress1.replaceAll('null', '');
        infoWrapper.formattedAddress2 = formattedAddress2.replaceAll('null', '');
        
      
        
        //Get the child Assessment Tasks
        correctiveActionsList = new List<ChecklistCategoryWrapper>();
        List<AssessmentTask> inspectionChecklist = new List<AssessmentTask>();
        Set<String> signatureTaskSet = new Set<String>();
        Map<String, String> atToSignatureItemMap = new Map<String, String>();
        attachmentList = new List<Attachment>();
        List<InspectionAssessmentInd > temporaryList = new List<InspectionAssessmentInd >();
        Map<String, String> AssessmentIndDefinitionToRegulatoryCodeNameMap = new Map<String, String>();
        
        //Check if attachments already exist for the given inspection record
        if(inspection.Attachments.size()>0) {
            for(Attachment att : inspection.Attachments) {
                if(att.Name.startsWith('Inspector Signature')){
                    infoWrapper.InspectorSignature = att.Id;
                }else If(att.Name.startsWith('Licensee Signature')){
                    infoWrapper.LicenseeSignature = att.Id;
                }
            }
        }
        
        for(AssessmentTask at : [SELECT Id, Name, (SELECT AssessmentIndDefinitionId, AssessmentIndDefinition.Name, TextFieldResponse, Result FROM InspectionAssessmentIndicators), TaskType FROM AssessmentTask WHERE ParentId =: inspectionId ORDER BY SequenceNumber  ASC]) {
            if(at.TaskType == 'InspectionChecklist') {
                inspectionChecklist.add(at);
                temporaryList.addAll(at.InspectionAssessmentIndicators);
            } else if (at.TaskType == 'SignatureTask') {
                signatureTaskSet.add(at.Id);
            }
        }
        for(InspectionAssessmentInd iai : temporaryList) {
            AssessmentIndDefinitionToRegulatoryCodeNameMap.put(iai.AssessmentIndDefinitionId, null);
        }
        for(RegulatoryCodeAssessmentInd rcai : [SELECT Id, RegulatoryCode.Name, AssessmentIndDefinitionId FROM RegulatoryCodeAssessmentInd WHERE AssessmentIndDefinitionId IN : AssessmentIndDefinitionToRegulatoryCodeNameMap.keySet()]) {
            AssessmentIndDefinitionToRegulatoryCodeNameMap.put(rcai.AssessmentIndDefinitionId, rcai.RegulatoryCode.Name);
        }
        
        //handle the signature items
        if(infoWrapper.InspectorSignature == null || infoWrapper.LicenseeSignature == null) {
            //get all Signture Task Record
            for(SignatureTask st : [SELECT ParentTask.Name, Id, Name, (Select Id, Name FROM SignatureTaskLineItemParentValue) FROM SignatureTask WHERE ParentTaskId IN : signatureTaskSet]) {
                if(st.SignatureTaskLineItemParentValue.size()>0) {
                    atToSignatureItemMap.put(String.valueOf(st.SignatureTaskLineItemParentValue.get(0).Id), st.ParentTask.Name);
                }
            }
            for(DigitalSignature ds : [Select DocumentBody, ParentId FROM DigitalSignature where ParentId IN : atToSignatureItemMap.keyset()]) {
                Attachment att=new Attachment();
                att.Body= ds.DocumentBody;
                att.Name= atToSignatureItemMap.get(ds.ParentId) + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.jpg';
                att.parentId=inspection.Id;
                attachmentList.add(att);
            }
            
        }
        
        //Handle the checklist items
        Integer counter = 1;
        for(AssessmentTask at : inspectionChecklist) {
            List<ChecklistWrapper> childWrapperList = new List<ChecklistWrapper>();
            for(InspectionAssessmentInd iai : at.InspectionAssessmentIndicators) {
                ChecklistWrapper childWrapper = new ChecklistWrapper();
                childWrapper.itemName = Counter+') '+iai.AssessmentIndDefinition.Name;
                if(AssessmentIndDefinitionToRegulatoryCodeNameMap.containsKey(iai.AssessmentIndDefinitionId) && AssessmentIndDefinitionToRegulatoryCodeNameMap.get(iai.AssessmentIndDefinitionId) != null) {
                    childWrapper.itemName += ' - '+AssessmentIndDefinitionToRegulatoryCodeNameMap.get(iai.AssessmentIndDefinitionId);
                }
                childWrapper.textFieldResponse = iai.TextFieldResponse;
                childWrapper.result = iai.Result;
                childWrapperList.add(childWrapper);
                counter++;
            }
            ChecklistCategoryWrapper parentWrapper = new ChecklistCategoryWrapper();
            parentWrapper.checklistWrapperList = childWrapperList;
            parentWrapper.categoryName = at.Name;
            correctiveActionsList.add(parentWrapper);
        }
        //Get the child violation records
        regulatoryCodeViolationsList = new List<ViolationsWrapper>();
        for(RegulatoryCodeViolation  rcv : [SELECT Id, RegulatoryCode.Name, InspectionAssmntInd.TextFieldResponse FROM RegulatoryCodeViolation WHERE InspectionId =: inspectionId AND RegulatoryCodeId != null]){
            ViolationsWrapper vw = new ViolationsWrapper();
            vw.itemCode = 'Violation of '+rcv.RegulatoryCode.Name;
            vw.remarks = rcv.InspectionAssmntInd.TextFieldResponse;
            regulatoryCodeViolationsList.add(vw);
        }
    }
    
    //save the attachments (called from VF action)
    public PageReference saveAttachments(){
        if(attachmentList.size()>0) {
            insert attachmentList;
            for(Attachment att : attachmentList) {
                if(att.Name.startsWith('Inspector Signature')){
                    infoWrapper.InspectorSignature = att.Id;
                }else If(att.Name.startsWith('Licensee Signature')){
                    infoWrapper.LicenseeSignature = att.Id;
                }
            }
        }
        return null;
    }
    
    public class ChecklistCategoryWrapper{
        public String categoryName{get;set;}
        public List<ChecklistWrapper> checklistWrapperList{get;set;}
    }
    public class ChecklistWrapper{
        public String regulatoryCodeName {get;set;}
        public String itemName {get;set;}
        public String textFieldResponse {get;set;}
        public String result {get;set;}
    }
    public class ViolationsWrapper{
        public String itemCode {get;set;}
        public String remarks {get;set;}
    }
    public class InfoWrapper{
        public String formattedAddress1{get;set;}
        public String formattedAddress2{get;set;}
        public String InspectorSignature{get;set;}
        public String LicenseeSignature{get;set;}
    }
}