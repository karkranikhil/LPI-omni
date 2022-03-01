public with sharing class LPI_ViewDocumentController {
   
    @AuraEnabled
    public static List<WrapperClass> fetchDocuments(String recordId){
        try {
            If(!String.isBlank(recordId)){

                List<Application_Document__c> lAD = new List<Application_Document__c>([SELECT Id,Document_Name__c FROM Application_Document__c WHERE Individual_Application__c = :recordId]);
                Set<Id> sAppDocId = new Set<Id>();
                Map<Id,String> mDocName = new Map<Id,String>();

                if(lAD.size() > 0){

                    for(Application_Document__c appDoc : lAD){
                        sAppDocId.add(appDoc.Id);
                        mDocName.put(appDoc.Id, appDoc.Document_Name__c);
                    }
                    List<ContentDocumentLink> contentDocumentList = [SELECT ContentDocumentId, LinkedEntityId 
                    FROM   ContentDocumentLink 
                    WHERE  LinkedEntityId IN :sAppDocId];

                    Set<Id> contentDocumentId = new Set<Id>();

                    Map<Id,String> mDocType = new Map<Id,String>();

                    for(ContentDocumentLink cdl : contentDocumentList){
                        contentDocumentId.add(cdl.ContentDocumentId);
                        mDocType.put(cdl.ContentDocumentId, mDocName.get(cdl.LinkedEntityId));
                    }

                    List<WrapperClass> lWC = new List<WrapperClass>();

                    for(ContentVersion cv : [SELECT Id, VersionData, FileType, Title, FileExtension,
                    ContentDocument.CreatedBy.Name, ContentDocument.ContentSize,
                    CreatedDate, ContentDocumentId, ContentDocument.FileType
                    FROM   ContentVersion 
                    WHERE  ContentDocumentId IN : contentDocumentId]){
                        WrapperClass wc = new WrapperClass();
                        wc.Id = cv.Id;
                        wc.Name = cv.Title;
                        wc.ExtType = cv.FileType;
                        wc.DocType = mDocType.get(cv.ContentDocumentId);
                        wc.ContentDocumentId = cv.ContentDocumentId;
                        lWC.add(wc);
                    }
                   
                    return lWC;
                } 
                return null;
            }
            else{
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    public class WrapperClass{

        @AuraEnabled
        public  String Id;

        @AuraEnabled
        public  String Name;

        @AuraEnabled
        public  String ExtType;

        @AuraEnabled
        public  String DocType;

        @AuraEnabled
        public  String ContentDocumentId;

        
    }
    
                       
}