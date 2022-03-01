@JsonAccess(serializable='always')
global without sharing class LPIPublicDriverApplicationController implements vlocity_ins.VlocityOpenInterface2{
    global String invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        if(methodName == 'createDriverApplication'){
           createIA(input, output);
        }
        if(methodName == 'createEmptyDriverApplication'){
            createPRA(input, output);
        }
        return null;
    }
    global void createPRA(Map<String, Object> input, Map<String, Object> output){
        String applicationType = (String)input.get('applicationType');
        String licenseType = (String)input.get('licenseType');
        PreliminaryApplicationRef par = new PreliminaryApplicationRef();
        par.Application_Type__c = applicationType;
        par.SavedApplicationUrl = 'N/A';
        par.ApplicationType = 'IndividualApplication';
        par.ApplicationName = 'Driver\'s License Application';
        insert par;
        output.put('newPARId', par.Id);

        Application_Document__c ad1 = new Application_Document__c();
        ad1.Document_Name__c = 'Driver\'s License Front';
        ad1.Application_Reference__c = par.Id;
        insert ad1;
        output.put('licenseFrontDocId', ad1.Id);

        Application_Document__c ad2 = new Application_Document__c();
        ad2.Document_Name__c = 'Driver\'s License Back';
        ad2.Application_Reference__c = par.Id;
        insert ad2;
        output.put('licenseBackDocId', ad2.Id);

        Application_Document__c ad3 = new Application_Document__c();
        ad3.Document_Name__c = 'Insurance';
        ad3.Application_Reference__c = par.Id;
        insert ad3;
        output.put('insuranceDocId', ad3.Id);
    }
    global void createIA(Map<String, Object> input, Map<String, Object> output){
		Map<String,Object> inputApply = (Map<String,Object>)input.get('apply');
        
        //PAR Fields
        String applicationType = '';
        String licenseType = '';
        String appliedLicenseBefore = '';
        String convictedOfDrunkDrive = '';
        String convictedForCrime = '';
        String driverLicenseNumber = '';
        String explanation = '';
        String licensingState = '';
        String primaryLanguage = '';
        String receivedLicenseBefore = '';
        applicationType = (String)input.get('applicationType');
        licenseType = (String)input.get('licenseType');
        appliedLicenseBefore = (String)inputApply.get('appliedLicenseBefore');
        convictedForCrime = (String)inputApply.get('convictedForCrime');
        convictedOfDrunkDrive = (String)inputApply.get('convictedOfDrunkDrive');
        driverLicenseNumber = (String)inputApply.get('driverLicenseNumber');
        explanation = (String)inputApply.get('explanation');
        licensingState = (String)inputApply.get('licensingState');
        primaryLanguage = (String)inputApply.get('primaryLanguage');
        receivedLicenseBefore = (String)inputApply.get('receivedLicenseBefore');
        
        //Account Fields
        String cellphone = '';
        String countryOfBirth = '';
        String dob = '';
        String email = '';
        String eyeColor = '';
        String firstName = '';
        String hairColor = '';
        String heightFeet = '';
        String heightInches = '';
        String lastName = '';
        String mailingAddressApartmentNumber = '';
        String mailingAddressBorough = '';
        String mailingAddressBuildingNumber = '';
        String mailingAddressCity = '';
        String mailingAddressState = '';
        String mailingAddressStreet = '';
        String mailingAddressZipCode = '';
        Boolean sameAsMailing = false;
        String sex = '';
        String ssn = '';
        String telephone = '';
        Decimal weight = 0;
        cellphone = (String)inputApply.get('cellphone');
        countryOfBirth = (String)inputApply.get('countryOfBirth');
        dob = (String)inputApply.get('dob');
        email = (String)inputApply.get('email');
        eyeColor = (String)inputApply.get('eyeColor');
        firstName = (String)inputApply.get('firstName');
        hairColor = (String)inputApply.get('hairColor');
        heightFeet = (String)inputApply.get('heightFeet');
        heightInches = (String)inputApply.get('heightInches');
        lastName = (String)inputApply.get('lastName');
        mailingAddressBorough = (String)inputApply.get('mailingAddress:borough');
        mailingAddressApartmentNumber = (String)inputApply.get('mailingAddress:apartmentNumber');
        mailingAddressBuildingNumber = (String)inputApply.get('mailingAddress:buildingNumber');
        mailingAddressCity = (String)inputApply.get('mailingAddress:city');
        mailingAddressState = (String)inputApply.get('mailingAddress:state');
        mailingAddressStreet = (String)inputApply.get('mailingAddress:street');
        mailingAddressZipCode = (String)inputApply.get('mailingAddress:zipCode');
        sameAsMailing = (Boolean)inputApply.get('sameAsMailing');
        sex = (String)inputApply.get('sex');
        ssn = (String)inputApply.get('ssn');
        telephone = (String)inputApply.get('telephone');
        weight = (Decimal)inputApply.get('weight');

        List<Account> accList = new List<Account>([
            SELECT Id, PersonEmail FROM Account WHERE PersonEmail =: email LIMIT 1
        ]);

        Account acc = new Account();
        //acc.Name = firstName+' '+lastName;
        //acc.Name='Test';
        if (accList.size()>0){
            acc.Id = accList[0].Id;
        }
        acc.FirstName = firstName;
        acc.LastName = lastName;
        acc.RecordTypeId = '0125f000000uMBJAA2';
        acc.Cell_Phone__c = cellphone;
        acc.Country_Of_Birth__c = countryOfBirth;
        acc.PersonBirthdate = Date.valueOf(dob);
        acc.PersonEmail = email;
        acc.Eye_Color__c = eyeColor;
        acc.FirstName = firstName;
        acc.Hair_Color__c = hairColor;
        acc.Height_in_Feet__c = heightFeet;
        acc.Height_in_Inches__c = heightInches;
        acc.LastName = lastName;
        acc.Mailing_Apartment_Number__c = mailingAddressApartmentNumber;
        acc.Mailing_Borough__c = mailingAddressBorough;
        acc.Mailing_Building_Number__c = mailingAddressBuildingNumber;
        acc.PersonMailingCity = mailingAddressCity;
        acc.PersonMailingStreet = mailingAddressStreet;
        acc.PersonMailingState = mailingAddressState;
        acc.PersonMailingPostalCode = mailingAddressZipCode;
        acc.Sex__c = sex;
        acc.vlocity_ins__SocialSecurityNumber__pc = ssn;
        acc.Telephone__c = telephone;
        acc.Weight_in_lbs__c = weight;
        upsert acc;

        PreliminaryApplicationRef par = new PreliminaryApplicationRef();
        par.Id = (String)input.get('PARId');
        par.Application_Type__c = applicationType;
        par.SavedApplicationUrl = 'N/A';
        par.ApplicationType = 'IndividualApplication';
        par.ApplicationName = 'Driver\'s License Application';
        par.Status__c = 'Submitted';
        par.BusinessAccountNameId = acc.Id;
        par.LicenseTypeId__c = '0eh5f000000sfAeAAI';
        par.RecordTypeId = '0125f000000uyJqAAI';
        par.License_Number__c = driverLicenseNumber;
        par.License_Explanation__c = explanation;
        par.Licensing_State__c = licensingState;
        par.Primary_Language__c = primaryLanguage;
        
        if(appliedLicenseBefore == 'Yes')
            par.Applied_NYC_TLC_licence_before__c = true;
        else if(appliedLicenseBefore == 'No')
            par.Applied_NYC_TLC_licence_before__c = false;

        if(convictedForCrime == 'Yes')
            par.Convicted_for_Crime__c = true;
        else if(convictedForCrime == 'No')
            par.Convicted_for_Crime__c = false;

        if(convictedOfDrunkDrive == 'Yes')
            par.Convicted_for_Drunk_Driving__c = true;
        else if(convictedOfDrunkDrive == 'No')
            par.Convicted_for_Drunk_Driving__c = false;

        if(receivedLicenseBefore == 'Yes')
            par.Received_NYC_TLC_licence_before__c = true;
        else if(receivedLicenseBefore == 'No')
            par.Received_NYC_TLC_licence_before__c = false;

        update par;

        RegulatoryAuthorizationType ra = ([
            SELECT Id, IssuingDepartment.ExternalId__c FROM RegulatoryAuthorizationType WHERE Id =: '0eh5f000000sfAeAAI' LIMIT 1
        ]);

        //creating case
        Case applicationCase = new Case();
        applicationCase.Origin = 'Web';
        applicationCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Application_Intake').getRecordTypeId();
        applicationCase.Authority__c = ra.IssuingDepartment.ExternalId__c;
        insert applicationCase;

        //Individual Application
        IndividualApplication mainApplication = new IndividualApplication();
        mainApplication.RecordTypeId = Schema.SObjectType.IndividualApplication.getRecordTypeInfosByDeveloperName().get('New_License').getRecordTypeId();
        mainApplication.Category = 'License';
        mainApplication.ApplicationType = 'New';
        mainApplication.AppliedDate = System.now();
        mainApplication.Status = 'Submitted';
        if(par.LicenseTypeId__c == '0eh5f000000sfAeAAI')
            mainApplication.RecordTypeId = '0125f000000uyOgAAI';    //forDriver License
        else
            mainApplication.RecordTypeId = '0125f000000uyOlAAI';    //forVehicle, It's not relevant here btw.
        mainApplication.LicenseTypeId = par.LicenseTypeId__c;
        mainApplication.AccountId = par.BusinessAccountNameId;
        mainApplication.SavedApplicationRefId = par.Id;
        mainApplication.ApplicationCaseId = applicationCase.Id;
        insert mainApplication;
        output.put('IAId', mainApplication.Id);

        List<Application_Document__c> appDocs = new List<Application_Document__c>([
            SELECT Id, Individual_Application__c, Application_Reference__c FROM Application_Document__c
            WHERE Application_Reference__c =: par.Id
        ]);
        for(Application_Document__c appDoc: appDocs){
            appDoc.Individual_Application__c = mainApplication.Id;
        }
        update appDocs;
    }
}