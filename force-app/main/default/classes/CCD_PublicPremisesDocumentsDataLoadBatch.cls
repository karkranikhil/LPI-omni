global class CCD_PublicPremisesDocumentsDataLoadBatch implements Database.Batchable<sObject>, Schedulable {
        global Database.QueryLocator start(Database.BatchableContext context) {
            
            String query = 'SELECT Id FROM PreliminaryApplicationRef Where Authority__c = \'Cannabis\' and LicenseTypeId__r.Name != \'LNPP License Renewal\'';
            return Database.getQueryLocator(query);
        }    
    
        global void execute(Database.BatchableContext context, PreliminaryApplicationRef[] paf) {
            List<ContentDistribution> contentDistributionDoc = new List<ContentDistribution>();
            List<Public_Document__c> publicDocumentList = new List<Public_Document__c>();
            
            List<Schema.Location> premisesList = [SELECT Id, Preliminary_Application_Ref__c
                                                FROM Location 
                                                Where Preliminary_Application_Ref__c =: paf and LocationType = 'Premise'];
            List<Id> premisesIDList = new List<Id>();
            for(Schema.Location premise:premisesList){
                premisesIDList.add(premise.Id);
            }        
            
            List<ContentDocumentLink> cdl = [SELECT Id, LinkedEntityId, ContentDocumentId
                                            FROM ContentDocumentLink 
                                            Where LinkedEntityId =: premisesIDList];
            
            
            List<Id> cdID = new List<Id>();
            for(ContentDocumentLink c:cdl){
                //System.debug('$$$$'+c);
                cdID.add(c.ContentDocumentId);
            }
            
            List<ContentVersion> cvList = [SELECT Id, ContentDocumentId
                                        FROM ContentVersion 
                                        Where ContentDocumentId =: cdID];
            
            Map<Id,Id> docToLoc = new Map<Id,Id>();
            Map<Id,Id> locToPAR = new Map<Id,Id>();
            
            for(ContentDocumentLink clink:cdl){
                docToLoc.put(clink.ContentDocumentId,clink.LinkedEntityId);
            }
            
            for(Schema.Location loc:premisesList){
                locToPAR.put(loc.Id,loc.Preliminary_Application_Ref__c);
            }
            
            for(ContentVersion cv:cvList){
                ContentDistribution pdoc = new ContentDistribution();
                pdoc.Name = 'Manual';
                pdoc.ContentVersionId = cv.Id;
                //pdoc.ContentDocumentId = cv.ContentDocumentId;
                pdoc.PreferencesAllowViewInBrowser = true;
                pdoc.PreferencesNotifyOnVisit = false;
                pdoc.PreferencesAllowOriginalDownload = true;
                contentDistributionDoc.add(pdoc);
            }
            
            if(!contentDistributionDoc.isEmpty())
            {
              insert contentDistributionDoc;
            }
            
            List<ContentDistribution> allContentDistributionDoc = [SELECT Id, ContentDownloadUrl, DistributionPublicUrl, ContentDocumentId
                                                                    FROM ContentDistribution 
                                                                    Where ContentDocumentId =: cdID];
            
            for(ContentDistribution cd:allContentDistributionDoc){
                Public_Document__c pubDoc = new Public_Document__c();
                pubDoc.Content_Document_Id__c = cd.ContentDocumentId;
                pubDoc.Download_URL__c = cd.ContentDownloadUrl;
                pubDoc.Public_URL__c = cd.DistributionPublicUrl;
                pubDoc.Document_Type__c = 'Premises';
                pubDoc.Location__c = docToLoc.get(cd.ContentDocumentId);
                pubDoc.Preliminary_Application_Reference__c = locToPAR.get(pubDoc.Location__c);
                publicDocumentList.add(pubDoc);
            }
            
            if(!publicDocumentList.isEmpty())
            {
              insert publicDocumentList;
            }
            
            
            for(Public_Document__c pubDoc:publicDocumentList){
                System.debug('$$$$$$'+pubDoc.Preliminary_Application_Reference__c+' $$$$$$');
            }
        }

        global void finish(Database.BatchableContext context) {
            
        }

        global void execute(SchedulableContext SC) {
            Database.executebatch(new CCD_PublicPremisesDocumentsDataLoadBatch());
        }
    
}