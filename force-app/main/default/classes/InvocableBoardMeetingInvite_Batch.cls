/**
* @description       : Invocable batch class to send emails to all board meeting members once a board meeting is approved
* @author            : Shobhit Pant
* @group             : 
* @last modified on  : 08-02-2021
* @last modified by  : Shobhit Pant
* Modifications Log 
* Ver   Date         Author            Modification
* 1.0   08-02-2021   Shobhit Pant   Initial Version
**/
public with sharing class InvocableBoardMeetingInvite_Batch  implements Database.Batchable<sObject>, Database.Stateful{
    
    //These are stateful variables, do not add large components here
    public Board_Meeting__c boardMeeting {get;set;}
    public Set<String> setOfContactId {get;set;}
    public String emailTemplateId {get;set;}
    
    //Invocable - to be invoked from BoardMeeting_AfterInsert_SendMeetingInvites
    @InvocableMethod(label='Send Board Meeting Invite')
    public static void sendMeetingInvite(List<Request> requestList) {
        
        //get email template to be used
        Id emailTempId;
        Board_meeting__c boardMeet;
        List<EmailTemplate> emailTemplateList = [Select Id from EmailTemplate where Name = 'Send Board Meeting Invite On Approval' LIMIT 1];
        if(emailTemplateList.size()>0) { //set email template id
            emailTempId = emailTemplateList.get(0).Id;
        }
        //get board meeting record
        String boardMeetingId = (String)requestList.get(0).recordId;
        if(!String.isBlank(boardMeetingId) ){
            boardMeet = [SELECT Id, Regulatory_Authority__c FROM Board_Meeting__c WHERE Id =: boardMeetingId].get(0);
        }
        if(emailTempId != null && boardMeet != null) {//execute the batch class
            Database.executeBatch(new InvocableBoardMeetingInvite_Batch(emailTempId, boardMeet), 600);
        } else {//email template not found/ record not found
            return;
        }
    }
    
    public InvocableBoardMeetingInvite_Batch(Id emailTemplateId, Board_Meeting__c boardMeeting) {
        this.emailTemplateId=emailTemplateId;
        this.boardMeeting=boardMeeting;
        this.setOfContactId = new Set<String>();
    }
    
    //Start Method - where the query happens
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String activeStatus = 'Active';
        String query = 'SELECT Id, ContactId, Contact.Email FROM BusinessLicense WHERE Status =: activeStatus'; 
        query += ' AND RegulatoryAuthorizationType.IssuingDepartmentId =\''+ boardMeeting.Regulatory_Authority__c+'\'';        
        return Database.getQueryLocator(query);
        
    }
    //Execute Method - the emails are sent from here
    public void execute(Database.BatchableContext bc, List<BusinessLicense> scope){
        
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{};
            try{
                for(BusinessLicense bl : scope) {
                    if(bl.ContactId != null && bl.Contact.Email != null && !setOfContactId.contains(bl.ContactId)) {
                        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                        message.setTargetObjectId(bl.ContactId);
                        message.setTemplateID(emailTemplateId); 
                        message.setWhatId(boardMeeting.Id); //This is important for the merge fields in template to work
                        message.toAddresses = new String[]{bl.Contact.Email};
                        setOfContactId.add(bl.ContactId);
                        messages.add(message);
                    }
                }
                if(messages.size()>0) {
                    Messaging.sendEmail(messages);
                }                
            } Catch (Exception e) {
                system.debug('Exception Occured While Sending Board Meeting Approval Emails: '+e.getStackTraceString()+'\n'+e.getCause());
            }
        
    }
    //Finish Method - no execution needed here
    public void finish(Database.BatchableContext bc){
    }
    
    public class Request {
        @InvocableVariable(required=true label='Board Meeting Record Id')
        public String recordId;
    }
}