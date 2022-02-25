global without sharing class PublicComplaintController implements vlocity_ins.VlocityOpenInterface{
    public PublicComplaintController(){}
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){
        Boolean result = false;
        try{
            system.debug('inputMap::' + json.serialize(inputMap));
            if(methodName=='createCaseAndRelatedData'){
                String caseNumber = createCaseAndRelatedData(inputMap,outMap);
                outMap.put('casenumber',caseNumber);
            }
            if(methodName=='createcase'){
                String caseid = (String)inputMap.get('caseid');
                if(caseid!=null) {
                    Case objCase = [Select Id,AccountId,Profession_Name__c,Name_of_Licensee__c,License_If_Known__c,Address_Line_1_Incident__c,Address_Line_2_Incident__c,
                                    City_Incident__c,State_Area__c,Postal_Code_Incident__c,Consulted_an_Attorney__c,Reported_to_Agency__c,Complaint_with_Licensee__c,
                                    Description,Signature__c,is_Acknowledged__c,Name_of_the_Business_If_Known__c,
                                    (Select Id,Date__c from Dates_of_Incidents__r),
                                    (Select Id,Address__c,Email__c,Name,Phone__c,Title__c from Witnesses__r),
                                    (Select Id,Address__c,Email__c,Name,Phone__c from Attorneys__r),
                                    (Select Id,Contact_Name__c,Email__c,Name,Phone__c from Agencies__r) from Case where Id=:caseid];
                    outMap.put('ProfessionName',objCase.Profession_Name__c);
                    outMap.put('NameLicensee',objCase.Name_of_Licensee__c);
                    outMap.put('LicenseeNo',objCase.License_If_Known__c);
                    outMap.put('AddressLine1',objCase.Address_Line_1_Incident__c);
                    outMap.put('AddressLine2',objCase.Address_Line_2_Incident__c);
                    outMap.put('City',objCase.City_Incident__c);
                    outMap.put('State',objCase.State_Area__c);
                    outMap.put('ZipCode',objCase.Postal_Code_Incident__c);
                    outMap.put('consultedAttorneyMatter',objCase.Consulted_an_Attorney__c?'Yes':'No');
                    outMap.put('ComplaintReportedAgencies',objCase.Reported_to_Agency__c?'Yes':'No');
                    outMap.put('AttemptedResolveLicensee',objCase.Complaint_with_Licensee__c?'Yes':'No');
                    outMap.put('ComplaintDescription',objCase.Description);
                    outMap.put('SignatureAttestation',objCase.Signature__c);
                    outMap.put('Disclosure1',objCase.is_Acknowledged__c);
                    outMap.put('NameBusiness',objCase.Name_of_the_Business_If_Known__c);
                    
                    Account objAcc = [Select Id,PersonContactId,FirstName,LastName,PersonEmail,PersonHomePhone,PersonOtherPhone,Phone,
                              PersonMobilePhone,PersonMailingStreet,PersonMailingCountry,PersonMailingCity,PersonMailingState,
                              PersonMailingPostalCode from Account where Id=:objCase.AccountId];
                    outMap.put('FirstName',objAcc.FirstName);
                    outMap.put('LastName',objAcc.LastName);
                    outMap.put('HomePhone',objAcc.PersonHomePhone);
                    outMap.put('OtherPhone',objAcc.PersonOtherPhone);
                    outMap.put('Businessphone',objAcc.Phone);
                    outMap.put('Mobilephone',objAcc.PersonMobilePhone);
                    outMap.put('Email',objAcc.PersonEmail);
                    outMap.put('ContactAddressLine1',objAcc.PersonMailingStreet);
                    outMap.put('ContactAddressLine2',objAcc.PersonMailingCountry);
                    outMap.put('ContactCity',objAcc.PersonMailingCity);
                    outMap.put('ContactState',objAcc.PersonMailingState);
                    outMap.put('ContactZipCode',objAcc.PersonMailingPostalCode);
                    List<Map<String,Date>> mapOfDatOfIncidents = new List<Map<String,Date>>();
                    for(Date_of_Incidents__c obj: objCase.Dates_of_Incidents__r) {
                        Map<String,Date> ins = new Map<String,Date>();
                        ins.put('DateIncident',obj.Date__c);
                        mapOfDatOfIncidents.add(ins);
                    }
                    outMap.put('ListDateIncident',mapOfDatOfIncidents);
                    
                    List<Map<String,String>> mapOfDatOfWitnesses = new List<Map<String,String>>();
                    for(Witness__c obj: objCase.Witnesses__r) {
                        Map<String,String> ins = new Map<String,String>();
                        ins.put('WitnessAddress',obj.Address__c);
                        ins.put('WitnessEmail',obj.Email__c);
                        ins.put('WitnessName',obj.Name);
                        ins.put('WitnessPhone',obj.Phone__c);
                        ins.put('WitnessTitle',obj.Title__c);
                        mapOfDatOfWitnesses.add(ins);
                    }
                    outMap.put('WitnessesObservers',mapOfDatOfWitnesses);
                    
                    List<Map<String,String>> mapOfAttorneys = new List<Map<String,String>>();
                    for(Attorney__c obj: objCase.Attorneys__r) {
                        Map<String,String> ins = new Map<String,String>();
                        ins.put('AttorneyAddress',obj.Address__c);
                        ins.put('AttorneyEmail',obj.Email__c);
                        ins.put('AttorneyName',obj.Name);
                        ins.put('AttorneyPhone',obj.Phone__c);
                        mapOfAttorneys.add(ins);
                    }
                    outMap.put('ListAttorneys',mapOfAttorneys);
                    
                    List<Map<String,String>> mapOfAgencies = new List<Map<String,String>>();
                    for(Agency__c obj: objCase.Agencies__r) {
                        Map<String,String> ins = new Map<String,String>();
                        ins.put('AgencyContactName',obj.Contact_Name__c);
                        ins.put('AgencyEmail',obj.Email__c);
                        ins.put('AgencyName',obj.Name);
                        ins.put('AgencyPhone',obj.Phone__c);
                        mapOfAgencies.add(ins);
                    }
                    outMap.put('ListAgencies',mapOfAgencies);
                } else {
                    String caseidNew = createCase();
                    outMap.put('caseid',caseidNew); 
                }
            }
            if(methodName=='fetchcases'){
                List<Map<String,String>>  lstCases = fetchCase(inputMap);
                outMap.put('cases',lstCases);
            }
            result = true;
        }catch(Exception e) {
            system.debug('The error is ' + e.getMessage());
        }
        return result;
    }
    private static String createCase(){
        RecordType caseRecType = [Select id from RecordType where sObjectType = 'Case' and DeveloperName ='Amendment_Request' limit 1];
        Case objCase = new Case(RecordTypeId=caseRecType.Id,Status='Draft');
        insert objCase;
        return objCase.Id;
    }
    private static List<Map<String,String>> fetchCase(Map<String,Object> inputMap){
        List<Map<String,String>> lstToReturn= new List<Map<String,String>>();
        if(Auth.CommunitiesUtil.isGuestUser()){
            return lstToReturn;
        }
        User objUser = [Select Id,AccountId,ContactId from User where Id=:userinfo.getUserId()];    
        for(Case obj: [Select Id, CaseNumber,Profession_Name__c,Name_of_Licensee__c,CreatedDate,Status,Resume_Link__c from Case where AccountId=:objUser.AccountId or ContactId=:objUser.ContactId or CreatedById=:objUser.Id order by createddate desc]){
            Map<String,String> mapOfKepPair = new Map<String,String>();
            mapOfKepPair.put('CaseNumber',obj.CaseNumber);
            mapOfKepPair.put('Profession_Name__c',obj.Profession_Name__c);
            mapOfKepPair.put('Name_of_Licensee__c',obj.Name_of_Licensee__c);
            mapOfKepPair.put('CreatedDate', ''+obj.CreatedDate.date());
            mapOfKepPair.put('Status', obj.Status);
            mapOfKepPair.put('URL', obj.Status=='Draft'?(obj.Resume_Link__c!=null?obj.Resume_Link__c:'https://mtxlpi.force.com/bcd/s/file-a-complaint-public?caseid='+obj.Id):'https://mtxlpi.force.com/bcd/s/preview-complaint?caseid='+obj.Id);
            lstToReturn.add(mapOfKepPair);
        }
        return lstToReturn;
    }
    private static String createCaseAndRelatedData(Map<String,Object> inputMap, Map<String,Object> outMap){
        String caseid = (String)inputMap.get('caseid');
        Map<String,Object>  ComplaintForm = (Map<String,Object> )inputMap.get('ComplaintForm');
        String ProfessionName = (String)ComplaintForm.get('ProfessionName');
        String NameLicensee = (String)ComplaintForm.get('NameLicensee');
        String LicenseeNo = (String)ComplaintForm.get('LicenseeNo');
        String AddressLine1 = (String)((Map<String,Object>)ComplaintForm.get('Address'))?.get('AddressLine1');
        String AddressLine2 = (String)((Map<String,Object>)ComplaintForm.get('Address'))?.get('AddressLine2');
        String City = (String)((Map<String,Object>)ComplaintForm.get('Address'))?.get('City');
        String State = (String)((Map<String,Object>)ComplaintForm.get('Address'))?.get('State');
        String ZipCode = (String)((Map<String,Object>)ComplaintForm.get('Address'))?.get('ZipCode');
        String NameBusiness = (String)ComplaintForm.get('NameBusiness');
        
        Map<String,Object> ContactInformation = (Map<String,Object> )ComplaintForm.get('ContactInformation');
        String FirstName = (String)ContactInformation.get('FirstName');
        String LastName = (String)ContactInformation.get('LastName');
        String HomePhone = (String)ContactInformation.get('HomePhone');
        String OtherPhone = (String)ContactInformation.get('OtherPhone');
        String Businessphone = (String)ContactInformation.get('Businessphone');
        String Mobilephone = (String)ContactInformation.get('Mobilephone');
        String Email = (String)ContactInformation.get('Email');
        String ContactAddressLine1 = (String)((Map<String,Object>)ContactInformation.get('ContactAddress'))?.get('ContactAddressLine1');
        String ContactAddressLine2 = (String)((Map<String,Object>)ContactInformation.get('ContactAddress'))?.get('ContactAddressLine2');
        String ContactCity = (String)((Map<String,Object>)ContactInformation.get('ContactAddress'))?.get('ContactCity');
        String ContactState = (String)((Map<String,Object>)ContactInformation.get('ContactAddress'))?.get('ContactState');
        String ContactZipCode = (String)((Map<String,Object>)ContactInformation.get('ContactAddress'))?.get('ContactZipCode');
        
        List<Contact> lstExisting = [Select Id,AccountId from Contact where FirstName=:FirstName and LastName=:LastName and Email=:Email];
        String accountId;
        String contactId;
        if(lstExisting==null || lstExisting.isEmpty()){
            RecordType accRecTypeId = [Select id from RecordType where sObjectType = 'Account' and DeveloperName ='PersonAccount' limit 1];
            Account objAccount = new Account(FirstName=FirstName,LastName=LastName,PersonEmail=Email,
                                             PersonHomePhone=HomePhone,PersonOtherPhone=OtherPhone,
                                             Phone=Businessphone,PersonMobilePhone=Mobilephone,
                                             PersonMailingStreet=ContactAddressLine1,PersonMailingCountry=ContactAddressLine2,
                                             PersonMailingCity=ContactCity,PersonMailingState=ContactState,
                                             PersonMailingPostalCode=ContactZipCode,RecordTypeId=accRecTypeId.Id);
            insert objAccount;
            Account aa = [Select Id,PersonContactId from Account where Id=:objAccount.Id];
            accountId = aa.Id;
            contactId = aa.PersonContactId;
        } else {
            accountId = lstExisting[0].AccountId;
            contactId = lstExisting[0].Id;
        }
        Map<String,Object>  ComplaintDetails = (Map<String,Object>)inputMap.get('ComplaintDetails');
        String AttemptedResolveLicensee = (String)ComplaintDetails.get('AttemptedResolveLicensee');
        String consultedAttorneyMatter = (String)ComplaintDetails.get('consultedAttorneyMatter');
        String ComplaintReportedAgencies = (String)ComplaintDetails.get('ComplaintReportedAgencies');
        List<Object> ListDateIncident;
        if(ComplaintDetails.containskey('ListDateIncident')) {
            try {
                ListDateIncident = (List<Object>)ComplaintDetails.get('ListDateIncident');
            } catch(Exception exp) {
                ListDateIncident = new List<Object>{(Object)ComplaintDetails.get('ListDateIncident')};
            }
        }
        
        List<Object> WitnessesObservers;
        if(ComplaintDetails.containskey('WitnessesObservers')) {
            try {
               WitnessesObservers = (List<Object>)ComplaintDetails.get('WitnessesObservers');
            } catch(Exception exp) {
                WitnessesObservers = new List<Object>{(Object)ComplaintDetails.get('WitnessesObservers')};
            }
        }
        
        List<Object> ListAttorneys;
        if(ComplaintDetails.containskey('ListAttorneys')) {
            try {
               ListAttorneys = (List<Object>)ComplaintDetails.get('ListAttorneys');
            } catch(Exception exp) {
                ListAttorneys = new List<Object>{(Object)ComplaintDetails.get('ListAttorneys')};
            }
        }
        
        List<Object> ListAgencies;
        if(ComplaintDetails.containskey('ListAgencies')) {
            try {
               ListAgencies = (List<Object>)ComplaintDetails.get('ListAgencies');
            } catch(Exception exp) {
                ListAgencies = new List<Object>{(Object)ComplaintDetails.get('ListAgencies')};
            }
        }
        Map<String,Object>  ComplaintNarrative = (Map<String,Object> )inputMap.get('ComplaintNarrative');
        String ComplaintDescription = (String)ComplaintNarrative.get('ComplaintDescription');
        String SignatureAttestation = (String)ComplaintNarrative.get('SignatureAttestation');
        
        List<BusinessLicense> onBL;
        if(LicenseeNo!=null) {
           onBL = [Select Id,Name from BusinessLicense where Name=:LicenseeNo limit 1]; 
        }
        RecordType caseRecType = [Select id from RecordType where sObjectType = 'Case' and DeveloperName ='Complaint' limit 1];
        Case objCase = new Case(Id=caseid,AccountId=accountId, contactId=contactId, Profession_Name__c=ProfessionName,
                                Name_of_Licensee__c=NameLicensee, License_If_Known__c=LicenseeNo,
                                Address_Line_1_Incident__c=AddressLine1,Address_Line_2_Incident__c=AddressLine2,
                                City_Incident__c=City,State_Area__c=State,Postal_Code_Incident__c=ZipCode,
                                Consulted_an_Attorney__c=(consultedAttorneyMatter=='yes'?true:false),
                                Reported_to_Agency__c=(ComplaintReportedAgencies=='yes'?true:false),
                                Complaint_with_Licensee__c=(AttemptedResolveLicensee=='yes'?true:false),
                                Description=ComplaintDescription,Signature__c=SignatureAttestation,is_Acknowledged__c=true,
                               Name_of_the_Business_If_Known__c=NameBusiness,Status='Submitted',RecordTypeId=caseRecType.Id,
                               Business_License__c = ((onBL!=null&&!onBL.isEmpty())?onBL[0].Id:null));
        upsert objCase;
        
        if(ListDateIncident!=null && !ListDateIncident.isEmpty()) {
            List<Date_of_Incidents__c> lstDates = new List<Date_of_Incidents__c>();
            for(Object obj : ListDateIncident) {
                Map<String,Object> objdate = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(obj));
                lstDates.add(new Date_of_Incidents__c(Case__c=objCase.Id,Date__c=Date.valueOf((String)objdate.get('DateIncident'))));
            }
            insert lstDates;
        }
        if(WitnessesObservers!=null && !WitnessesObservers.isEmpty()) {
            List<Witness__c> lstWitness = new List<Witness__c>();
            for(Object obj : WitnessesObservers) {
                Map<String,Object> objWitness = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(obj));
                lstWitness.add(new Witness__c(Case__c=objCase.Id,Address__c=(String)objWitness.get('WitnessAddress'),
                                              Email__c=(String)objWitness.get('WitnessEmail'),
                                              Name=(String)objWitness.get('WitnessName'),
                                              Phone__c=(String)objWitness.get('WitnessPhone'),
                                              Title__c=(String)objWitness.get('WitnessTitle')));
            }
            insert lstWitness;
        }
        if(ListAttorneys!=null && !ListAttorneys.isEmpty()) {
            List<Attorney__c> lstAttorney = new List<Attorney__c>();
            for(Object obj : ListAttorneys) {
                Map<String,Object> objAttorney = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(obj));
                lstAttorney.add(new Attorney__c(Case__c=objCase.Id,Address__c=(String)objAttorney.get('AttorneyAddress'),
                                              Email__c=(String)objAttorney.get('AttorneyEmail'),
                                              Name=(String)objAttorney.get('AttorneyName'),
                                              Phone__c=(String)objAttorney.get('AttorneyPhone')));
            }
            insert lstAttorney;
        }
        if(ListAgencies!=null && !ListAgencies.isEmpty()) {
            List<Agency__c> lstAgency = new List<Agency__c>();
            for(Object obj : ListAgencies) {
                Map<String,Object> objAgency = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(obj));
                lstAgency.add(new Agency__c(Case__c=objCase.Id,Contact_Name__c=(String)objAgency.get('AgencyContactName'),
                                              Email__c=(String)objAgency.get('AgencyEmail'),
                                              Name=(String)objAgency.get('AgencyName'),
                                              Phone__c=(String)objAgency.get('AgencyPhone')));
            }
            insert lstAgency;
        }
        Case objCaseToReturn = [Select Id,CaseNumber from Case where Id=:objCase.Id];
        return objCaseToReturn.CaseNumber;
    }
}