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
    List<Due_Diligence__c> to_insert = new List<Due_Diligence__c>();
    //List<Account> acctList = new List<Account>(); 
    for(IndividualApplication ia: Trigger.New){
        if(ia.RecordTypeId == '0125f000000uyOgAAI'){
            // create Driver
            Due_Diligence__c Rec1 = new Due_Diligence__c ();
            Rec1.Individual_Application__c = ia.Id;
            Rec1.Due_Diligence_Item_Name__c = 'Completed Application';
            Rec1.Status__c = 'Assigned';
            Due_Diligence__c Rec2 = new Due_Diligence__c ();
            Rec2.Individual_Application__c = ia.Id;
            Rec2.Due_Diligence_Item_Name__c = 'Uploaded supporting documents - License, Insurance';
            Rec2.Status__c = 'Assigned';
            Due_Diligence__c Rec3 = new Due_Diligence__c ();
            Rec3.Individual_Application__c = ia.Id;
            Rec3.Due_Diligence_Item_Name__c = 'Paid fees';
            Rec3.Status__c = 'Assigned';
            to_insert.add(Rec1);
            to_insert.add(Rec2);
            to_insert.add(Rec3);
            
        }
        if(ia.RecordTypeId == '0125f000000uyOlAAI'){
            // create vehicle Completed Application
            Due_Diligence__c Rec1 = new Due_Diligence__c ();
            Rec1.Individual_Application__c = ia.Id;
            Rec1.Due_Diligence_Item_Name__c = 'Completed Application';
            Rec1.Status__c = 'Assigned';
            Due_Diligence__c Rec2 = new Due_Diligence__c ();
            Rec2.Individual_Application__c = ia.Id;
            Rec2.Due_Diligence_Item_Name__c = 'Uploaded Supporting Document - License, Insurance, Registration';
            Rec2.Status__c = 'Assigned';
            Due_Diligence__c Rec3 = new Due_Diligence__c ();
            Rec3.Individual_Application__c = ia.Id;
            Rec3.Due_Diligence_Item_Name__c = 'Inspection Completed';
            Rec3.Status__c = 'Assigned';
            Due_Diligence__c Rec4 = new Due_Diligence__c ();
            Rec4.Individual_Application__c = ia.Id;
            Rec4.Due_Diligence_Item_Name__c = 'Paid Fees';
            Rec4.Status__c = 'Assigned';
            to_insert.add(Rec1);
            to_insert.add(Rec2);
            to_insert.add(Rec3);
            to_insert.add(Rec4);
        }
    }
    if(to_insert.size() > 0){
        System.debug('Size of List ' + to_insert.size());
        insert to_insert;
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