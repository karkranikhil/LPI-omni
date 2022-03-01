public with sharing class LPI_ViewDocumentController {
   
    @AuraEnabled
    public static List<ContentVersion> fetchDocuments(String recordId){
        try {
            If(!String.isBlank(recordId)){
    
                List<ContentDocumentLink> contentDocumentList = [SELECT ContentDocumentId, LinkedEntityId 
                                                        FROM   ContentDocumentLink 
                                                        WHERE  LinkedEntityId = :recordId];
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
            else{
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }
}
