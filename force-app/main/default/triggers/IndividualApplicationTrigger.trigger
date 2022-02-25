trigger IndividualApplicationTrigger on IndividualApplication (after Insert) {
    List<Id> prevParentIds = new List<Id>();
    List<Id> newParentIds = new List<Id>(); 
    Map<Id, Id> prevToNewParentMap = new Map<Id, Id>();
    for(IndividualApplication ia: Trigger.New){
        if((ia.SavedApplicationRefId != null || ia.SavedApplicationRefId != '') && 
            (ia.RecordTypeId == '0125f000000uyOgAAI' || ia.RecordTypeId == '0125f000000uyOlAAI')){
                prevToNewParentMap.put(ia.SavedApplicationRefId, ia.Id);
                System.debug('PAR>>>'+ia.SavedApplicationRefId);
                System.debug('IA>>>>'+ia.Id);
        }
    }
    List<ContentDocumentLink> cdls = new List<ContentDocumentLink>([
            SELECT Id, LinkedEntityId, ContentDocumentId  FROM ContentDocumentLink Where LinkedEntityId =: prevToNewParentMap.keySet()
        ]);
        System.debug('cdlsSize>>>'+cdls.size());
        List<ContentDocumentLink> newCDLS = new List<ContentDocumentLink>();
        for(ContentDocumentLink cdl: cdls){
            //cdl.LinkedEntityId = prevToNewParentMap.get(cdl.LinkedEntityId);
            ContentDocumentLink newCDL = new ContentDocumentLink();
            newCDL.LinkedEntityId = prevToNewParentMap.get(cdl.LinkedEntityId);
            newCDL.ContentDocumentId = cdl.ContentDocumentId;
            newCDLS.add(newCDL);
        }
        if(newCDLS.size() > 0){
            System.debug('Records Available for update>>>>>'+newCDLS.size());
            insert newCDLS;
        }
            
}