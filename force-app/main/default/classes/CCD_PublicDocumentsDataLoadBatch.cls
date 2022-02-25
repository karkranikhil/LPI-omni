global class CCD_PublicDocumentsDataLoadBatch implements Database.Batchable<sObject>, Schedulable {
        global Database.QueryLocator start(Database.BatchableContext context) {
            
            String query = 'SELECT Id FROM PreliminaryApplicationRef Where Authority__c = \'Cannabis\' and LicenseTypeId__r.Name != \'LNPP License Renewal\'';
            return Database.getQueryLocator(query);
        }    
    
        global void execute(Database.BatchableContext context, PreliminaryApplicationRef[] paf) {
            List<ContentDistribution> contentDistributionDoc = new List<ContentDistribution>();
            List<ContentDocumentLink> cdl = new List<ContentDocumentLink>();
            List<Public_Document__c> publicDocumentList = new List<Public_Document__c>();
            
            List<Application_Document__c> appDocList = [SELECT Id, Application_Reference__c
                                                FROM Application_Document__c 
                                                Where Application_Reference__c =: paf];
            
            List<Id> newappdoclist = new List<Id>();
            for(Application_Document__c appdoc:appDocList){
             newappdoclist.add(appdoc.Id);		
            }
            
            cdl = [SELECT Id, LinkedEntityId, ContentDocumentId
                                            FROM ContentDocumentLink
                                            Where LinkedEntityId =: newappdoclist];
            //System.debug('$$$$'+cdl);
            
            List<Id> cdID = new List<Id>();
            
            for(ContentDocumentLink c:cdl){
                cdID.add(c.ContentDocumentId);
            }
            
            List<ContentVersion> cvList = [SELECT Id, ContentDocumentId
                                        FROM ContentVersion 
                                        Where ContentDocumentId =: cdID];
            
            Map<Id,Id> docToLoc = new Map<Id,Id>();
            Map<Id,Id> appdocToPAR = new Map<Id,Id>();
            
            for(ContentDocumentLink clink:cdl){
                docToLoc.put(clink.ContentDocumentId,clink.LinkedEntityId);
            }
            
            for(Application_Document__c appdoc:appDocList){
                appdocToPAR.put(appdoc.Id,appdoc.Application_Reference__c);
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
            System.Debug('$$$$'+contentDistributionDoc.size());
            if(!contentDistributionDoc.isEmpty())
            {
                System.debug('contentDistributionDoc >>>'+ contentDistributionDoc.size());
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
                pubDoc.Document_Type__c = 'Application';
                pubDoc.Preliminary_Application_Reference__c = appdocToPAR.get(docToLoc.get(cd.ContentDocumentId));
                publicDocumentList.add(pubDoc);
            }
            System.debug(publicDocumentList.size());
            if(!publicDocumentList.isEmpty())
            {
              insert publicDocumentList;
            }

        }

        global void finish(Database.BatchableContext context) {
            
        }

        global void execute(SchedulableContext SC) {
            Database.executebatch(new CCD_PublicDocumentsDataLoadBatch());
        }
    
}