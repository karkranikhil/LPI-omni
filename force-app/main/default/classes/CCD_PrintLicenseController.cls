public with sharing class CCD_PrintLicenseController {
    public string recordId;
    public BusinessLicense bLicense{get;set;}
    public Schema.Address address{get;set;}
    public boolean isRelatedToVice{get; set;}
    public string className{get; set;}
    
    String isSave;
     
    public string startDate{get;set;}
    public string endDate{get;set;}
    
    public CCD_PrintLicenseController(){
        
        recordId = ApexPages.currentPage().getParameters().get('Id');
        isSave = ApexPages.currentPage().getParameters().get('dosavethepdf');
        isRelatedToVice = false;
        
        bLicense = [Select id,RecordTypeId,RecordType.DeveloperName, License_Type__c,Parent_Business_License__c,Name,AccountId,
                    RegulatoryAuthorizationType.Name,PeriodStart , PeriodEnd,
                    RegulatoryAuthorizationType.IssuingDepartment.Name,Trade_Name__c
                    from BusinessLicense Where id =: recordId ];
        //recordTypeId = RecordType.DeveloperName; //Schema.SObjectType.BusinessLicense.getRecordTypeInfosByDeveloperName().get('Vice_License').getRecordTypeId();
        
        BusinessLicense subLicense = new BusinessLicense();
        List<id> bList = new List<id>();
        bList.add(recordId);
        
        system.debug('mtx1 Record type:'+bLicense.RecordType.DeveloperName +'--License Type: '+bLicense.License_Type__c+' --Parent: '+bLicense.Parent_Business_License__c);
        if(bLicense.Parent_Business_License__c != null){
            system.debug('mtx1 check1:');
            subLicense =   [Select id,Name,RecordTypeId,RecordType.DeveloperName,Parent_Business_License__c,
                                             Parent_Business_License__r.RecordType.DeveloperName
                                             from BusinessLicense Where id =: bLicense.Parent_Business_License__c LIMIT 1];
            recordId = subLicense.id;
            if(subLicense.RecordType.DeveloperName == 'Vice_License' || (subLicense.Parent_Business_License__c != null && subLicense.Parent_Business_License__r.RecordType.DeveloperName=='Vice_License')){
                isRelatedToVice = true;
            }
            
        }else if(bLicense.RecordType.DeveloperName == 'Vice_License'){
            isRelatedToVice = true;
            system.debug('mtx1 check2:');
            
            subLicense = [Select id,Name,RecordTypeId,RecordType.DeveloperName,Parent_Business_License__c,
                                             Parent_Business_License__r.RecordType.DeveloperName
                                             from BusinessLicense Where Parent_Business_License__c =: bLicense.Id LIMIT 1];
         }
         
         if(subLicense!= null){
             system.debug('mtx1 check2:'+subLicense.Name);
             bList.add(subLicense.Id);
         }
        
        if(bLicense == null || bLicense.AccountId == null) {
            return;
        }
        PreliminaryApplicationRef pApplication;
        Schema.Location location;
        
        system.debug('mtx1 isRelatedToVice:'+isRelatedToVice);
        if(isRelatedToVice){
            pApplication = [Select id,Is_Physical_Address_Different__c, Firm_Name__c, Business_Information__c, Manufacturer_License_Type__c
                                from PreliminaryApplicationRef 
                                where Business_License__c in :bList AND Business_Information__c != NULL limit 1];
                    
                     if(pApplication.Is_Physical_Address_Different__c){
                                                   
                            location = [SELECT id
                               FROM Location 
                               WHERE Business_Information__c =: pApplication.Business_Information__c 
                               and LocationType = 'Mailing' limit 1];
                
                            address = [SELECT id, Street, Street_2__c, City, 
                               State, LocationType, PostalCode 
                               FROM Address 
                               WHERE ParentId =: location.id 
                               and LocationType = 'Mailing' limit 1];
                      } else{
            
                            location = [SELECT id
                                       FROM Location 
                                       WHERE Business_Information__c =: pApplication.Business_Information__c
                                       and LocationType = 'Physical' limit 1];
                            
                            address = [SELECT id, Street, Street_2__c, City, 
                                       State, LocationType, PostalCode 
                                       FROM Address 
                                       WHERE ParentId =: location.id 
                                       and LocationType = 'Physical' limit 1];
                      }
        
        }else{
        
        pApplication = [Select id,Is_Physical_Address_Different__c, Firm_Name__c, Manufacturer_License_Type__c
                        from PreliminaryApplicationRef 
                        where Business_License__c =: recordId];
        
        
        
        if(pApplication.Is_Physical_Address_Different__c){
            
            location = [SELECT id
                       FROM Location 
                       WHERE Preliminary_Application_Ref__c =: pApplication.id 
                       and LocationType = 'Mailing' limit 1];
                
            address = [SELECT id, Street, Street_2__c, City, 
                       State, LocationType, PostalCode 
                       FROM Address 
                       WHERE ParentId =: location.id 
                       and LocationType = 'Mailing' limit 1];
        }else{
            
            location = [SELECT id
                       FROM Location 
                       WHERE Preliminary_Application_Ref__c =: pApplication.id 
                       and LocationType = 'Physical' limit 1];
            
            address = [SELECT id, Street, Street_2__c, City, 
                       State, LocationType, PostalCode 
                       FROM Address 
                       WHERE ParentId =: location.id 
                       and LocationType = 'Physical' limit 1];
        }
        
        
        }
        if(address != null){
            address.Street = !String.isEmpty(address.Street)?address.Street+',':'';
            address.Street_2__c = !String.isEmpty(address.Street_2__c)?address.Street_2__c+',':'';
            address.City = !String.isEmpty(address.City)?address.City+',':'';
            address.State = !String.isEmpty(address.State)?address.State+',':'';
            address.PostalCode = !String.isEmpty(address.PostalCode)?address.PostalCode+'':'';
        }
        if(bLicense.RegulatoryAuthorizationType.Name =='Cannabis Manufacturer')
                 className = pApplication.Manufacturer_License_Type__c;
        else
                 className = '';
        
        if(bLicense.PeriodStart != null) {
            startDate = bLicense.PeriodStart.format('MM/dd/yyyy','America/Los_Angeles');
        }
        if(bLicense.PeriodEnd != null) {
            endDate = bLicense.PeriodEnd.format('MM/dd/yyyy','America/Los_Angeles');
        }
        
        if(bLicense.RegulatoryAuthorizationType.Name == 'LNPP License Renewal') {
            bLicense.Trade_Name__c = pApplication.Firm_Name__c;
        }
            
        String myGeneratedFileName = bLicense.Name; 
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+myGeneratedFileName+'.pdf');
        Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename='+myGeneratedFileName+'.pdf');
    }
    
    public void initInternal(){
        initHelper('Internal');
    }

    public void initExternal(){
        initHelper('External');
    }

    private void initHelper(String flow){
        if( isSave == null ){
            //Step 1: Delete documents from the same day and from the same users
            List<ContentDocument> dd_Del = new List<ContentDocument>();
            
            for( ContentDocumentLink cDoc : [SELECT id,ContentDocumentId FROM ContentDocumentLink 
                                           Where LinkedEntityId =: recordId 
                                           AND ContentDocument.CreatedDate = Today
                                             AND ContentDocument.OwnerId =: UserInfo.getUserId()
                                            And ContentDocument.Title LIKE: '%'+ flow +'%'] ){
                dd_Del.add( new ContentDocument(Id = cDoc.ContentDocumentId ) );
                                                 
            }
            
            if( !dd_Del.isEmpty() ){
                delete dd_Del;
            }
            
            //Step 2: Create Content Document
            
            //A: Generate PDF from VF
            PageReference pagePdf; 
            if(flow == 'Internal'){
                pagePdf = Page.CCD_PrintLicenseInternal; 
            } else {
                pagePdf = Page.CCD_PrintLicenseExternal; 
            }
            pagePdf.getParameters().put('Id', bLicense.Id); 
            pagePdf.getParameters().put('dosavethepdf', 'yes'); 
            
            //B: Creating ContentVersion
            ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
            cVersion.PathOnClient = flow+'_License_' + bLicense.Name+ '.pdf';//File name with extention
            cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
            cVersion.Title = flow+'_License_' + bLicense.Name+ '.pdf';//Name of the file
            cVersion.VersionData = Test.isRunningTest() ? Blob.valueOf('UNIT.TEST') : pagePdf.getContentAsPdf();//File content
            insert cVersion;
            
            //C: Create Content Document Link
            ContentVersion cVer = [SELECT ContentDocumentId,VersionData FROM ContentVersion WHERE Id = :cVersion.Id];
            
            ContentDocumentLink cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = cVer.ContentDocumentId;//Add ContentDocumentId
            cDocLink.LinkedEntityId = recordId;//Add attachment parentId
            cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
            insert cDocLink;
        }
    }
}