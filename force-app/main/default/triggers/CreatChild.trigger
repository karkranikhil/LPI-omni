trigger CreatChild on Date_of_Incidents__c (After Insert) {
    Map<Id,Id> idMap = new Map<Id,Id>();
    List< Date_of_Incidents__c> lstDate = new List< Date_of_Incidents__c>();
    List< Witness__c > lstWit = new List< Witness__c >();
    List< Attorney__c > lstAtt = new List< Attorney__c >();
    List< Agency__c > lstAg = new List< Agency__c >();
   
    for(Date_of_Incidents__c objIn : Trigger.new){
        idMap.put(objIn.id,objIn.Case__c);
    }
    for(Date_of_Incidents__c objDate : [Select Date__c, Case__c, Investigation__c from Date_of_Incidents__c where Case__c in : idMap.values()]){
        Date_of_Incidents__c objDateToInsert = objDate.clone(false);
        objDateToInsert.Case__c = null;
        objDateToInsert.Investigation__c = idMap.get(objDate.Investigation__c);
        lstDate.add(objDateToInsert);
    }
    if(!lstDate.isEmpty()){
        insert lstDate;
    }
    
    for(Witness__c objWitness : [Select Address__c, Case__c, Email__c, Investigation__c, Name,Phone__c  , Title__c from Witness__c where Case__c in : idMap.values()]){
        Witness__c objWitnessoInsert = objWitness.clone(false);
        objWitnessoInsert.Case__c = null;
        objWitnessoInsert.Investigation__c = idMap.get(objWitness.Investigation__c);
        lstWit.add(objWitnessoInsert);
    }
    if(!lstWit.isEmpty()){
        insert lstWit;
    }
    
    for(Attorney__c objAtt : [Select Address__c, Case__c, Email__c, Investigation__c, Name,Phone__c   from Attorney__c where Case__c in : idMap.values()]){
        Attorney__c objAttToInsert = objAtt.clone(false);
        objAttToInsert.Case__c = null;
        objAttToInsert.Investigation__c = idMap.get(objAtt.Investigation__c);
        lstAtt.add(objAttToInsert);
    }
    if(!lstAtt.isEmpty()){
        insert lstAtt;
    }
    
    for(Agency__c objAg : [Select Name, Case__c, Investigation__c, Contact_Name__c, Email__c,Phone__c from Agency__c where Case__c in : idMap.values()]){
        Agency__c objAgToInsert = objAg.clone(false);
        objAgToInsert.Case__c = null;
        objAgToInsert.Investigation__c = idMap.get(objAg.Investigation__c);
        lstAg.add(objAgToInsert);
    }
    if(!lstAg.isEmpty()){
        insert lstAg;
    }
    
   
    
   

}