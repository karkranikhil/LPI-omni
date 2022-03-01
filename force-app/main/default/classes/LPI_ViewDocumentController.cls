public with sharing class LPI_ViewDocumentController {
   
    @AuraEnabled
    public static List<ContentVersion> fetchDocuments(String recordId){
        try {
            If(!String.isBlank(recordId)){

                List<Application_Document__c> lAD = new List<Application_Document__c>([SELECT Id FROM Application_Document__c WHERE Individual_Application__c = :recordId]);
                Set<Id> sAppDocId = new Set<Id>();
                if(lAD.size() > 0){

                    for(Application_Document__c appDoc : lAD){
                        sAppDocId.add(appDoc.Id);
                    }
                    List<ContentDocumentLink> contentDocumentList = [SELECT ContentDocumentId, LinkedEntityId 
                    FROM   ContentDocumentLink 
                    WHERE  LinkedEntityId IN :sAppDocId];

                    Set<Id> contentDocumentId = new Set<Id>();

                    for(ContentDocumentLink cdl : contentDocumentList){
                    contentDocumentId.add(cdl.ContentDocumentId);
                    }

                    List<ContentVersion> contentVersionList = [SELECT Id, VersionData, FileType, Title, FileExtension,
                            ContentDocument.CreatedBy.Name, ContentDocument.ContentSize,
                            CreatedDate, ContentDocumentId, ContentDocument.FileType
                            FROM   ContentVersion 
                            WHERE  ContentDocumentId IN : contentDocumentId];
                    return contentVersionList;
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
                       
}