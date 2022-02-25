global without sharing class SearchLicenseAndPermitController {
    @AuraEnabled 
    public static  Map<String, String> getPiclistFieldValue(){
        system.debug('================ ');
        Map<String, String> options = new Map<String, String>();
        try{
            
            Schema.DescribeFieldResult fieldResult= BusinessLicense.License_Type__c.getDescribe();
            List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
            for (Schema.PicklistEntry p: pValues) {
                options.put(p.getValue(), p.getLabel());
            }
        }catch(Exception e){
            system.debug('==========error '+e.getStackTraceString());
        }
        
        return options;
    }
    
    @AuraEnabled
    global static List<BusinessLicense> searchlicensesandpermits(String searchkey, String typeoflicense){
         String query ='Select Licensee_Name__c ,Name  ,License_Type__c ,PM_End_Date__c , Status from BusinessLicense where';
        Boolean isSearchKeNull = false;
         if(searchkey == null || String.isBlank(searchkey) || searchkey.equals('')){
            isSearchKeNull = true;
         }else {
             query =query+' '+'(Licensee_Name__c LIKE \'%'+ searchkey + '%\' OR Name LIKE \'%' + searchkey + '%\''+')';
               //OR Name  =:searchkey)
                 //String sql = 'Select Name From Account WHERE Name LIKE \'%' + searchKeyword + '%\'';

         }
        if(typeoflicense == null || String.isBlank(typeoflicense) || typeoflicense.equals('')){
            
        }else {
            if(isSearchKeNull){
                query=query+' '+'License_Type__c=:typeoflicense';
            }else {
              query=query+' AND '+'License_Type__c=:typeoflicense';  
            }
            
            
        }
        system.debug('===== searchkey '+query);
        system.debug('===== typeoflicense  '+typeoflicense);
        system.debug('===== Database.query(query)  '+Database.query(query));
        return Database.query(query); 
        /*if(typeoflicense == null || String.isBlank(typeoflicense) || typeoflicense.equals('')){
            system.debug('============= ');
              return [Select Licensee_Name__c ,Name  ,License_Type__c ,PM_End_Date__c , Status from BusinessLicense where (Licensee_Name__c =:searchkey
               OR Name  =:searchkey) ];
        }else {
            return [Select Licensee_Name__c ,Name  ,License_Type__c ,PM_End_Date__c , Status from BusinessLicense where (Licensee_Name__c=:searchkey 
               OR Name =:searchkey) AND License_Type__c=:typeoflicense];
        }*/
        
    }
}