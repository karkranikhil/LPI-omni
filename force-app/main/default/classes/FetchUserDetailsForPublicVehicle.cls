@JsonAccess(serializable='always')
global without sharing class FetchUserDetailsForPublicVehicle implements vlocity_ins.VlocityOpenInterface2{
    global String invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        if(methodName == 'createNewRecord'){
            PreliminaryApplicationRef newObj;
            newObj = new PreliminaryApplicationRef();
            String ApplicationType = (String)input.get('ApplicationType');
            String LicenseType = (String)input.get('LicenseType');
            newObj.Application_Type__c = ApplicationType;
            newObj.License_Type__c = LicenseType;
            newObj.SavedApplicationUrl = 'NA';
            newObj.ApplicationType = 'IndividualApplication';
            newObj.ApplicationName = 'Vehicle License Application';
            newObj.RecordTypeId = '0125f000000uyMGAAY';
            insert newObj;
            output.put('objectId',newObj.Id);
            return null;
        }
        if(methodName == 'updateValues'){
            Map<String,Object> newPAR = (Map<String,Object>)input.get('insertNewRecord');
            String parId = (String)newPAR.get('objectId');

            System.debug('parId>>>>'+ parId);

            Map<String,Object> AppInfo = (Map<String,Object>)input.get('APPLICANT_INFORMATION');
            Map<String,Object> VehInfo = (Map<String,Object>)input.get('VEHICLE_INFORMATION');
            Map<String,Object> BaseAffInfo = (Map<String,Object>)input.get('BASE_AFFILIATION_INFORMATION');
            Map<String,Object> StreetHail = (Map<String,Object>)input.get('STREET_HAIL_LIVERY_PERMIT_AFFILIATION_INFORMATION');
            Map<String,Object> ForHire = (Map<String,Object>)input.get('FOR_HIRE_VEHICLES_ONLY');
            Map<String,Object> BackQues = (Map<String,Object>)input.get('BACKGROUND_QUESTIONNAIRE');
            Map<String,Object> ListOwner = (Map<String,Object>)input.get('LIST_ALL_OWNERS');
            
            PreliminaryApplicationRef newObj = new PreliminaryApplicationRef();
            Account acc = new Account();

            Related_Party__c relatedParty1 = new Related_Party__c();
            Related_Party__c relatedParty2 = new Related_Party__c();
            Related_Party__c relatedParty3 = new Related_Party__c();
            Related_Party__c relatedParty4 = new Related_Party__c();
            List<Related_Party__c> rpList = new List<Related_Party__c>();

            //Blocks
             Map<String,Object> Block1,Block2,Block3,Block4,Block5,Block6,Block7,Block8,Block9,Block10,Block11,Block13,OWNERS, PARTNERS,STOCKHOLDERS;
            if (AppInfo != null) {
                //application info
                Block1 = AppInfo.containsKey('Block1') ? (Map<String,Object>)AppInfo.get('Block1') : null;
                Block2 = AppInfo.containsKey('Block2') ? (Map<String,Object>)AppInfo.get('Block2') : null;
                Block3 = AppInfo.containsKey('Block3') ? (Map<String,Object>)AppInfo.get('Block3') : null;
            }
            if (VehInfo != null) {
                //vehicle
                Block4 = VehInfo.containsKey('Block4') ? (Map<String,Object>)VehInfo.get('Block4') : null;
            }
            if (BaseAffInfo != null) {
                //BASE_AFFILIATION_INFORMATION
                Block5 = BaseAffInfo.containsKey('Block5') ? (Map<String,Object>)BaseAffInfo.get('Block5') : null;
            }
            if (StreetHail != null) {
                
                //STREET_HAIL_LIVERY_PERMIT_AFFILIATION_INFORMATION
                Block6 = StreetHail.containsKey('Block6') ? (Map<String,Object>)StreetHail.get('Block6') : null;
            }
            if (ForHire != null) {
                //FOR_HIRE_VEHICLES_ONLY
                Block7 = ForHire.containsKey('Block7') ? (Map<String,Object>)ForHire.get('Block7') : null;
            }
            if (BackQues != null) {
                //BACKGROUND_QUESTIONNAIRE
                Block8 = BackQues.containsKey('Block8') ? (Map<String,Object>)BackQues.get('Block8') : null;
            }
            if (ListOwner != null) {            
                //LIST_ALL_OWNERS
                OWNERS = ListOwner.containsKey('OWNERS') ? (Map<String,Object>)ListOwner.get('OWNERS') : null;
                PARTNERS = ListOwner.containsKey('PARTNERS') ? (Map<String,Object>)ListOwner.get('PARTNERS') : null;
                Block11 = ListOwner.containsKey('Block11') ? (Map<String,Object>)ListOwner.get('Block11') : null;
                STOCKHOLDERS = ListOwner.containsKey('STOCKHOLDERS') ? (Map<String,Object>)ListOwner.get('STOCKHOLDERS') : null;
                Block13 = ListOwner.containsKey('Block13') ? (Map<String,Object>)ListOwner.get('Block13') : null;
            }
            System.debug('>>>>passed line 52');
            String Vehicle_Classification,TLC_License_number,First_name,lastName,DOB,MailAddress,City,State,Zip,Cell_phone,EIN,SS,Email_Address,Other_Telephone,Residence_Address='';
            String City1,State1,Zip1,Business_Type='';
            String Insurance_Carrier,Insurance_Policy_Number='';

            //checking if llname is there
            // String lName = Block2.containsKey('lastName') ? (String)Block2.get('lastName'):'';
            // String accId = [SELECT Id FROM Account Where LastName = :lName LIMIT 1].Id;
            // if (accId != null) {
            //     acc.Id = accId;
            // }

            if (Block1 != null) {
                acc.Vehicle_Classification__c = Block1.containsKey('Vehicle_Classification') ? (String)Block1.get('Vehicle_Classification'):'';
                acc.TLC_License_number__c = Block1.containsKey('TLC_License_number') ? String.valueOf(Block1.get('TLC_License_number')): '';
                acc.TLC_H_Record_number__c = Block1.containsKey('TLC_H_Record_number') ? String.valueOf(Block1.get('TLC_H_Record_number')): '';
            }
            if (Block2 != null) {
                acc.FirstName = Block2.containsKey('First_name') ? (String)Block2.get('First_name'):'';
                acc.LastName = Block2.containsKey('lastName') ? (String)Block2.get('lastName'):'';
                Id personAccountRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
                acc.RecordTypeId = personAccountRecordTypeId;
                acc.PersonBirthdate = Date.valueOf((String)Block2.get('DOB'));
                acc.PersonMailingStreet = Block2.containsKey('MailAddress') ? (String)Block2.get('MailAddress'):'';
                acc.PersonMailingCity = Block2.containsKey('City') ? (String)Block2.get('City'):'';
                acc.PersonMailingState = Block2.containsKey('State') ? (String)Block2.get('State'):'';
                acc.PersonMailingPostalCode = Block2.containsKey('Zip') ? String.valueOf(Block2.get('Zip')):'';
                acc.Cell_Phone__c = Block2.containsKey('Cell_phone') ? String.valueOf(Block2.get('Cell_phone')):'';
                acc.EIN__c = Block2.containsKey('EIN') ? (Decimal)Block2.get('EIN') : 0 ;
                acc.SS__c = Block2.containsKey('SS') ? (Decimal)Block2.get('SS') : 0 ;
                acc.PersonEmail = Block2.containsKey('Email_Address') ? (String)Block2.get('Email_Address'):'';
                acc.PersonOtherPhone = Block2.containsKey('Other_Telephone') ? String.valueOf(Block2.get('Other_Telephone')):'';
            }
            if (Block3 != null) {
                acc.Residence_Apartment_Number__c = Block3.containsKey('Residence_Address') ? (String)Block3.get('Residence_Address'):'';
                acc.Residence_City__c = Block3.containsKey('City_') ? (String)Block3.get('City_'):'';
                acc.Residence_State__c = Block3.containsKey('State1') ? (String)Block3.get('State1'):'';
                acc.Residence_Zip_Code__c = Block3.containsKey('Zip_') ? String.valueOf(Block3.get('Zip_')):'';
                acc.Business_Type__c = Block3.containsKey('Business_Type') ? (String)Block3.get('Business_Type'):'';
                Insurance_Carrier = Block3.containsKey('Insurance_Carrier') ? (String)Block3.get('Insurance_Carrier'):'';
                Insurance_Policy_Number = Block3.containsKey('Insurance_Policy_Number') ? (String)Block3.get('Insurance_Policy_Number'):'';
            }

            String VEHICLE_ID,SEATING_CAPACITY,PLATE,MAKE,RadioVI1,RadioVI2,RadioVI3,TextVI1='';
            String YEAR = '0';
            //done
            if (Block4 != null) {
                VEHICLE_ID = Block4.containsKey('VEHICLE_ID') ? (String)Block4.get('VEHICLE_ID'):'';
                SEATING_CAPACITY = Block4.containsKey('SEATING_CAPACITY') ? (String)Block4.get('SEATING_CAPACITY'):'';
                PLATE = Block4.containsKey('PLATE') ? (String)Block4.get('PLATE'):'';
                YEAR = Block4.containsKey('Text1') ? (String)Block4.get('Text1'):'0';
                MAKE = Block4.containsKey('MAKE') ? (String)Block4.get('MAKE'):'';
                RadioVI1 = Block4.containsKey('RadioVI1') ? (String)Block4.get('RadioVI1'):'';
                RadioVI2 = Block4.containsKey('RadioVI2') ? (String)Block4.get('RadioVI2'):'';
                RadioVI3 = Block4.containsKey('RadioVI3') ? (String)Block4.get('RadioVI3'):'';
                TextVI1 = Block4.containsKey('TextVI1') ? (String)Block4.get('TextVI1'):'';
            }
            String BASE_NAME = '';
            String BASE_LICENSE = '0';
            if(Block5 != null){
                BASE_NAME = Block5.containsKey('BASE_NAME') ? (String)Block5.get('BASE_NAME'):'';
                BASE_LICENSE = Block5.containsKey('BASE_LICENSE') ? (String)Block5.get('BASE_LICENSE'):'0';
            }
            String TYPE_OF_SHL_PERMIT,SHL_PERMIT_ENTITY_NAME,SHL_PERMIT='';
            if(Block6 != null){
                TYPE_OF_SHL_PERMIT = Block6.containsKey('TYPE_OF_SHL_PERMIT') ? (String)Block6.get('TYPE_OF_SHL_PERMIT'):'';
                SHL_PERMIT_ENTITY_NAME = Block6.containsKey('SHL_PERMIT_ENTITY_NAME') ? (String)Block6.get('SHL_PERMIT_ENTITY_NAME'):'';
                SHL_PERMIT = Block6.containsKey('SHL_PERMIT') ? (String)Block6.get('SHL_PERMIT'):'';
            }
            String Radio4FH,Radio5FH,Radio6FH = '';
            if(Block7 != null){
                Radio4FH = Block7.containsKey('Radio4FH') ? (String)Block7.get('Radio4FH'):'';
                Radio5FH = Block7.containsKey('Radio5FH') ? (String)Block7.get('Radio5FH'):'';
                Radio6FH = Block7.containsKey('Radio6FH') ? (String)Block7.get('Radio6FH'):'';
            }
            // done
            String Radio7BQ,Radio8BQ,Radio9BQ = '';

            if(Block8 != null){
                Radio7BQ = Block8.containsKey('Radio7BQ') ? (String)Block8.get('Radio7BQ'):'';
                Radio8BQ = Block8.containsKey('Radio8BQ') ? (String)Block8.get('Radio8BQ'):'';
                Radio9BQ = Block8.containsKey('Radio9BQ') ? (String)Block8.get('Radio9BQ'):'';
            }
            String Radio10,OWNERS_NAME,OWNERS_Radio,OWNERS_MAILING,OWNERS_CITY,OWNERS_STATE,OWNERS_ZIP,OWNERS_TELEPHONE,OWNER_OF_SHARES,OWNER_SS,OWNER_DRIVER_LICENSE = '';
            if(OWNERS != null){
                Radio10 = OWNERS.containsKey('Radio10') ? (String)OWNERS.get('Radio10'):'';
                relatedParty1.Last_Name__c = OWNERS.containsKey('OWNERS_NAME') ? (String)OWNERS.get('OWNERS_NAME'):'';
                relatedParty1.For_Corporation_or_Partnership__c = OWNERS.containsKey('OWNERS_Radio') ? (String)OWNERS.get('OWNERS_Radio'):'';
                relatedParty1.Mailing_Address__c = OWNERS.containsKey('OWNERS_MAILING') ? (String)OWNERS.get('OWNERS_MAILING'):'';
                relatedParty1.Mailing_City__c = OWNERS.containsKey('OWNERS_CITY') ? (String)OWNERS.get('OWNERS_CITY'):'';
                relatedParty1.Mailing_State__c = OWNERS.containsKey('OWNERS_STATE') ? (String)OWNERS.get('OWNERS_STATE'):'';
                relatedParty1.Mailing_Zip__c = OWNERS.containsKey('OWNERS_ZIP') ? Integer.valueOf(OWNERS.get('OWNERS_ZIP')):0;
                relatedParty1.Phone_Number__c = OWNERS.containsKey('OWNERS_TELEPHONE') ? String.valueOf(OWNERS.get('OWNERS_TELEPHONE')):'';
                relatedParty1.Of_Shares__c = OWNERS.containsKey('OWNER_OF_SHARES') ? Integer.valueOf(OWNERS.get('OWNER_OF_SHARES')):0;
                relatedParty1.SS__c = OWNERS.containsKey('OWNER_SS') ? Integer.valueOf(OWNERS.get('OWNER_SS')):0;
                relatedParty1.Driver_License__c = OWNERS.containsKey('OWNER_DRIVER_LICENSE') ? Integer.valueOf(OWNERS.get('OWNER_DRIVER_LICENSE')):0;
                relatedParty1.Type__c = 'OWNERS';
            }
            relatedParty1.Preliminary_Application_Reference__c = parId;
            rpList.add(relatedParty1);
            // insert relatedParty1;

            String PARTNERS_NAME,PARTNERS_Radio,PARTNERS_MAILING,PARTNERS_CITY,PARTNERS_STATE,PARTNERS_ZIP,PARTNERS_TELEPHONE,PARTNERS_OF_SHARES,PARTNERS_SS,PARTNERS_DRIVER_LICENSE='';
            if(PARTNERS != null){
                relatedParty2.Last_Name__c = PARTNERS.containsKey('PARTNERS_NAME') ? (String)PARTNERS.get('PARTNERS_NAME'):'';
                relatedParty2.For_Corporation_or_Partnership__c = PARTNERS.containsKey('PARTNERS_Radio') ? (String)PARTNERS.get('PARTNERS_Radio'):'';
                relatedParty2.Mailing_Address__c = PARTNERS.containsKey('PARTNERS_MAILING') ? (String)PARTNERS.get('PARTNERS_MAILING'):'';
                relatedParty2.Mailing_City__c = PARTNERS.containsKey('PARTNERS_CITY') ? (String)PARTNERS.get('PARTNERS_CITY'):'';
                relatedParty2.Mailing_State__c = PARTNERS.containsKey('PARTNERS_STATE') ? (String)PARTNERS.get('PARTNERS_STATE'):'';
                relatedParty2.Mailing_Zip__c = PARTNERS.containsKey('PARTNERS_ZIP') ? Integer.valueOf(PARTNERS.get('PARTNERS_ZIP')):0;
                relatedParty2.Phone_Number__c = PARTNERS.containsKey('PARTNERS_TELEPHONE') ? String.valueOf(PARTNERS.get('PARTNERS_TELEPHONE')):'';
                relatedParty2.Of_Shares__c = PARTNERS.containsKey('PARTNERS_OF_SHARES') ? Integer.valueOf(PARTNERS.get('PARTNERS_OF_SHARES')):0;
                relatedParty2.SS__c = PARTNERS.containsKey('PARTNERS_SS') ? Integer.valueOf(PARTNERS.get('PARTNERS_SS')):0;
                relatedParty2.Driver_License__c = PARTNERS.containsKey('PARTNERS_DRIVER_LICENSE') ? Integer.valueOf(PARTNERS.get('PARTNERS_DRIVER_LICENSE')):0;
                relatedParty2.Type__c = 'PARTNERS';
               
            }
            relatedParty2.Preliminary_Application_Reference__c = parId;
            rpList.add(relatedParty2);
            // insert relatedParty2;

            String OFFICERS_NAME,OFFICERS_Radio,OFFICERS_MAILING,OFFICERS_STATE,OFFICERS_CITY,OFFICERS_ZIP,OFFICERS_TELEPHONE,OFFICERS_OF_SHARES,OFFICERS_SS,OFFICERS_DRIVER_LICENSE='';
            if(Block11 != null){
                relatedParty3.Last_Name__c = Block11.containsKey('OFFICERS_NAME') ? (String)Block11.get('OFFICERS_NAME'):'';
                relatedParty3.For_Corporation_or_Partnership__c = Block11.containsKey('OFFICERS_Radio') ? (String)Block11.get('OFFICERS_Radio'):'';
                relatedParty3.Mailing_Address__c = Block11.containsKey('OFFICERS_MAILING') ? (String)Block11.get('OFFICERS_MAILING'):'';
                relatedParty3.Mailing_City__c = Block11.containsKey('OFFICERS_CITY') ? (String)Block11.get('OFFICERS_CITY'):'';
                relatedParty3.Mailing_State__c = Block11.containsKey('OFFICERS_STATE') ? (String)Block11.get('OFFICERS_STATE'):'';
                relatedParty3.Mailing_Zip__c = Block11.containsKey('OFFICERS_ZIP') ? Integer.valueOf(Block11.get('OFFICERS_ZIP')):0;
                relatedParty3.Phone_Number__c = Block11.containsKey('OFFICERS_TELEPHONE') ? String.valueOf(Block11.get('OFFICERS_TELEPHONE')):'';
                relatedParty3.Of_Shares__c = Block11.containsKey('OFFICERS_OF_SHARES') ? Integer.valueOf(Block11.get('OFFICERS_OF_SHARES')):0;
                relatedParty3.SS__c = Block11.containsKey('OFFICERS_SS') ? Integer.valueOf(Block11.get('OFFICERS_SS')):0;
                relatedParty3.Driver_License__c = Block11.containsKey('OFFICERS_DRIVER_LICENSE') ? Integer.valueOf(Block11.get('OFFOFFICERS_DRIVER_LICENSEICERS_SS')):0;
                relatedParty3.Type__c = 'OFFICERS';
               
            }
            relatedParty3.Preliminary_Application_Reference__c = parId;
            rpList.add(relatedParty3);
            // insert relatedParty3;

            String STOCKHOLDERS_NAME,STOCKHOLDERS_Radio,STOCKHOLDERS_MAILING,STOCKHOLDERS_CITY,STOCKHOLDERS_ZIP,STOCKHOLDERS_STATE,STOCKHOLDERS_TELEPHONE='';
            String STOCKHOLDERS_OF_SHARES,STOCKHOLDERS_SS,STOCKHOLDERS_DRIVER_LICENSE='';
            if(STOCKHOLDERS != null){
                relatedParty4.Last_Name__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_NAME') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_NAME'):'';
                relatedParty4.For_Corporation_or_Partnership__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_Radio') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_Radio'):'';
                relatedParty4.Mailing_Address__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_MAILING') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_MAILING'):'';
                relatedParty4.Mailing_City__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_CITY') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_CITY'):'';
                relatedParty4.Mailing_State__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_STATE') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_STATE'):'';
                relatedParty4.Mailing_Zip__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_ZIP') ? Integer.valueOf(STOCKHOLDERS.get('STOCKHOLDERS_ZIP')):0;
                relatedParty4.Phone_Number__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_TELEPHONE') ? String.valueOf(STOCKHOLDERS.get('STOCKHOLDERS_TELEPHONE')):'';
                relatedParty4.Of_Shares__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_OF_SHARES') ? Integer.valueOf(STOCKHOLDERS.get('STOCKHOLDERS_OF_SHARES')):0;
                relatedParty4.SS__c = STOCKHOLDERS.containsKey('STOCKHOLDERS_SS') ? Integer.valueOf(STOCKHOLDERS.get('STOCKHOLDERS_SS')):0;
                relatedParty4.Driver_License__c =   STOCKHOLDERS.containsKey('STOCKHOLDERS_DRIVER_LICENSE') ? Integer.valueOf(STOCKHOLDERS.get('STOCKHOLDERS_DRIVER_LICENSE')):0;
                relatedParty4.Type__c = 'STOCKHOLDERS';
        
            }
            relatedParty4.Preliminary_Application_Reference__c = parId;
            rpList.add(relatedParty4);
            // insert relatedParty4;

            String CHECKBOX,Sign_Name,SignLAO,LOTitle='';
            String Date1 = null;
            if(Block13 != null){
                Sign_Name = Block13.containsKey('Sign_Name') ? (String)Block13.get('Sign_Name'):'';
                SignLAO = Block13.containsKey('SignLAO') ? (String)Block13.get('SignLAO'):'';
                LOTitle = Block13.containsKey('LOTitle') ? (String)Block13.get('LOTitle'):'';
                Date1 = Block13.containsKey('Date1') ? (String)Block13.get('Date1'):null;
            }

            // PAR 
            upsert acc;
        //    newObj.Auto_Insurance_Carrier__c = LicenseType;
            newObj.Id = parId;
           newObj.Vehicle_Type_Id__c = VEHICLE_ID;
           newObj.Auto_Insurance_Policy_Number__c = Insurance_Policy_Number;
           newObj.SEATING_CAPACITY__c = SEATING_CAPACITY;
           newObj.Auto_Insurance_Carrier__c = Insurance_Carrier;
           newObj.Plate_new__c = PLATE;
           newObj.YEAR__c = Integer.valueOf(YEAR);
           newObj.MAKE__c = MAKE;
           newObj.HAS_THIS_VEHICLE_BEEN_STRETCHED__c = RadioVI1;
           newObj.IS_THIS_VEHICLE_WHEELCHAIR_ACCESSIBLE__c = RadioVI2;
           newObj.IF_YES_GIVE_THE_NAME_OF_THE_COACH_BUILD__c = TextVI1;
        //    newObj.Signature_Date__c = Date.valueOf(Date1);
           newObj.Signature_Title__c = LOTitle;
           newObj.Signature_Name__c = Sign_Name;
           newObj.Signature__c = SignLAO;
           newObj.Had_any_type_of_license_suspended__c = Radio7BQ == 'Yes'? true : false;
           newObj.Had_any_NYC_TLC_permit_with_your_name__c = Radio8BQ == 'Yes'? true : false;
           newObj.Applied_for_and_or_received__c = Radio9BQ == 'Yes'? true : false;
           newObj.BASE_LICENSE__c = Integer.valueOf(BASE_LICENSE);
           newObj.BASE_AUTHORITY_NAME__c = BASE_NAME;
           newObj.Business_Type__c = Radio10;
           newObj.SHL_PERMIT__c = SHL_PERMIT;
           newObj.SHL_PERMIT_ENTITY_NAME__c = SHL_PERMIT_ENTITY_NAME;
           newObj.TYPE_OF_SHL_PERMIT__c = TYPE_OF_SHL_PERMIT;
           newObj.Does_the_vehicle_have_less_than_500__c = Radio4FH;
           newObj.Is_the_vehicle_higher_than_7_feet__c = Radio5FH;
           newObj.Does_this_vehicle_weigh_over_8_500lbs__c = Radio6FH;

           //block 4 
           newObj.ARE_THE_PLATES_LISTED_ABOVE_CURRENTLY_ON__c = RadioVI1;
           newObj.HAS_THIS_VEHICLE_BEEN_STRETCHED__c = RadioVI2;
           newObj.IS_THIS_VEHICLE_WHEELCHAIR_ACCESSIBLE__c = RadioVI3;
           newObj.Status__c = 'Submitted';
            newObj.LicenseTypeId__c = '0eh5f000000sfAoAAI';
            newObj.BusinessAccountNameId = acc.Id;

            insert rpList;
            update newObj;
           System.debug('objID>>>>' + newObj.Id);
        }
        return null;
    }
}