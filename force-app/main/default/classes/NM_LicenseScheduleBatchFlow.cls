/**
* @description       : Batch/Schedule class to perform date based flows on Business License.
* @author            : Vishnu Kumar
* @group             : 
* @last modified on  : 6 Oct 2021
* @last modified by  : Vishnu Kumar
**/
global with sharing class NM_LicenseScheduleBatchFlow implements Database.Batchable<sObject>, Schedulable{
    
    /**
    * @description       : This method get called to when job needs to be scheduled.
    * @author            : Vishnu Kumar
    **/
    global void execute(SchedulableContext SC) {
        Database.executeBatch( new NM_LicenseScheduleBatchFlow() , Integer.valueOf(System.Label.NM_BCD_License_Flow_Batch_Size) );
    }

    /**
    * @description       : This method schedule the job based on CRON.
    * @author            : Vishnu Kumar
    **/
    public static void scheduleJob(String cron){
        //Default is 12:05 AM Daily
        cron = String.isBlank(cron) ? '0 5 0 * * ? *' : cron;

        String jobID = System.schedule('NM_LicenseScheduleBatchFlow_'+cron, cron , new NM_LicenseScheduleBatchFlow());
    }

    /**
    * @description       : This method get called to load the data when batch gets executed.
    * @author            : Vishnu Kumar
    **/
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(System.Label.NM_BCD_License_Flow_Batch_Query);
    }

    /**
    * @description       : This method get called to when batch returns the chunk of data.
    * @author            : Vishnu Kumar
    **/
    public void execute(Database.BatchableContext bc, List<BusinessLicense> licenses){
        try {
            NM_LicenseScheduleBatchFlowHelper flow_helper = new NM_LicenseScheduleBatchFlowHelper(licenses);
            flow_helper.initiateConfiguration();
            flow_helper.processData();
            flow_helper.commitData();
        }
        catch (Exception e) {
            Debug_Log__c dl = new Debug_Log__c();
            dl.Error__c = JSON.serialize( e.getMessage() + ' ------ ' +  e.getStackTraceString() );
            dl.Execution_Path__c = 'NM_LicenseScheduleBatchFlow.execute()';
            dl.Result__c = 'Failed';
            dl.Failure_Type__c = 'Batch Job';

            insert dl;
        }
    }

    /**
    * @description       : This method get called to when processing gets completed.
    * @author            : Vishnu Kumar
    **/
    public void finish(Database.BatchableContext bc){}
}