/**
* @description       : Redirect user to CyberSource Portal with required data as needed.
* @author            : Wasef Mohiuddin
* @group             : MTX
* @last modified on  : 09-28-2021
* @last modified by  : Wasef Mohiuddin
* Modifications Log 
* Ver   Date         Author            Modification
* 1.0   05-26-2021   Wasef Mohiuddin   Initial Version
* 2.0   09-28-2021   Wasef Mohiuddin   Added Comments and Method Descriptions
**/
public with sharing class CyberSourceController {
    
    // Global Variables and their Definitions to be used in the entire class
    private Map<String, String> oPassedParams = new Map<String, String>();
    private String reference_number {get;set;} 
    private String issuer_additional_data{get;set;}
    public String payment_method {get;set;}
    public String bill_to_company_name {get;set;}
    public String bill_to_forename {get;set;}
    public String bill_to_surname {get;set;}
    public String bill_to_email {get;set;}
    public String bill_to_address_line1 {get;set;}
    public String bill_to_address_city {get;set;}
    public String bill_to_address_state {get;set;}
    private String bill_to_address_country;
    public String bill_to_address_postal_code {get;set;}
    public Decimal amount {get;set;}
    public Boolean paymentAlreadyExists {get;set;}
    private static String kHexChars = '0123456789abcdef';
    
    // Constructor used to initialize and perform all the operations by using the method definitions in the class to redirect user to CyberSource Portal with required data
    public CyberSourceController(){
        try {
            
            String transactionId = ApexPages.currentPage().getParameters().get('tid');
            system.debug(transactionId+'----');
            if(String.isNotBlank(transactionId)){
                
                Transaction_Log__c transactionRecord = [SELECT Id, Amount__c, Business_License__c, Application_Reference__c, User__c, Payment_Type__c, Summon__c, Settlement__c
                                                        FROM Transaction_Log__c 
                                                        WHERE Id =: transactionId WITH SECURITY_ENFORCED];
                String userId = transactionRecord.User__c;
                String recordId;
                
                if(transactionRecord.Business_License__c != null) {
                    
                    recordId = transactionRecord.Business_License__c;
                    
                } else if(transactionRecord.Application_Reference__c != null) {
                    
                    recordId = transactionRecord.Application_Reference__c;
                    
                } else if(transactionRecord.Summon__c != null) {
                    recordId = transactionRecord.Summon__c;
                } else if(transactionRecord.Settlement__c != null) {
                    recordId = transactionRecord.Settlement__c;
                } else {
                    
                    ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Required parameter is missing.'));
                    throw new VisualForceException('Required parameter is missing.');
                    
                }
                
                String paymentType = transactionRecord.Payment_Type__c;
                String paymentMode = ApexPages.currentPage().getParameters().get('mode');
                Decimal fee = transactionRecord.Amount__c;
                
                if(String.isNotBlank(userId)){
                    
                    String contactId = [SELECT Id, ContactId FROM User WHERE Id =: userId LIMIT 1].ContactId;
                    List<RegulatoryTrxnFee> payments = new List<RegulatoryTrxnFee>();
                    
                    if(transactionRecord.Application_Reference__c != null){
                        
                        PreliminaryApplicationRef application = [SELECT Id, Authority__c, Status_Reason__c, LicenseTypeId__c, Request_Type__c 
                                                                 FROM PreliminaryApplicationRef 
                                                                 WHERE Id =: recordId WITH SECURITY_ENFORCED];
                        
                        payments = [SELECT Id, Name, Status, Fee_Type__c, Application_Reference__c 
                                    FROM RegulatoryTrxnFee 
                                    WHERE Application_Reference__c =: recordId AND Status = 'Paid' AND Fee_Type__c =: paymentType WITH SECURITY_ENFORCED];
                        
                        if(application != null && application.Authority__c == 'Cannabis' && application.Status_Reason__c == 'Pending Application Payment'){
                            
                            paymentAlreadyExists = false;
                            
                        } else {
                            
                            if(payments.size() > 0){
                                
                                paymentAlreadyExists = true;
                                ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Payment has already been completed.'));
                                throw new VisualForceException('Payment has already been completed.');
                                
                            } 
                        }
                    }
                    system.debug(contactId+'--'+recordId+'--'+paymentType);
                    if(String.isNotBlank(contactId) && String.isNotBlank(recordId) && String.isNotBlank(paymentType)){
                        Contact con = [SELECT Id,FirstName, LastName, Email, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Account.Name
                                       FROM Contact 
                                       WHERE Id =: contactId WITH SECURITY_ENFORCED];
                        if(con.FirstName !=null){
                            bill_to_forename = (con.FirstName.length() > 60) ? con.FirstName.Substring(0,60) : con.FirstName;    
                        }
                        
                        bill_to_surname = (con.LastName.length() > 60) ? con.LastName.Substring(0,60) : con.LastName;
                        bill_to_email = con.Email;
                        if(con.Account.Name !=null){
                            bill_to_company_name = (con.Account.Name.length() > 40) ? con.Account.Name.Substring(0,40) : con.Account.Name;    
                        }
                        
                        if(bill_to_forename !=null){
                            bill_to_forename = bill_to_forename.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '');    
                        }
                        
                        bill_to_surname = bill_to_surname.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '');
                        if(bill_to_company_name !=null){
                            bill_to_company_name = bill_to_company_name.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '');
                        }
                        
                        bill_to_address_line1 = ( String.isNotBlank( con.MailingStreet ) ? con.MailingStreet.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '') : '');
                        
                        bill_to_address_city = (String.isNotBlank(con.MailingCity) ? con.MailingCity.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '') : '');
                        
                        bill_to_address_state = con.MailingState != null ? (con.MailingState.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '')) : '';
                        
                        bill_to_address_postal_code = (String.isNotBlank(con.MailingPostalCode) ? con.MailingPostalCode.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '') : '');
                        
                        bill_to_address_country = (String.isNotBlank(con.MailingCountry) ? con.MailingCountry.replaceAll('[^a-zA-Z0-9-,\'\\s+]', '') : '');
                        
                        reference_number = recordId + '' + Datetime.now().getTime();
                        issuer_additional_data = con.Id + '__' + recordId + '__' + paymentType + '__' + UserInfo.getUserId() + '__' + transactionId;
                        this.amount = fee;
                        if( paymentMode == 'card' ){
                            processCard();
                        }
                        else if( paymentMode == 'echeck' ){
                            processECheck();
                        }
                    } else {
                        ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Required parameter is missing.'));
                        throw new VisualForceException('Required parameter is missing.');
                    }
                }
                else {
                    ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Required parameter is missing.'));
                    throw new VisualForceException('Required parameter is missing.');
                }
            } else {
                ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Required parameter is missing.'));
                throw new VisualForceException('Required parameter is missing.');
            }
        } catch(Exception ex){
            ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage() + ex.getStackTraceString()+ ex.getLineNumber() + ex.getCause()) );
        }
    }
    
    /* Payment Integration and Authentication Methods - START */
    public static String sign(Map<String, String> paramsArray)  {
        if( paramsArray != null && paramsArray.size() > 0 ){
            return sign(buildDataToSign(paramsArray), CyberSourceController.recover());
        } else {
            return '';
        }
    }
    
    public static String NewGuid() {
        
        String returnValue = '';
        Integer nextByte = 0;
        
        for (Integer i = 0; i < 16; i++) {
            
            if (i == 4 || i == 6 || i == 8 || i == 10) 
                returnValue += '-';
            
            nextByte = (Math.round(Math.random() * 255) - 128) & 255;
            
            if ( i == 6) {
                nextByte = nextByte & 15;
                nextByte = nextByte | (4 << 4);
            }
            
            if ( i == 8 ) {
                nextByte = nextByte & 63;
                nextByte = nextByte | 128;
            }
            
            returnValue += getCharAtIndex(kHexChars, nextByte >> 4);
            returnValue += getCharAtIndex(kHexChars, nextByte & 15);
        }
        
        return returnValue;
    }
    
    public static String getCharAtIndex(String str, Integer index) {
        
        if (str == null) return null;
        
        if (str.length() <= 0) return str;    
        
        if (index == str.length()) return null;    
        
        return str.substring(index, index+1);
    }
    
    public String getUUID(){
        String oGUID = NewGuid();
        return oGUID;
    }
    
    public String getUTCDateTime(){
        DateTime oUTSDateTime = System.now();
        String strUTCDateTime = oUTSDateTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        return strUTCDateTime;
    }
    
    public String getHOLO(){
        return cyberSource.CyberSource_Access_Key__c;
    }
    
    public String getHOLO1(){
        return cyberSource.CyberSource_Profile_Id__c;
    }
    
    public String getParametersValuesHidden(){
        String result = '';
        for (String oKey : oPassedParams.KeySet()){ 
            result += '<input id="' + oKey + '" name="' + oKey + '" value="' + oPassedParams.get(oKey) + '"/>';
        }
        system.debug('Result>>>'+result);
        return result;
    }
    
    public String getSignedData(){
        String result = '';
        result += '<input id="signature" name="signature" value="' + CyberSourceController.sign(oPassedParams) + '"/>';
        return result;
    }
    
    public String getEndpoint(){
        return cyberSource.EndPoint_Url__c;
        //return 'https://testsecureacceptance.cybersource.com/pay';
    }
    
    private static String recover(){
        if(cyberSource != null){
            return cyberSource.CyberSource_Secret_Key__c;
        }
        else{
            return null;
        }
    }
    
    private void popParams(){
        oPassedParams.put('access_key', getHOLO()); 
        oPassedParams.put('profile_id', getHOLO1());
        oPassedParams.put('transaction_uuid', getUUID());
        oPassedParams.put('signed_field_names',
                          'access_key,profile_id,transaction_uuid,signed_field_names,signed_date_time,ignoreAVSResult,locale,transaction_type,reference_number,issuer_additional_data,amount,currency,'+
                          'payment_method,bill_to_forename,bill_to_surname,bill_to_email,bill_to_company_name,bill_to_address_line1,bill_to_address_city,bill_to_address_state,bill_to_address_country,bill_to_address_postal_code');
        oPassedParams.put('signed_date_time', getUTCDateTime());
        oPassedParams.put('locale', 'en');
        oPassedParams.put('ignoreAVSResult', 'true');
        oPassedParams.put('transaction_type', 'sale'); 
        oPassedParams.put('reference_number', reference_number);
        oPassedParams.put('issuer_additional_data', issuer_additional_data);
        oPassedParams.put('amount', String.valueOf(Integer.valueOf(this.amount)));
        oPassedParams.put('currency', 'USD');
        oPassedParams.put('payment_method', payment_method);
        oPassedParams.put('bill_to_company_name', bill_to_company_name);
        oPassedParams.put('bill_to_forename', bill_to_forename);
        oPassedParams.put('bill_to_surname', bill_to_surname);
        oPassedParams.put('bill_to_email', bill_to_email);
        oPassedParams.put('bill_to_address_line1', bill_to_address_line1);
        oPassedParams.put('bill_to_address_city', bill_to_address_city);
        oPassedParams.put('bill_to_address_country', bill_to_address_country);
        oPassedParams.put('bill_to_address_state', bill_to_address_state);
        oPassedParams.put('bill_to_address_postal_code', bill_to_address_postal_code);
    }
    
    private static String commaSeparate(List<String> dataToSign) {
        String result = '';
        for(String Str : dataToSign) {
            result += (result == '' ? '' : ',') + Str;
        }
        return result;                         
    }
    
    private static String buildDataToSign(Map<String, String> paramsArray) {
        String[] signedFieldNames = paramsArray.get('signed_field_names').split(',');
        List<String> dataToSign = new List<String>();
        
        for (String oSignedFieldName : signedFieldNames){
            dataToSign.Add(oSignedFieldName + '=' + paramsArray.get(oSignedFieldName));
        }
        return commaSeparate(dataToSign);
    }
    
    private static String sign(String data, String secretKey) {
        String result = EncodingUtil.base64Encode(Crypto.generateMac('hmacSHA256', Blob.valueOf(data), Blob.valueOf(secretKey)));
        return result;
    }
    /* Payment Integration and Authentication Methods - END */
    
    // Custom Metadata Type: Payment Configuration
    private static Payment_Configuration__mdt cyberSource;
    
    // Payment Configuration Record for Card Payments
    private void processCard(){
        cyberSource = [SELECT Id, DeveloperName, CyberSource_Access_Key__c, CyberSource_Profile_Id__c, CyberSource_Secret_Key__c, EndPoint_Url__c
                       FROM Payment_Configuration__mdt 
                       WHERE DeveloperName = 'CyberSource'];
        payment_method = 'card';
        popParams();
    }
    
    // Payment Configuration Record for Electronic Check Payments
    private void processECheck(){
        cyberSource = [SELECT Id, DeveloperName, CyberSource_Access_Key__c, CyberSource_Profile_Id__c, CyberSource_Secret_Key__c, EndPoint_Url__c
                       FROM Payment_Configuration__mdt 
                       WHERE DeveloperName = 'CyberSource_ECheck'];
        payment_method = 'echeck';
        popParams();
    }
}