public class UpdaetLicenseController {
    @AuraEnabled
    public static WrapperClass getLicenseDetails(String businessLicenseId) {
        try {
           List<BusinessLicense> bs = new List<BusinessLicense>([SELECT Id,Name,
           RegulatoryAuthorizationType.Name,License_Name__c,
           Account.Id,Licensee_Name__c,Account.Cell_Phone__c, Account.Telephone__c,Account.PersonEmail,License_Type__c,
           Account.Mailing_Building_Number__c, Account.PersonMailingStreet, Account.Mailing_Apartment_Number__c,
            Account.PersonMailingCity, Account.PersonMailingState, Account.PersonMailingPostalCode, Account.Mailing_Borough__c,
            Account.Residence_Building_Number__c,Account.Residence_Street__c, Account.Residence_Apartment_Number__c, 
            Account.Residence_City__c, Account.Residence_State__c,  Account.Residence_Zip_Code__c,  Account.Residence_Borough__c
            FROM BusinessLicense WHERE ID = :businessLicenseId LIMIT 1]);
           WrapperClass wc = new WrapperClass();
           wc.accountId = bs[0].Account.Id;
           wc.BusinessLicense = bs[0].Name;
           wc.LicenseName = bs[0].Licensee_Name__c;
           wc.LicenseType = bs[0].RegulatoryAuthorizationType.Name;

           wc.CellPhone = bs[0].Account.Cell_Phone__c;
           wc.TelePhone = bs[0].Account.Telephone__c;
           wc.Email = bs[0].Account.PersonEmail;

            wc.MBuilding = bs[0].Account.Mailing_Building_Number__c;
            wc.MStreet = bs[0].Account.PersonMailingStreet;
            wc.MApt = bs[0].Account.Mailing_Apartment_Number__c;
            wc.MCity = bs[0].Account.PersonMailingCity;
            wc.MState = bs[0].Account.PersonMailingState;
            wc.MZipcode = bs[0].Account.PersonMailingPostalCode;
            wc.MBorough = bs[0].Account.Mailing_Borough__c;

            wc.RBuilding = bs[0].Account.Residence_Building_Number__c;
            wc.RStreet = bs[0].Account.Residence_Street__c;
            wc.RApt = bs[0].Account.Residence_Apartment_Number__c;
            wc.RCity = bs[0].Account.Residence_City__c;
            wc.RState = bs[0].Account.Residence_State__c;
            wc.RZipcode = bs[0].Account.Residence_Zip_Code__c;
            wc.RBorough = bs[0].Account.Residence_Borough__c;
            
            return wc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string updateLicenseDetails(String accountId, String wrapperString) {
        try {
            System.debug('Input Params '+accountId +' wrapperString '+ wrapperString);
            Map<String, Object> wrapData = (Map<String, Object>)JSON.deserializeUntyped(wrapperString);
            System.debug('wrapData '+ wrapData);

            Account acc= new Account();
            acc.Id = accountId;
            if(wrapData.containsKey('Cell') && wrapData.get('Cell') != null) {
                acc.Cell_Phone__c = wrapData.get('Cell').toString();
            }

            if(wrapData.containsKey('Tel') && wrapData.get('Tel') != null) {
                acc.Telephone__c = wrapData.get('Tel').toString();
            }

            if(wrapData.containsKey('Email') && wrapData.get('Email') != null) {
                acc.PersonEmail = wrapData.get('Email').toString();
            }

            if(wrapData.containsKey('MBuilding') && wrapData.get('MBuilding') != null) {
                acc.Mailing_Building_Number__c = wrapData.get('MBuilding').toString();
            }

            if(wrapData.containsKey('MStreet') && wrapData.get('MStreet') != null) {
                acc.PersonMailingStreet = wrapData.get('MStreet').toString();
            }

            if(wrapData.containsKey('MApt') && wrapData.get('MApt') != null) {
                acc.Mailing_Apartment_Number__c = wrapData.get('MApt').toString();
            }

            if(wrapData.containsKey('MCity') && wrapData.get('MCity') != null) {
                acc.PersonMailingCity = wrapData.get('MCity').toString();
            }

            if(wrapData.containsKey('MState') && wrapData.get('MState') != null) {
                acc.PersonMailingState = wrapData.get('MState').toString();
            }

            if(wrapData.containsKey('MZip') && wrapData.get('MZip') != null) {
                acc.PersonMailingPostalCode = wrapData.get('MZip').toString();
            }

            if(wrapData.containsKey('MBorough') && wrapData.get('MBorough') != null){
                acc.Mailing_Borough__c = wrapData.get('MBorough').toString();
            }

            if(wrapData.containsKey('RBuilding') && wrapData.get('RBuilding') != null){
                acc.Residence_Building_Number__c = wrapData.get('RBuilding').toString();
            }

            if(wrapData.containsKey('RStreet') && wrapData.get('RStreet') != null){
                acc.Residence_Street__c = wrapData.get('RStreet').toString();
            }

            if(wrapData.containsKey('RApt') && wrapData.get('RApt') != null){
                acc.Residence_Apartment_Number__c = wrapData.get('RApt').toString();
            }

            if(wrapData.containsKey('RCity') && wrapData.get('RCity') != null){
                acc.Residence_City__c = wrapData.get('RCity').toString();
            }

            if(wrapData.containsKey('RState') && wrapData.get('RState') != null){
                acc.Residence_State__c = wrapData.get('RState').toString();
            }

            if(wrapData.containsKey('RZip') && wrapData.get('RZip') != null){
                acc.Residence_Zip_Code__c = wrapData.get('RZip').toString();
            }

            if(wrapData.containsKey('RBorough') && wrapData.get('RBorough') != null){
                acc.Residence_Borough__c = wrapData.get('RBorough').toString();
            }
            
            update acc;
            return 'SUCCESS';
        } catch (Exception e) {
            return 'ERROR';
        }
    }

    public class WrapperClass{
        @AuraEnabled
        public String accountId;
        @AuraEnabled
        public String BusinessLicense;
        @AuraEnabled
        public String LicenseType;
        @AuraEnabled
        public String LicenseName;

        @AuraEnabled
        public String CellPhone;
        @AuraEnabled
        public String TelePhone;
        @AuraEnabled
        public String Email;

        @AuraEnabled
        public String MBuilding;
        @AuraEnabled
        public String MStreet;
        @AuraEnabled
        public String MApt;
        @AuraEnabled
        public String MCity;
        @AuraEnabled
        public String MState;
        @AuraEnabled
        public String MZipcode;
        @AuraEnabled
        public String MBorough;

        @AuraEnabled
        public String RBuilding;
        @AuraEnabled
        public String RStreet;
        @AuraEnabled
        public String RApt;
        @AuraEnabled
        public String RCity;
        @AuraEnabled
        public String RState;
        @AuraEnabled
        public String RZipcode;
        @AuraEnabled
        public String RBorough;


    }
}
