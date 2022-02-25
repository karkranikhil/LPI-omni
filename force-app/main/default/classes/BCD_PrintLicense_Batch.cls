/**
* @description       : Batch class to print multiple licenses together
* @author            : Shobhit Pant
* @group             : MTX Ltd.
* @last modified on  : 08-25-2021
* @last modified by  : Shobhit Pant
* Modifications Log
* Ver   Date         Author            Modification
* 1.0   09-20-2021   Shobhit Pant   Initial Version
**************************************************************
How to run: Run the following snippet in Execute Anonymous 
String query = 'SELECT Id, LicensePermitNameId, LicensePermitName.Last_Printed_On__c FROM IndividualApplication WHERE CreatedDate > 2021-01-01T00:00:00-06:00 AND CreatedDate < 2021-12-31T23:59:59-06:00';
query += ' AND LicenseType.IssuingDepartmentId = \'19pr00000004C99AAE\' AND  Status = \'Approved\'  AND LicensePermitName.Last_Printed_On__c = null ORDER BY CreatedDate ASC';
String targetId = '001r000000arOrbAAE';
BCD_PrintLicense_Batch obj = new BCD_PrintLicense_Batch(query, targetId);
Database.executeBatch(obj, 100);
***************************************************************
**/
public class BCD_PrintLicense_Batch implements Database.Batchable<sObject>, Database.Stateful {
   
    //Global, Stateful vairables
    public Integer pageCounter = 1;
    public Integer recordsProcessed = 0;
    String queryString;
    String targetRecordId;
    @InvocableMethod(label='Invoke Print License')
    public static void invokePrintLicenseBatch(List<Id> licensePrintIdList) {
        
        List<License_Print_Request__c> licensePrintList =  [SELECT Id,Print_Type__c,Application_Created_Start_Date__c,Application_Created_End_Date__c,
                                                            Application_Status__c, License__c, Regulatory_Authority__c,License_Status__c,Application_Type__c
                                                            FROM License_Print_Request__c
                                                            WHERE Id=: licensePrintIdList[0]];
        
        String sd =  licensePrintList[0].Application_Created_Start_Date__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        String ed =  licensePrintList[0].Application_Created_End_Date__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        
        String query= 'SELECT Id, LicensePermitNameId, LicensePermitName.Last_Printed_On__c FROM IndividualApplication WHERE CreatedDate >='+ sd+' AND CreatedDate <='+ ed ;
        query += 'AND LicensePermitName.Status =\''+licensePrintList[0].License_Status__c + '\'  AND LicenseType.IssuingDepartmentId =\''+ licensePrintList[0].Regulatory_Authority__c + '\' AND  Status =\''+ licensePrintList[0].Application_Status__c +'\'';
        if(licensePrintList[0].Print_Type__c =='New Only'){
            query += '  AND Last_License_Printed_On__c = null';
        }
        if(licensePrintList[0].License__c !=null){
            query += '  AND LicenseTypeId =\''+ licensePrintList[0].License__c + '\'';
        }
        if(licensePrintList[0].Application_Type__c != null) {
            query += ' AND ApplicationType =\''+ licensePrintList[0].Application_Type__c+'\''; 
        }
        query +=' ORDER BY CreatedDate ASC';  
        
        String targetId = licensePrintIdList.get(0);
        BCD_PrintLicense_Batch obj = new BCD_PrintLicense_Batch(query, targetId);
        System.debug('query here ----'+ query);
        Database.executeBatch(obj, 100); 
    }
   /**
   * Public constructor, to be called from execute anonymous window
   * @param String queryString - the query that will be run in the start method
   * @param String targetRecordId  - set the target record Id, where the pdf will be saved
   */
    public BCD_PrintLicense_Batch(String queryString, String targetRecordId) {
        this.queryString = queryString;
        this.targetRecordId = targetRecordId;
    }
    /**
   * Batch start method
   * This is where the scope is generated from passed query
   * @param Database.BatchableContext bc - standard 
   * @return Database.QueryLocator - scope (IndividualApplication)
   */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(queryString);
    }
    /**
   * Batch execute method
   * This is where the multiple pdfs are generated from
   * @param Database.BatchableContext bc - standard 
   * @param List<IndividualApplication> scope - the IA records 
   * @return void
   */
    public void execute(Database.BatchableContext bc, List<IndividualApplication> scope){
        String IdString = '';
        List<BusinessLicense> licensesToUpdate = new List<BusinessLicense>();
        Set<String> uniqueIdSet = new Set<String>();
        
        for(IndividualApplication ia : scope) {
            if(ia.LicensePermitNameId == null) {
                continue;
            }
            IdString += ia.LicensePermitNameId+',';
            ia.Last_License_Printed_On__c = DateTime.now();
            this.recordsProcessed++;
        }
        
        IdString = IdString.removeEnd(',');

        Pagereference pagePdf = Page.BCD_PrintLicenseInternal;
        pagePdf.getParameters().put('Id', IdString);
        pagePdf.getParameters().put('dosavethepdf', 'yes');
       
        //B: Creating ContentVersion
        ContentVersion cVersion = new ContentVersion();
        cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
        cVersion.PathOnClient = 'License_Batch'+pageCounter+'.pdf';//File name with extention
        cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
        cVersion.Title = 'License_Batch'+pageCounter+'.pdf';//Name of the file
        cVersion.VersionData = Test.isRunningTest() ? Blob.valueOf('UNIT.TEST') : pagePdf.getContentAsPdf();//File content
        insert cVersion;
       
        //C: Create Content Document Link
        ContentVersion cVer = [SELECT ContentDocumentId,VersionData FROM ContentVersion WHERE Id = :cVersion.Id];
       
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = cVer.ContentDocumentId;//Add ContentDocumentId
        cDocLink.LinkedEntityId = targetRecordId;//Add attachment parentId
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
        insert cDocLink;
        
        /*if(licensesToUpdate.size()>0) {
            update licensesToUpdate;
        }*/
        if(!scope.isEmpty()){
            update scope;
        }
        pageCounter = pageCounter+1;
    }
    //Finish Method - no execution needed here
    public void finish(Database.BatchableContext bc){
        License_Print_Request__c licensePrint  = new License_Print_Request__c ();
        licensePrint.Id = this.targetRecordId;
        licensePrint.QueryString__c = this.queryString;
        licensePrint.Status__c = 'Completed';
        licensePrint.Record_Processed__c = this.recordsProcessed;                                                  
        
        update licensePrint;
    }
   
}