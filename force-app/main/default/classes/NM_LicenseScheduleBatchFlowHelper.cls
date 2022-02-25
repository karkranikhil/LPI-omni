/**
* @description       : Batch class helper to perform date based flows on Business License. It updates the records based on License_Batch_Flow__mdt metadata.
* @author            : Vishnu Kumar
* @group             : 
* @last modified on  : 6 Oct 2021
* @last modified by  : Vishnu Kumar
**/
public with sharing class NM_LicenseScheduleBatchFlowHelper {

    //Varibales
    Map<String, List<License_Batch_Flow__mdt> > board_license_and_configs;
    Map<Id, BusinessLicense> bLicesnes = new Map<Id, BusinessLicense>();
    List<BusinessLicense> licenses;
    List<BusinessLicense> updtLicense;

    //Constructor
    public NM_LicenseScheduleBatchFlowHelper(List<BusinessLicense> licenses) {
        this.licenses = licenses;
    }

    /**
    * @description       : This method loads the License_Batch_Flow__mdt metadata records based on business licenses.
    * @author            : Vishnu Kumar
    **/
    public void initiateConfiguration(){
        Set<String> boards = new Set<String>();
        Set<String> licesen_names = new Set<String>();
        board_license_and_configs = new Map<String, List<License_Batch_Flow__mdt> >();

        //Gather all the boards and licenses
        for( BusinessLicense lic : licenses ){
            boards.add( lic.Authority__c );
            licesen_names.add( lic.Regulatory_Authorization_Type__c );
            bLicesnes.put(lic.Id, lic);
        }
        //Add default to consider all licenses 
        licesen_names.add('ALL_LICENSE');

        //Query configurations based on board and licenses and storing in a map
        for( License_Batch_Flow__mdt config : [SELECT id,Board__c,Condition_Field__c,Condition_Operator__c,Condition_Value__c,
                                                Date_Field_To_Consider_API__c,License__c,Time_Unit__c,Time_Value__c,
                                                Update_Field__c,Update_Type__c,Update_Value__c, Time_Operator__c,Additional_Information__c
                                                FROM License_Batch_Flow__mdt
                                                WHERE Active__c = True AND Board__c in : boards AND License__c in : licesen_names ]){

            List<License_Batch_Flow__mdt> configs = new List<License_Batch_Flow__mdt>();
            
            String key;
            //If not for all license then create key of board and license else just using board.
            if( config.License__c != 'ALL_LICENSE' ){
                key = config.Board__c+'_'+config.License__c;
            }
            else{
                key = config.Board__c;
            }

            if( board_license_and_configs.containsKey(key) ){
                configs  = board_license_and_configs.get(key);
            }
            configs.add(config);

            board_license_and_configs.put(key, configs);
        }
    }

    /**
    * @description       : This method process the buisness license records and based on validation perform the data manipulation using metadata configurations.
    * @author            : Vishnu Kumar
    **/
    public void processData(){
        updtLicense = new List<BusinessLicense>();
        Set<Id> isProcessed = new Set<Id>();

        //Iterate over all the licenses
        for( BusinessLicense lic : licenses ){
            //1: Get record's config based on board and license
            List<License_Batch_Flow__mdt> configs = board_license_and_configs.get(lic.Authority__c+'_'+lic.Regulatory_Authorization_Type__c);

            //2: Get record's config based on board
            if( board_license_and_configs.containsKey(lic.Authority__c) ){
                if( configs != null ){
                    configs.addAll( board_license_and_configs.get(lic.Authority__c) );
                }
                else{
                    configs = board_license_and_configs.get(lic.Authority__c);
                }
            }
            
            if( configs != null && !configs.isEmpty() ){

                //Iterate over all the configs and then check if record qualifies the validations
                for( License_Batch_Flow__mdt config : configs ){

                    //Three checks are peformed here
                    //1. Is record already processed
                    //2. Is record meet the entrt criteria (+ additional criteria)
                    //3. Is record meet the Date related criteria
                    if( !isProcessed.contains(lic.Id) && validateCondition(lic, config) && validateDate(lic, config) ){
                        executeUpdate(lic, config);
                        
                        updtLicense.add(lic);

                        isProcessed.add(lic.Id);
                    }
                }

            }
        }
    }

    /**
    * @description       : This method fire DML to update the busines license records and also creates the logs.
    * @author            : Vishnu Kumar
    **/
    public void commitData(){
        if( !updtLicense.isEmpty() ){
            List<Debug_Log__c> debugs = new List<Debug_Log__c>();

            // Database method to update the records in List
            // Iterate through each returned result by the method
            integer i = 0;
            for (Database.SaveResult sr : Database.update(updtLicense, false) ) {
                if (sr.isSuccess()) {
                    Debug_Log__c dl = new Debug_Log__c();
                    dl.Data__c = JSON.serialize( bLicesnes.get(sr.getId()) );
                    dl.Execution_Path__c = 'NM_LicenseScheduleBatchFlowHelper.commitData()';
                    dl.Record_ID__c = sr.getId();
                    dl.Result__c = 'Success';
                    debugs.add(dl);
                }
                else {

                    Debug_Log__c dl = new Debug_Log__c();
                    dl.Data__c = JSON.serialize( updtLicense[i] );
                    dl.Error__c = JSON.serialize( sr.getErrors() );
                    dl.Execution_Path__c = 'NM_LicenseScheduleBatchFlowHelper.commitData()';
                    dl.Record_ID__c = updtLicense[i].Id;
                    dl.Result__c = 'Failed';
                    dl.Failure_Type__c = 'Record Level';
                    debugs.add(dl);
                }
                i++;
            }

            insert debugs;
        }
    }

    /*------------------------------------------------------------------Helper Methods-----------------------------------------------------------------*/

    /**
    * @description       : This is helper method to validate entry criteria for the record to evalute the condition.
    * @author            : Vishnu Kumar
    **/
    private boolean validateCondition(BusinessLicense lic, License_Batch_Flow__mdt config){
        //If Reminder flow and already contains the notification then dont execute the flow
        if( config.Additional_Information__c == 'Reminder' && String.isNotBlank(lic.Reminder_Flow__c) && lic.Reminder_Flow__c.contains(config.Update_Value__c)  ){
            return false;
        }

        
        if( config.Condition_Operator__c == 'Equals' ){
            return (  ( (String)lic.get( config.Condition_Field__c ) ) == config.Condition_Value__c);
        }
        else if( config.Condition_Operator__c == 'Contains' ){
            return ( ( (String)lic.get( config.Condition_Field__c ) ).contains(config.Condition_Value__c) );
        }
        else if( config.Condition_Operator__c == 'Does Not Contains' ){
            return !( ( (String)lic.get( config.Condition_Field__c ) ).contains(config.Condition_Value__c) );
        }
        
        return false;
    }

    /**
    * @description       : This is helper method to validate datetime related fields.
    * @author            : Vishnu Kumar
    **/
    private boolean validateDate(BusinessLicense lic, License_Batch_Flow__mdt config){
        Datetime recordDateTime = (DateTime)lic.get(config.Date_Field_To_Consider_API__c);
        Datetime dateToCheck;

        if( recordDateTime != null ){
            
            //Add/subtract the time value based on selection
            if( config.Time_Unit__c == 'Day' ){
                dateToCheck = recordDateTime.addDays( Integer.valueOf(config.Time_Value__c) );
            }
            else if( config.Time_Unit__c == 'Month' ){
                dateToCheck = recordDateTime.addMonths( Integer.valueOf(config.Time_Value__c) );
            }
            else if( config.Time_Unit__c == 'Year' ){
                dateToCheck = recordDateTime.addYears( Integer.valueOf(config.Time_Value__c) );
            }

            //Check datetime based on available operators
            if( config.Time_Operator__c == '=' ){
                return 
                    DateTime.Now().Day() == dateToCheck.Day() &&
                    DateTime.Now().Month() == dateToCheck.Month() &&
                    DateTime.Now().Year() == dateToCheck.Year();
            }
            else if( config.Time_Operator__c == '>=' ){
                return DateTime.Now() >= dateToCheck;
            }
        }

        return false;
    }

    /**
    * @description       : This is helper method to update the field values based on configurations.
    * @author            : Vishnu Kumar
    **/
    private void executeUpdate(BusinessLicense lic, License_Batch_Flow__mdt config){
        if( config.Update_Type__c == 'Replace' ){
            lic.put( config.Update_Field__c , config.Update_Value__c );
        }
        else if( config.Update_Type__c == 'Append' ){
            String currVal = (String)lic.get( config.Update_Field__c );
            currVal = String.isBlank(currVal) ? config.Update_Value__c : currVal + ';' + config.Update_Value__c;

            lic.put( config.Update_Field__c , currVal );
        }
    }
}