@JsonAccess(serializable='always')
global without sharing class FetchUserDetailsForPublicVehicle implements vlocity_ins.VlocityOpenInterface2{
    global String invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        if(methodName == 'createNewRecord'){
            PreliminaryApplicationRef newObj = new PreliminaryApplicationRef();
            String ApplicationType = (String)input.get('ApplicationType');
            String LicenseType = (String)input.get('LicenseType');
            newObj.Application_Type__c = ApplicationType;
            newObj.License_Type__c = LicenseType;
            newObj.SavedApplicationUrl = 'NewTestURL';
            newObj.ApplicationType = 'IndividualApplication';
            newObj.ApplicationName = 'Vehicle License Application';
            insert newObj;
            output.put('objectId',newObj.Id);
        }
        if(methodName == 'updateValues'){
            // PreliminaryApplicationRef newObj = new PreliminaryApplicationRef();
            // String ApplicationType = (String)input.get('ApplicationType');
            // String LicenseType = (String)input.get('LicenseType');
            // newObj.Application_Type__c = ApplicationType;
            // newObj.Licenswe_Type__c = LicenseType;
            // newObj.SavedApplicationUrl = 'NAanup';
            // newObj.ApplicationType = 'IndividualApplication';
            // newObj.ApplicationName = 'Vehicle License Application';
            String parId = (String)input.get('parId');
            System.debug('parId ' + parId);
            //PreliminaryApplicationRef newObj = [SELECT ID FROM PreliminaryApplicationRef WHERE ID =:id ];
            PreliminaryApplicationRef newObj = new PreliminaryApplicationRef();
            newObj.Id = parId;

            Map<String,Object> AppInfo = (Map<String,Object>)input.get('APPLICANT_INFORMATION');
            Map<String,Object> VehInfo = (Map<String,Object>)input.get('VEHICLE_INFORMATION');
            Map<String,Object> BaseAffInfo = (Map<String,Object>)input.get('BASE_AFFILIATION_INFORMATION');
            Map<String,Object> StreetHail = (Map<String,Object>)input.get('STREET_HAIL_LIVERY_PERMIT_AFFILIATION_INFORMATION');
            Map<String,Object> ForHire = (Map<String,Object>)input.get('FOR_HIRE_VEHICLES_ONLY');
            Map<String,Object> BackQues = (Map<String,Object>)input.get('BACKGROUND_QUESTIONNAIRE');
            Map<String,Object> ListOwner = (Map<String,Object>)input.get('LIST_ALL_OWNERS');
            Map<String,Object> Block1 = (Map<String,Object>)AppInfo.get('Block1');
            Map<String,Object> Block2 = (Map<String,Object>)AppInfo.get('Block2');
            Map<String,Object> Block3 = (Map<String,Object>)AppInfo.get('Block3');
            Map<String,Object> Block4 = (Map<String,Object>)VehInfo.get('Block4');
            Map<String,Object> Block5 = (Map<String,Object>)BaseAffInfo.get('Block5');
            Map<String,Object> Block6 = (Map<String,Object>)StreetHail.get('Block6');
            Map<String,Object> Block7 = (Map<String,Object>)ForHire.get('Block7');
            Map<String,Object> Block8 = (Map<String,Object>)BackQues.get('Block8');
            Map<String,Object> OWNERS = (Map<String,Object>)ListOwner.get('OWNERS');
            Map<String,Object> PARTNERS = (Map<String,Object>)ListOwner.get('PARTNERS');
            Map<String,Object> Block11 = (Map<String,Object>)ListOwner.get('Block11');
            Map<String,Object> STOCKHOLDERS = (Map<String,Object>)ListOwner.get('STOCKHOLDERS');
            Map<String,Object> Block13 = (Map<String,Object>)ListOwner.get('Block13');
            //System.debug('run>>> ',JSON.serialize(STOCKHOLDERS););
            System.debug('>>>>passed line 52');
            String Vehicle_Classification,TLC_License_number,First_name,lastName,DOB,MailAddress,City,State,Zip,Cell_phone,EIN,SS,Email_Address,Other_Telephone,Residence_Address='';
            String City1,State1,Zip1,Business_Type='';
            if (Block1 != null) {
                Vehicle_Classification = Block1.containsKey('Vehicle_Classification') ? (String)Block1.get('Vehicle_Classification'):'';
                // TLC_License_number = Block1.containsKey('TLC_License_number') ? (String)Block1.get('TLC_License_number'):'';
            }
            if (Block2 != null) {
                First_name = Block2.containsKey('First_name') ? (String)Block2.get('First_name'):'';
                lastName = Block2.containsKey('lastName') ? (String)Block2.get('lastName'):'';
                DOB = Block2.containsKey('DOB') ? (String)Block2.get('DOB'):'';
                MailAddress = Block2.containsKey('MailAddress') ? (String)Block2.get('MailAddress'):'';
                City = Block2.containsKey('City') ? (String)Block2.get('City'):'';
                State = Block2.containsKey('State') ? (String)Block2.get('State'):'';
                Zip = Block2.containsKey('Zip') ? (String)Block2.get('Zip'):'';
                Cell_phone = Block2.containsKey('Cell_phone') ? (String)Block2.get('Cell_phone'):'';
                EIN = Block2.containsKey('EIN') ? (String)Block2.get('EIN'):'';
                SS = Block2.containsKey('SS') ? (String)Block2.get('SS'):'';
                Email_Address = Block2.containsKey('Email_Address') ? (String)Block2.get('Email_Address'):'';
                Other_Telephone = Block2.containsKey('Other_Telephone') ? (String)Block2.get('Other_Telephone'):'';
            }
            if (Block3 != null) {
                Residence_Address = Block3.containsKey('Residence_Address') ? (String)Block3.get('Residence_Address'):'';
                City1 = Block3.containsKey('City1') ? (String)Block3.get('City1'):'';
                State1 = Block3.containsKey('State_') ? (String)Block3.get('State1'):'';
                Zip1 = Block3.containsKey('Zip1') ? (String)Block3.get('Zip1'):'';
                Business_Type = Block3.containsKey('Business_Type') ? (String)Block3.get('Business_Type'):'';
            }


            String VEHICLE_ID,SEATING_CAPACITY,PLATE,YEAR,MAKE,RadioVI1,RadioVI2,RadioVI3,TextVI1='';
            //done
            if (Block4 != null) {
                VEHICLE_ID = Block4.containsKey('VEHICLE_ID') ? (String)Block4.get('VEHICLE_ID'):'';
                SEATING_CAPACITY = Block4.containsKey('SEATING_CAPACITY') ? (String)Block4.get('SEATING_CAPACITY'):'';
                PLATE = Block4.containsKey('PLATE') ? (String)Block4.get('PLATE'):'';
                YEAR = Block4.containsKey('YEAR') ? (String)Block4.get('YEAR'):'';
                MAKE = Block4.containsKey('MAKE') ? (String)Block4.get('MAKE'):'';
                RadioVI1 = Block4.containsKey('RadioVI1') ? (String)Block4.get('RadioVI1'):'';
                RadioVI2 = Block4.containsKey('RadioVI2') ? (String)Block4.get('RadioVI2'):'';
                RadioVI3 = Block4.containsKey('RadioVI3') ? (String)Block4.get('RadioVI3'):'';
                TextVI1 = Block4.containsKey('TextVI1') ? (String)Block4.get('TextVI1'):'';
            }
            String BASE_NAME,BASE_LICENSE='';
            if(Block5 != null){
                BASE_NAME = Block5.containsKey('BASE_NAME') ? (String)Block5.get('BASE_NAME'):'';
                BASE_LICENSE = Block5.containsKey('BASE_LICENSE') ? (String)Block5.get('BASE_LICENSE'):'';
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
                OWNERS_NAME = OWNERS.containsKey('OWNERS_NAME') ? (String)OWNERS.get('OWNERS_NAME'):'';
                OWNERS_Radio = OWNERS.containsKey('OWNERS_Radio') ? (String)OWNERS.get('OWNERS_Radio'):'';
                OWNERS_MAILING = OWNERS.containsKey('OWNERS_MAILING') ? (String)OWNERS.get('OWNERS_MAILING'):'';
                OWNERS_CITY = OWNERS.containsKey('OWNERS_CITY') ? (String)OWNERS.get('OWNERS_CITY'):'';
                OWNERS_STATE = OWNERS.containsKey('OWNERS_STATE') ? (String)OWNERS.get('OWNERS_STATE'):'';
                OWNERS_ZIP = OWNERS.containsKey('OWNERS_ZIP') ? (String)OWNERS.get('OWNERS_ZIP'):'';
                OWNERS_TELEPHONE = OWNERS.containsKey('OWNERS_TELEPHONE') ? (String)OWNERS.get('OWNERS_TELEPHONE'):'';
                OWNER_OF_SHARES = OWNERS.containsKey('OWNER_OF_SHARES') ? (String)OWNERS.get('OWNER_OF_SHARES'):'';
                OWNER_SS = OWNERS.containsKey('OWNER_SS') ? (String)OWNERS.get('OWNER_SS'):'';
                OWNER_DRIVER_LICENSE = OWNERS.containsKey('OWNER_DRIVER_LICENSE') ? (String)OWNERS.get('OWNER_DRIVER_LICENSE'):'';
            }
            String PARTNERS_NAME,PARTNERS_Radio,PARTNERS_MAILING,PARTNERS_CITY,PARTNERS_STATE,PARTNERS_ZIP,PARTNERS_TELEPHONE,PARTNERS_OF_SHARES,PARTNERS_SS,PARTNERS_DRIVER_LICENSE='';
            if(PARTNERS != null){
                PARTNERS_NAME = PARTNERS.containsKey('PARTNERS_NAME') ? (String)PARTNERS.get('PARTNERS_NAME'):'';
                PARTNERS_Radio = PARTNERS.containsKey('PARTNERS_Radio') ? (String)PARTNERS.get('PARTNERS_Radio'):'';
                PARTNERS_MAILING = PARTNERS.containsKey('PARTNERS_MAILING') ? (String)PARTNERS.get('PARTNERS_MAILING'):'';
                PARTNERS_CITY = PARTNERS.containsKey('PARTNERS_CITY') ? (String)PARTNERS.get('PARTNERS_CITY'):'';
                PARTNERS_STATE = PARTNERS.containsKey('PARTNERS_STATE') ? (String)PARTNERS.get('PARTNERS_STATE'):'';
                PARTNERS_ZIP = PARTNERS.containsKey('PARTNERS_ZIP') ? (String)PARTNERS.get('PARTNERS_ZIP'):'';
                PARTNERS_TELEPHONE = PARTNERS.containsKey('PARTNERS_TELEPHONE') ? (String)PARTNERS.get('PARTNERS_TELEPHONE'):'';
                PARTNERS_OF_SHARES = PARTNERS.containsKey('PARTNERS_OF_SHARES') ? (String)PARTNERS.get('PARTNERS_OF_SHARES'):'';
                PARTNERS_SS = PARTNERS.containsKey('PARTNERS_SS') ? (String)PARTNERS.get('PARTNERS_SS'):'';
                PARTNERS_DRIVER_LICENSE = PARTNERS.containsKey('PARTNERS_DRIVER_LICENSE') ? (String)PARTNERS.get('PARTNERS_DRIVER_LICENSE'):'';
                // PARTNERS_OF_SHARES = PARTNERS.containsKey('PARTNERS_OF_SHARES') ? (String)PARTNERS.get('PARTNERS_OF_SHARES'):'';
               
            }
            String OFFICERS_NAME,OFFICERS_Radio,OFFICERS_MAILING,OFFICERS_STATE,OFFICERS_CITY,OFFICERS_ZIP,OFFICERS_TELEPHONE,OFFICERS_OF_SHARES,OFFICERS_SS,OFFICERS_DRIVER_LICENSE='';
            if(Block11 != null){
                OFFICERS_NAME = Block11.containsKey('OFFICERS_NAME') ? (String)Block11.get('OFFICERS_NAME'):'';
                OFFICERS_Radio = Block11.containsKey('OFFICERS_Radio') ? (String)Block11.get('OFFICERS_Radio'):'';
                OFFICERS_MAILING = Block11.containsKey('OFFICERS_MAILING') ? (String)Block11.get('OFFICERS_MAILING'):'';
                OFFICERS_CITY = Block11.containsKey('OFFICERS_CITY') ? (String)Block11.get('OFFICERS_CITY'):'';
                OFFICERS_STATE = Block11.containsKey('OFFICERS_STATE') ? (String)Block11.get('OFFICERS_STATE'):'';
                OFFICERS_ZIP = Block11.containsKey('OFFICERS_ZIP') ? (String)Block11.get('OFFICERS_ZIP'):'';
                OFFICERS_TELEPHONE = Block11.containsKey('OFFICERS_TELEPHONE') ? (String)Block11.get('OFFICERS_TELEPHONE'):'';
                OFFICERS_OF_SHARES = Block11.containsKey('OFFICERS_OF_SHARES') ? (String)Block11.get('OFFICERS_OF_SHARES'):'';
                OFFICERS_SS = Block11.containsKey('OFFICERS_SS') ? (String)Block11.get('OFFICERS_SS'):'';
                OFFICERS_DRIVER_LICENSE = Block11.containsKey('OFFICERS_DRIVER_LICENSE') ? (String)Block11.get('OFFOFFICERS_DRIVER_LICENSEICERS_SS'):'';
               
            }
            String STOCKHOLDERS_NAME,STOCKHOLDERS_Radio,STOCKHOLDERS_MAILING,STOCKHOLDERS_CITY,STOCKHOLDERS_ZIP,STOCKHOLDERS_STATE,STOCKHOLDERS_TELEPHONE='';
            String STOCKHOLDERS_OF_SHARES,STOCKHOLDERS_SS,STOCKHOLDERS_DRIVER_LICENSE='';
            if(STOCKHOLDERS != null){
                STOCKHOLDERS_NAME = STOCKHOLDERS.containsKey('STOCKHOLDERS_NAME') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_NAME'):'';
                STOCKHOLDERS_Radio = STOCKHOLDERS.containsKey('STOCKHOLDERS_Radio') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_Radio'):'';
                STOCKHOLDERS_MAILING = STOCKHOLDERS.containsKey('STOCKHOLDERS_MAILING') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_MAILING'):'';
                STOCKHOLDERS_CITY = STOCKHOLDERS.containsKey('STOCKHOLDERS_CITY') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_CITY'):'';
                STOCKHOLDERS_STATE = STOCKHOLDERS.containsKey('STOCKHOLDERS_STATE') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_STATE'):'';
                STOCKHOLDERS_ZIP = STOCKHOLDERS.containsKey('STOCKHOLDERS_ZIP') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_ZIP'):'';
                STOCKHOLDERS_TELEPHONE = STOCKHOLDERS.containsKey('STOCKHOLDERS_TELEPHONE') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_TELEPHONE'):'';
                STOCKHOLDERS_OF_SHARES = STOCKHOLDERS.containsKey('STOCKHOLDERS_OF_SHARES') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_OF_SHARES'):'';
                STOCKHOLDERS_SS = STOCKHOLDERS.containsKey('STOCKHOLDERS_SS') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_SS'):'';
                STOCKHOLDERS_DRIVER_LICENSE = STOCKHOLDERS.containsKey('STOCKHOLDERS_DRIVER_LICENSE') ? (String)STOCKHOLDERS.get('STOCKHOLDERS_DRIVER_LICENSE'):'';
            }
            //done
            String CHECKBOX,Sign_Name,SignLAO,LOTitle,Date1='';
            if(Block13 != null){
                CHECKBOX = Block13.containsKey('CHECKBOX') ? (String)Block13.get('CHECKBOX'):'';
                Sign_Name = Block13.containsKey('Sign_Name') ? (String)Block13.get('Sign_Name'):'';
                SignLAO = Block13.containsKey('SignLAO') ? (String)Block13.get('SignLAO'):'';
                LOTitle = Block13.containsKey('LOTitle') ? (String)Block13.get('LOTitle'):'';
                Date1 = Block13.containsKey('Date1') ? (String)Block13.get('Date1'):'';
            }
           // return (String)newObj.id;
           //newObj.Auto_Insurance_Carrier__c = LicenseType;
           newObj.Vehicle_Type_Id__c = VEHICLE_ID;
           newObj.SEATING_CAPACITY__c = SEATING_CAPACITY;
           newObj.Plate_new__c = PLATE;
           newObj.YEAR__c = Integer.valueof(YEAR);
           newObj.MAKE__c = MAKE;
           newObj.HAS_THIS_VEHICLE_BEEN_STRETCHED__c = RadioVI1;
           newObj.IS_THIS_VEHICLE_WHEELCHAIR_ACCESSIBLE__c = RadioVI2;
           newObj.IF_YES_GIVE_THE_NAME_OF_THE_COACH_BUILD__c = TextVI1;
           newObj.Signature_Date__c = Date.valueOf(Date1);
           newObj.Signature_Title__c = LOTitle;
           newObj.Signature_Name__c = Sign_Name;
           newObj.Signature__c = SignLAO;
           newObj.Had_any_type_of_license_suspended__c = Radio7BQ == 'Yes'? true : false;
           newObj.Had_any_NYC_TLC_permit_with_your_name__c = Radio8BQ == 'Yes'? true : false;
           newObj.Applied_for_and_or_received__c = Radio9BQ == 'Yes'? true : false;
        //    newObj.BASE_LICENSE__c = Integer.valueof(BASE_LICENSE);
        //    newObj.BASE_AUTHORITY_NAME__c = BASE_NAME;
           newObj.Business_Type__c = Radio10;
           newObj.SHL_PERMIT__c = SHL_PERMIT;
           newObj.SHL_PERMIT_ENTITY_NAME__c = SHL_PERMIT_ENTITY_NAME;
           newObj.TYPE_OF_SHL_PERMIT__c = TYPE_OF_SHL_PERMIT;
           newObj.Does_the_vehicle_have_less_than_500__c = Radio4FH;
           newObj.Is_the_vehicle_higher_than_7_feet__c = Radio5FH;
           newObj.Does_this_vehicle_weigh_over_8_500lbs__c = Radio6FH;
           update newObj;
           output.put('updatedObjId',newObj.Id);
        }
        return null;
    }
}