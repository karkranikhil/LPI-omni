trigger InvestigationCreatChild on Investigation__c (After Insert) {
    Map<Id,Id> idMap = new Map<Id,Id>();
    List< Date_of_Incidents__c> lstDate = new List< Date_of_Incidents__c>();
    List< Witness__c > lstWit = new List< Witness__c >();
    List< Attorney__c > lstAtt = new List< Attorney__c >();
    List< Agency__c > lstAg = new List< Agency__c >();
    List<ContentDocumentLink> lstContent = new List<ContentDocumentLink>();
    List<Note> lstNotes = new List<Note>();
   
    for(Investigation__c objIn : Trigger.new){
        idMap.put(objIn.Case__c,objIn.id);
    }
    for(Date_of_Incidents__c objDate : [Select Date__c, Case__c, Investigation__c from Date_of_Incidents__c where Case__c in : idMap.keySet()]){
        Date_of_Incidents__c objDateToInsert = objDate.clone(false);
        objDateToInsert.Case__c = null;
        objDateToInsert.Investigation__c = idMap.get(objDate.Case__c);
        lstDate.add(objDateToInsert);
    }
    if(!lstDate.isEmpty()){
        insert lstDate;
    }
    
    for(Witness__c objWitness : [Select Address__c, Case__c, Email__c, Investigation__c, Name,Phone__c  , Title__c from Witness__c where Case__c in : idMap.keySet()]){
        Witness__c objWitnessoInsert = objWitness.clone(false);
        objWitnessoInsert.Case__c = null;
        objWitnessoInsert.Investigation__c = idMap.get(objWitness.Case__c);
        lstWit.add(objWitnessoInsert);
    }
    if(!lstWit.isEmpty()){
        insert lstWit;
    }
    
    for(Attorney__c objAtt : [Select Address__c, Case__c, Email__c, Investigation__c, Name,Phone__c   from Attorney__c where Case__c in : idMap.keySet()]){
        Attorney__c objAttToInsert = objAtt.clone(false);
        objAttToInsert.Case__c = null;
        objAttToInsert.Investigation__c = idMap.get(objAtt.Case__c);
        lstAtt.add(objAttToInsert);
    }
    if(!lstAtt.isEmpty()){
        insert lstAtt;
    }
    
    for(Agency__c objAg : [Select Name, Case__c, Investigation__c, Contact_Name__c, Email__c,Phone__c from Agency__c where Case__c in : idMap.keySet()]){
        Agency__c objAgToInsert = objAg.clone(false);
        objAgToInsert.Case__c = null;
        objAgToInsert.Investigation__c = idMap.get(objAg.Case__c);
        lstAg.add(objAgToInsert);
    }
    if(!lstAg.isEmpty()){
        insert lstAg;
    }
    
    for(ContentDocumentLink objDoc : [SELECT ContentDocumentId,LinkedEntityId,ShareType,Visibility 
                                            FROM ContentDocumentLink 
                                            WHERE LinkedEntityId in : idMap.keySet()]){
        ContentDocumentLink objDocToInsert = objDoc.clone(false);
        objDocToInsert.ShareType = 'V';
        objDocToInsert.LinkedEntityId = idMap.get(objDoc.LinkedEntityId);
        lstContent.add(objDocToInsert);
    }
    if(!lstContent.isEmpty()){
        insert lstContent;
    }
    for (Note eachNote : [SELECT  Title, ParentId, body FROM Note where ParentId in : idMap.keySet()]){
        Note objNote = eachNote.clone(false);
        objNote.ParentId = idMap.get(eachNote.ParentId);
        lstNotes.add(objNote);
    }
    if(!lstNotes.isEmpty()){
        insert lstNotes;
    }
    
   

}