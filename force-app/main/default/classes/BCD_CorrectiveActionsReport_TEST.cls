@isTest
private with sharing class BCD_CorrectiveActionsReport_TEST {
    @testSetup
    private static void createInspectionData() {
        try{
            Account acc = BCD_TestUtility.createAccount('accName', false);
            acc.Mailing_Street_Address_2__c = 'testStreetAddress';
            insert acc;
            
            Contact con = BCD_TestUtility.createContact(true);
            RegulatoryAuthority regAut = BCD_TestUtility.createRegulatoryAuthority('Board of Barbers and Cosmetologists', true);
            RegulatoryAuthorizationType rat = BCD_TestUtility.createRegulatoryAuthorizationType('Establishment', regAut.Id, true);
            BusinessLicense bl = BCD_TestUtility.createBusinessLicense(con.Id, false);
            bl.PeriodStart = system.now();
            bl.PeriodEnd = system.now()+1;
            bl.AccountId = acc.Id;
            bl.RegulatoryAuthorizationTypeId = rat.Id;
            insert bl;
            
            Schema.Location loc = new Schema.Location(Name = 'test loc', LocationType='Physical Address');
            insert loc;
            
            Visit ins = new Visit(AccountId = acc.Id, Inspection_Result__c = 'fail', Status = 'Completed', PlannedVisitStartTime = DateTime.now().addMinutes(5), 
                                           VisitorId = UserInfo.getUserId(), License__c = bl.Id, PlaceId = loc.Id);
            insert ins;
            
            List<AssessmentTaskDefinition> atdList = new List<AssessmentTaskDefinition>();
            AssessmentTaskDefinition atd1 = new AssessmentTaskDefinition(Name = 'Licensee Questions', TaskType = 'InspectionChecklist');
            atdList.add(atd1);
            AssessmentTaskDefinition atd2 = new AssessmentTaskDefinition(Name = 'Licensee Signature', TaskType = 'Other');
            atdList.add(atd2);
            AssessmentTaskDefinition atd3 = new AssessmentTaskDefinition(Name = 'Inspector Signature', TaskType = 'Other');
            atdList.add(atd3);
            insert atdList;
            
            List<AssessmentTask> atList = new List<AssessmentTask>();
            AssessmentTask at1 = new AssessmentTask(Name = 'Licensee Questions', AssessmentTaskDefinitionId= atdList.get(0).Id, IsRequired = false, ParentId = ins.Id, SequenceNumber = 1, StartTime = DateTime.now().addMinutes(5), TaskType='InspectionChecklist');
            atList.add(at1);
            AssessmentTask at2 = new AssessmentTask(Name = 'Licensee Signature',  IsRequired = false, ParentId = ins.Id, SequenceNumber = 2, StartTime = DateTime.now().addMinutes(5), TaskType='SignatureTask');
            atList.add(at2);
            AssessmentTask at3 = new AssessmentTask(Name = 'Inspector Signature', IsRequired = false, ParentId = ins.Id, SequenceNumber = 3, StartTime = DateTime.now().addMinutes(5), TaskType='SignatureTask');
            atList.add(at3);
            insert atList;
                        
            List<SignatureTask> stList = new List<SignatureTask>();
            SignatureTask st1 = new SignatureTask (Name = 'Licensee Signature', ParentTaskId = atList.get(1).Id);
            SignatureTask st2 = new SignatureTask (Name = 'Inspector Signature', ParentTaskId = atList.get(2).Id);
            stList.add(st1);
            stList.add(st2);
            insert stList;
            
            List<SignatureTaskLineItem> stliList = new List<SignatureTaskLineItem>();
            SignatureTaskLineItem stli1 = new SignatureTaskLineItem (ParentId = stList.get(0).Id);
            SignatureTaskLineItem stli2 = new SignatureTaskLineItem (ParentId = stList.get(1).Id);
            stliList.add(stli1);
            stliList.add(stli2);
            insert stliList;
            
            DigitalSignature ds1 = new DigitalSignature(DocumentContentType='application/javascript', DocumentBody = Blob.valueOf('sdsd'), DocumentName = 'test', ParentId=stliList.get(0).Id);
            insert ds1;
            DigitalSignature ds2 = new DigitalSignature(DocumentContentType='application/javascript', DocumentBody = Blob.valueOf('sdsd'), DocumentName = 'test', ParentId=stliList.get(1).Id);
            insert ds2;
            
            AssessmentIndicatorDefinition  aid = new AssessmentIndicatorDefinition (Name = 'lol', DataType='String');
            insert aid;
            
            InspectionAssessmentInd iai = new InspectionAssessmentInd(AssessmentIndDefinitionId = aid.Id, AssessmentTaskId = at1.Id, result='Non Compliant', TextFieldResponse='lol');
            insert iai;
            
            RegulatoryCode rc = new RegulatoryCode(Name = 'test', RegulatoryAuthorityId = regAut.Id, EffectiveFrom = DateTime.now(), Subject = 'test');
            insert rc;
            
            RegulatoryCodeAssessmentInd rcai = new RegulatoryCodeAssessmentInd(RegulatoryCodeId = rc.Id, AssessmentIndDefinitionId = aid.Id);
            insert rcai;
            
            ViolationType vt = new ViolationType (Name = 'test', Type='Electrical', Severity='Minor Violation');
            insert vt;
            
            RegulatoryCodeViolation rcv = new RegulatoryCodeViolation(InspectionAssmntIndId = iai.Id, InspectionId = ins.Id, RegulatoryCodeId = rc.Id, ViolationTypeId = vt.Id, DateCreated = Date.Today());
            insert rcv;
            
        } catch(Exception e) {
            system.debug('Exception in createBoardMeetingData method : '+e.getStackTraceString()+'\n'+e.getLineNumber());
        }
    }
    
    private static testMethod void runInvocableBatch() {
        try{
            //get the inspection Id
            String inspectionId = [SELECT Id FROM Visit LIMIT 1].get(0).Id;
            Test.startTest();
                PageReference pageRef = Page.BCD_CorrectiveActionsReport;
                Test.setCurrentPage(pageRef);
                pageRef.getParameters().put('InspectionId', inspectionId);
                BCD_CorrectiveActionReportController obj = new BCD_CorrectiveActionReportController();
            	obj.saveAttachments();
            	//create the object again, for the same inspection
            	obj = new BCD_CorrectiveActionReportController();
            Test.stopTest();
        } catch(Exception e) {
            system.debug('Exception in runInvocableBatch method : '+e.getStackTraceString()+'\n'+e.getLineNumber()+'\n'+e.getCause()+'\n'+e.getMessage());
        }
    }
    
}