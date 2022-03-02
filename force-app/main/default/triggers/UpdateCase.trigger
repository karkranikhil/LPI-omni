trigger UpdateCase on vlocity_ins__OmniScriptInstance__c (After insert, After update) {
    if(Trigger.isAfter && Trigger.isInsert){
        Map<Id,String> mapCase = new Map<Id,String>();
    List<Case> lstCase = new List<Case>();
    
                system.debug('======= Here I am  ');

    for (vlocity_ins__OmniScriptInstance__c instance : trigger.New){
        system.debug(' 1 ======= instance.vlocity_ins__ObjectId__c '+instance.vlocity_ins__ObjectId__c);

        if(instance.vlocity_ins__ObjectId__c != null && (instance.vlocity_ins__ObjectId__c.startsWith('500') )){
            system.debug('======= instance.vlocity_ins__ObjectId__c '+instance.vlocity_ins__ObjectId__c);
            mapCase.put(instance.vlocity_ins__ObjectId__c,instance.vlocity_ins__ResumeLink__c);
        }
    }
    if(!mapCase.isEmpty()){
        for(Id iterateIds : mapCase.keySet()){
            String iterateIdSting = String.valueOf(iterateIds);
            if(iterateIdSting.startsWith('500')){
                lstCase.add(new Case(id=iterateIds, Resume_Link__c=mapCase.get(iterateIds)));
            }else {
                    system.debug('MapCase>>>>'+mapCase.get(iterateIds));
                    system.debug('Map>>>>'+mapCase);
                //lstApp.add(new PreliminaryApplicationRef (id=iterateIds, SavedApplicationUrl =mapCase.get(iterateIds)));
            }
            
        }
    }
    
    if(! lstCase.isEmpty()){
        system.debug('=========. lstCase '+lstCase);
        update lstCase;
    }
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        Map<Id,String> mapApp = new Map<Id,String>();
        List<PreliminaryApplicationRef> lstApp = new List<PreliminaryApplicationRef>();
        for(vlocity_ins__OmniScriptInstance__c instance: trigger.New){
            if(instance.vlocity_ins__ObjectId__c != null && instance.vlocity_ins__ObjectId__c.startsWith('0go5')){
                mapApp.put(instance.vlocity_ins__ObjectId__c, instance.vlocity_ins__ResumeLink__c);
            }
        }
        if(!mapApp.isEmpty()){
            for(Id iteradeId: mapApp.keySet()){
                String parId = String.valueOf(iteradeId);
                lstApp.add(new PreliminaryApplicationRef(Id = iteradeId, SavedApplicationUrl = mapApp.get(iteradeId)));
            }
        }
        if(!lstApp.isEmpty()){
            update lstApp;
        }
    }

}