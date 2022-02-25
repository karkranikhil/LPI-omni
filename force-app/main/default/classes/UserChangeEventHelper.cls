/**
* @description       : To handle the portal email update and update the username and email on contact.
* @author            : Vishnu Kumar
* @Created on  : 29 Oct 2021
**/
public class UserChangeEventHelper {
    
    /**
    * @description       : This method get called from UserChangeEvent trigger and it updates the username of the user.
    * @author            : Vishnu Kumar
    * @Created on  : 29 Oct 2021
    **/
    public static void run(List<UserChangeEvent> data){
        for (UserChangeEvent event: data) {
            EventBus.ChangeEventHeader header = event.ChangeEventHeader;
            
            //Check if email has been changed
            if ( header.changedFields.contains('Email') ) { 
                User usr = [Select id,ContactId,Email from User where Id =: event.ChangeEventHeader.getRecordIds()[0] ];
                
                if( usr.ContactId != null ){
					//Step 1: Update the username of the User record
                    usr.UserName = event.Email;
                    update usr;
                    
                    //Step 2: Trigger the contact email in future job.
                    //Future job is needed here else we will get the Mixed DML error
                    updateContactEmail( usr.ContactId, event.Email);
                }
            }
            
        }
    }
    
    /**
    * @description       : This method update the email on the contact of the user.
    * @author            : Vishnu Kumar
    * @Created on  : 29 Oct 2021
    **/
    @future
    public static void updateContactEmail(String recordId, String emailAdd){
        Contact con = new Contact();
        con.Id = recordId;
        con.Email = emailAdd;
        update con;
    }
}