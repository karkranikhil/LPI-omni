@JsonAccess(serializable='always')
global without sharing class LPINewCompliantController implements vlocity_ins.VlocityOpenInterface2{
    global Object invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        Map<String,Object> inputWhat = (Map<String,Object>)input.get('What');
        Map<String,Object> inputWhere = (Map<String,Object>)input.get('Where');
        Map<String,Object> inputWho = (Map<String,Object>)input.get('Who');
        Savepoint sp = null;
        // Boolean isQualified = false;
        // System.debug('INTO::'+inputSQ);
        try {
            sp = Database.setSavepoint();
            String fname = (String)inputWho.get('FirstName');
            String lname = (String)inputWho.get('LastName');
            String Email = inputWho.containsKey('Email') ? (String)inputWho.get('Email'):'';
            String phone = inputWho.containsKey('PrimaryPhone') ? (String)inputWho.get('PrimaryPhone'):'';
            String AddressLine1 = inputWho.containsKey('AddressLine1') ? (String)inputWho.get('AddressLine1'):'';
            String AddressLine2 = inputWho.containsKey('AddressLine2') ? (String)inputWho.get('AddressLine2'):'';
            String State = inputWho.containsKey('State') ? (String)inputWho.get('State'):'';
            String City = inputWho.containsKey('City') ? (String)inputWho.get('City'):'';
            String Zip = inputWho.containsKey('Zip') ? (String)inputWho.get('Zip'):'';

            Contact con = new Contact();
            con.FirstName = fname;
            con.LastName = lname;
            con.Email = Email;
            con.Phone = phone;
            con.Email = Email;
            con.MailingStreet = AddressLine1 + ',' +AddressLine2;
            con.MailingState = State;
            con.MailingCity = City;
            con.MailingPostalCode = Zip;
            insert con;

            String Radio1 = inputWhat.containsKey('Radio1') ? (String)inputWhat.get('Radio1'):'';
            String Radio2 = inputWhat.containsKey('Radio2') ? (String)inputWhat.get('Radio2'):'';
            String Problem_Detail = inputWhat.containsKey('Problem_Detail') ? (String)inputWhat.get('Problem_Detail'):'';
            String Driver_Name = inputWhat.containsKey('Driver_Name') ? (String)inputWhat.get('Driver_Name'):'';
            String License = inputWhat.containsKey('License') ? (String)inputWhat.get('License'):'';
            String Description = inputWhat.containsKey('Description') ? (String)inputWhat.get('Description'):'';
            String Date_Observed = inputWhat.containsKey('Date_Observed') ? (String)inputWhat.get('Date_Observed'):'';
            String Taxi_Payment_Type = inputWhat.containsKey('Taxi_Payment_Type') ? (String)inputWhat.get('Taxi_Payment_Type'):'';



            String Location_Type = inputWhere.containsKey('Location_Type') ? (String)inputWhere.get('Location_Type'):'';
            String Radio3 = inputWhere.containsKey('Radio3') ? (String)inputWhere.get('Radio3'):'';
            String Radio4 = inputWhere.containsKey('Radio4') ? (String)inputWhere.get('Radio4'):'';
            String PickUp_Location_address = inputWhere.containsKey('PickUp_Location_address') ? (String)inputWhere.get('PickUp_Location_address'):'';
            String PickUp_Location_destination = inputWhere.containsKey('PickUp_Location_destination') ? (String)inputWhere.get('PickUp_Location_destination'):'';
            String Borough = inputWhere.containsKey('Borough') ? (String)inputWhere.get('Borough'):'';
            String Bridge = inputWhere.containsKey('Bridge') ? (String)inputWhere.get('Bridge'):'';
            String Roadway_Tunnel = inputWhere.containsKey('Roadway_Tunnel') ? (String)inputWhere.get('Roadway_Tunnel'):'';
            String RoadRamp = inputWhere.containsKey('RoadRamp') ? (String)inputWhere.get('RoadRamp'):'';
            String Direction = inputWhere.containsKey('Direction') ? (String)inputWhere.get('Direction'):'';
            String Highway = inputWhere.containsKey('Highway') ? (String)inputWhere.get('Highway'):'';
            String SegmentExit = inputWhere.containsKey('SegmentExit') ? (String)inputWhere.get('SegmentExit'):'';
            String Apartment = inputWhere.containsKey('Apartment') ? (String)inputWhere.get('Apartment'):'';
            String Additional_Location_Details = inputWhere.containsKey('Additional_Location_Details') ? (String)inputWhere.get('Additional_Location_Details'):'';
            
            Date Date_Observed_value = Date.parse( Date_Observed );
            Case newCase = new Case();
            newCase.Origin = 'Web';
            newCase.Status = 'New';
            newCase.ContactId = con.Id;
            newCase.The_hearing_can_be_done_in_person__c = Radio1;
            newCase.Complaint_with_Licensee__c = Radio2 == 'Yes' ? true : false;
            newCase.Problem_Detail__c = Problem_Detail;
            newCase.Driver_Name__c = Driver_Name;
            newCase.License__c = License;
            newCase.Description__c = Description;
            newCase.Date_Time_Observed__c = Date_Observed_value;
            newCase.Taxi_Payment_Type__c = Taxi_Payment_Type;
            newCase.Location_Type__c = Location_Type;
            newCase.Is_address_in_NYC__c = Radio3;
            newCase.Is_Destination_in_NYC__c = Radio4;
            newCase.PickUp_Location_address__c = PickUp_Location_address;
            newCase.PickUp_Location_destination__c = PickUp_Location_destination;
            newCase.Borough__c = Borough;
            newCase.Road_or_Ramp__c = RoadRamp;
            newCase.Direction__c = Direction;
            newCase.Highway__c = Highway;
            newCase.Segment_or_Exit__c = SegmentExit;
            newCase.Apartment__c = Apartment;
            newCase.Additional_Location_Details__c = Additional_Location_Details;

            insert newCase;
            

        } catch(Exception exp) {
            Database.rollback(sp);
            return exp.getMessage(); 
        }
        return null;
    }
}