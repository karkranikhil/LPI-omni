@JsonAccess(serializable='always')
global without sharing class LPINewCompliantController implements vlocity_ins.VlocityOpenInterface2{
    global String invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        if (methodName == 'createCase') {
            Id caseId = createCase();
            output.put('newCaseId', caseId);
            return null;
        }
        Map<String,Object> inputWhat = (Map<String,Object>)input.get('What');
        Map<String,Object> inputWhere = (Map<String,Object>)input.get('Where');
        Map<String,Object> inputWho = (Map<String,Object>)input.get('Who');
        Map<String,Object> inputCase = (Map<String,Object>)input.get('NewCase');
        System.debug('inputWhat>>>' + JSON.serialize(inputWhat));
        System.debug('Where>>>' + JSON.serialize(inputWhere));
        System.debug('inputWho>>>' + JSON.serialize(inputWho));
        // String temp = JSON.serialize(inputWhere);
        // System.debug('Radio333>>>' + JSON.serialize(inputWhere).Block2);
        // System.debug('Radio333>>>' + inputWhere.Block2.Radio3);
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
            // String AddressLine1 = inputWho.containsKey('Contact_Address-Block') ? (String)((Map<String,Object>)inputWho.get('Contact_Address-Block')).get('AddressLine1'):'';

            // String AddressLine2 = inputWho.containsKey('Contact_Address-Block') ? (String)((Map<String,Object>)inputWho.get('Contact_Address-Block')).get('AddressLine2'):'';
            // String Country = inputWho.containsKey('Contact_Address-Block') ? (String)((Map<String,Object>)inputWho.get('Contact_Address-Block')).get('Country'):'';
            // String City = inputWho.containsKey('Contact_Address-Block') ? (String)((Map<String,Object>)inputWho.get('Contact_Address-Block')).get('City'):'';
            // String Zip = inputWho.containsKey('Contact_Address-Block') ? (String)((Map<String,Object>)inputWho.get('Contact_Address-Block')).get('Zip'):'';


            Contact con = new Contact();
            con.FirstName = fname;
            con.LastName = lname;
            con.Phone = phone;
            con.Email = Email;
            con.MailingStreet = AddressLine1 + ',' +AddressLine2;
            con.MailingState = State;
            con.MailingCity = City;
            con.MailingPostalCode = Zip;
            insert con;

            System.debug('ContactId>>'+con.Id);
            String Radio1,Radio2,Problem_Detail,Driver_Name,License,Description,Date_Observed,Additional_Details,Taxi_Payment_Type,Location_Type,PickUpRadio,DestRadio,PickUp_Location_destination,PickUp_Location_address = '';
            Radio1 = inputWhat.containsKey('Radio1') ? (String)inputWhat.get('Radio1'):'';
            Radio2 = inputWhat.containsKey('Radio2') ? (String)inputWhat.get('Radio2'):'';
            Problem_Detail = inputWhat.containsKey('Problem_Detail') ? (String)inputWhat.get('Problem_Detail'):'';
            Driver_Name = inputWhat.containsKey('Driver_Name') ? (String)inputWhat.get('Driver_Name'):'';
            License = inputWhat.containsKey('License') ? (String)inputWhat.get('License'):'';
            Description = inputWhat.containsKey('Description') ? (String)inputWhat.get('Description'):'';
            Date_Observed = inputWhat.containsKey('Date_Observed') ? (String)inputWhat.get('Date_Observed'):'';
            Additional_Details = inputWhat.containsKey('Additional_Details') ? (String)inputWhat.get('Additional_Details'):'';
            Taxi_Payment_Type = inputWhat.containsKey('Taxi_Payment_Type') ? (String)inputWhat.get('Taxi_Payment_Type'):'';

            Map<String,Object> Block1 = (Map<String,Object>)inputWhere.get('Block1');
            Map<String,Object> Block2 = (Map<String,Object>)inputWhere.get('Block2');
            Map<String,Object> Block3 = (Map<String,Object>)inputWhere.get('Block3');

            //Block2
            if (Block2 != null) {
                Location_Type = Block2.containsKey('Location_Type') ? (String)Block2.get('Location_Type'):'';
                PickUpRadio = Block2.containsKey('PickUpRadio') ? (String)Block2.get('PickUpRadio'):'';
                DestRadio = Block2.containsKey('DestRadio') ? (String)Block2.get('DestRadio'):'';
                PickUp_Location_destination = Block2.containsKey('PickUp_Location_destination-Block') ? (String)((Map<String,Object>)Block2.get('PickUp_Location_destination-Block')).get('PickUp_Location_destination'):'';
                PickUp_Location_address = Block2.containsKey('PickUp_Location_address-Block') ? (String)((Map<String,Object>)Block2.get('PickUp_Location_address-Block')).get('PickUp_Location_address'):'';
            }
            String Borough,Bridge,RoadRamp,Roadway_Tunnel,Direction,Highway,SegmentExit,Apartment,Additional_Location_Details = '';
            if (Block1 != null) {        
                Borough = Block1.containsKey('Borough') ? (String)Block1.get('Borough'):'';
                Bridge = Block1.containsKey('Bridge') ? (String)Block1.get('Bridge'):'';
                Roadway_Tunnel = Block1.containsKey('Roadway_Tunnel') ? (String)Block1.get('Roadway_Tunnel'):'';
                RoadRamp = Block1.containsKey('RoadRamp') ? (String)Block1.get('RoadRamp'):'';
                Direction = Block1.containsKey('Direction') ? (String)Block1.get('Direction'):'';
                Highway = Block1.containsKey('Highway') ? (String)Block1.get('Highway'):'';
                SegmentExit = Block1.containsKey('SegmentExit') ? (String)Block1.get('SegmentExit'):'';
            }
            if (Block3 != null) {
                //Block3
                Apartment = Block3.containsKey('Apartment') ? (String)Block3.get('Apartment'):'';
                Additional_Location_Details = Block3.containsKey('Additional_Location_Details') ? (String)Block3.get('Additional_Location_Details'):'';
            }
            String caseId = (String)inputCase.get('newCaseId');

            Case newCase = new Case();
            newCase.Id = caseId;
            newCase.ContactId = con.Id;
            newCase.The_hearing_can_be_done_in_person__c = Radio1;
            newCase.Complaint_with_Licensee__c = Radio2 == 'Yes' ? true : false;
            newCase.Problem_Detail__c = Problem_Detail;
            newCase.Driver_Name__c = Driver_Name;
            newCase.License__c = License;
            newCase.Additional_Details__c = Additional_Details;
            newCase.Description__c = Description;
            newCase.Date_Time_Observed__c = Date.valueOf(Date_Observed);
            newCase.Taxi_Payment_Type__c = Taxi_Payment_Type;
            newCase.Location_Type__c = Location_Type;
            newCase.Is_address_in_NYC__c = PickUpRadio;
            newCase.Is_Destination_in_NYC__c = DestRadio;
            newCase.PickUp_Location_address__c = PickUp_Location_address;
            newCase.PickUp_Location_destination__c = PickUp_Location_destination;
            newCase.Borough__c = Borough;
            newCase.Road_or_Ramp__c = RoadRamp;
            newCase.Direction__c = Direction;
            newCase.Highway__c = Highway;
            newCase.Segment_or_Exit__c = SegmentExit;
            newCase.Apartment__c = Apartment;
            newCase.Additional_Location_Details__c = Additional_Location_Details;

            update newCase;

        } catch(Exception exp) {
            Database.rollback(sp);
            return exp.getMessage(); 
        }
        return null;
    }
    global String createCase(){
        Savepoint sp = null;
        
        try {
            sp = Database.setSavepoint();
            Case newCase = new Case();
            newCase.Origin = 'Web';
            newCase.Status = 'New';
            newCase.RecordTypeId = '0125f000000uQ46AAE';
            insert newCase;
            return newCase.Id;
        } catch (Exception exp) {
            Database.rollback(sp);
            return exp.getMessage(); 
        }
    }
}