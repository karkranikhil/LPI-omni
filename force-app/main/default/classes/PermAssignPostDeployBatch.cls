public class PermAssignPostDeployBatch implements Database.Batchable<sObject>{
    String queryString;
    List<Id> targetRecordId;
    public PermAssignPostDeployBatch(String queryString, List<Id> targetRecordId) {
        this.queryString = queryString;
        this.targetRecordId = targetRecordId;
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
       // String queryString= 'Select id from User  Where ProfileId = \'00et0000000gokmAAA\' and isActive = true '; 
        return Database.getQueryLocator(this.queryString);
    }
    
    public void execute(Database.BatchableContext BC, List<user> scope){
        List<PermissionSetAssignment> permSets = new List<PermissionSetAssignment>();
        
        for(User usr : scope){
            for(Id permId : this.targetRecordId){
                PermissionSetAssignment psla = new PermissionSetAssignment();    
                psla.PermissionSetId = permId;
                psla.AssigneeId = usr.Id;
                permSets.add(psla);
            }
            
        } 
        If(permSets.Size()>0){
           database.insert( permSets, false); 
        }
        
    }
    
    public void finish(Database.BatchableContext BC){
    }
}