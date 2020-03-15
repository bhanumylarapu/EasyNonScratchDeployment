public with sharing class EinsteinInsuranceBotCustomerService {

    @InvocableMethod(label='Insurance Bot Create Customer Data' description='Create a customer insurance data')
    public static List<Insurance_Customer__c> createCustomerInsuranceData(List<CustomerInsuranceRequest> reqs) {
        CustomerInsuranceRequest req = reqs.get(0);

        if(req == null) { 
            return null; 
        }
        
       // Fields of Insurance_Customer__c
      String [] insuranceCustomerFields = new String [] {'Name',
                                                     'Insurance_Type__c',
                                                     'Customer_Name__c',
                                                     'Phone__c',
                                                     'Email__c',
                                                     'Stage__c',
                                                     'Appointment_Data_Time__c',
                                                     'License_Plate__c',
                                                     'Vehicle_Registration_Date__c',
                                                     'Driving_License_Number__c',
                                                     'CityOfResident__c',
                                                     'CountOfAdultInsured__c',
                                                     'CountOfChildrenInsured__c',
                                                     'DobOfEldestInsured__c',
                                                     'DestinationCountry__c',
                                                     'SourceCountry__c'
                                                     };

      // Obtaining the field name/token map for the Insurance_Customer__c object
      Map<String,Schema.SObjectField> m = Schema.SObjectType.Insurance_Customer__c.fields.getMap();
      
      // Check if the user has create access on the Insurance_Customer__c fields
      for (String fieldToCheck : insuranceCustomerFields) {
        // Check if the user has create access on the each field
        if (!m.get(fieldToCheck).getDescribe().isCreateable()) {
             // Returning null, error handling is done in the UI side of it
             return null;
        }
      }
      
        
        Insurance_Customer__c insuranceCustData = new Insurance_Customer__c();
        String insuranceType = req.insuranceType;
        if (insuranceType != null) {
            
            if(insuranceType.contains('car') || insuranceType.contains('Buy')) {
                insuranceType = 'Car';
            }
            if(insuranceType.contains('Health')) {
                insuranceType = 'Health';
            }
            if(insuranceType.contains('Two_Wheeler')) {
                insuranceType = 'Two Wheeler';
            }
            if(insuranceType.contains('Travel')) {
                insuranceType = 'Overseas Travel';
            }
        }
        if (req.customerName != null) { 
            insuranceCustData.Name = req.customerName + ' ' + insuranceType + ' ' + date.today().format();
        }
        if (req.insuranceType != null) {
            insuranceCustData.Insurance_Type__c = insuranceType;
        }
        if (req.contactNumber != null) {
            insuranceCustData.Customer_Name__c = req.customerName;
        }
        if (req.insuranceType != null) {
            insuranceCustData.Phone__c = req.contactNumber;
        }
        if (req.email != null) {
            insuranceCustData.Email__c = req.email;
        }
        if (req.customerInterest != null) {
            insuranceCustData.Stage__c = req.customerInterest;
        }
        //insuranceCustData.Appointment_Data_Time__c = System.Now();
        if (req.appointmentDateTime != null) {
            insuranceCustData.Appointment_Data_Time__c = req.appointmentDateTime;
        }
        
        // Vehicle Insurance - Car and Two Wheeler Data
        if (req.licensePlateNumber != null) {
            insuranceCustData.License_Plate__c = req.licensePlateNumber;
        }
        if (req.vehicleRegistrationDate != null) {
            insuranceCustData.Vehicle_Registration_Date__c = req.vehicleRegistrationDate;
        }
        if (req.drivingLicenseNumber != null) {
            insuranceCustData.Driving_License_Number__c = req.drivingLicenseNumber;
        }
        
        // Health and Travel Insurance Data
        if (req.cityOfResident != null) {
            insuranceCustData.CityOfResident__c = req.cityOfResident;
        }
        if (req.countOfAdultInsured != null) {
            insuranceCustData.CountOfAdultInsured__c = req.countOfAdultInsured;
        }
        if (req.countOfChildrenInsured != null) {
            insuranceCustData.CountOfChildrenInsured__c = req.countOfChildrenInsured;
        }
        
        if (req.dobOfEldestInsured != null) {
            insuranceCustData.DobOfEldestInsured__c = req.dobOfEldestInsured;
        }
        if (req.targetCountry != null) {
            insuranceCustData.DestinationCountry__c = req.targetCountry;
        }
        if (req.sourceCountry != null) {
            insuranceCustData.SourceCountry__c = req.sourceCountry;
        }
        
        insert insuranceCustData;
        
        return new List<Insurance_Customer__c>{insuranceCustData};
    }
    
     public class CustomerInsuranceRequest {
        @InvocableVariable
        public String insuranceType;
        @InvocableVariable
        public String customerName;
        @InvocableVariable
        public String contactNumber;
        @InvocableVariable
        public String email;
        @InvocableVariable
        public String licensePlateNumber;
        @InvocableVariable
        public String drivingLicenseNumber;
        @InvocableVariable
        public Date vehicleRegistrationDate;
        @InvocableVariable
        public DateTime appointmentDateTime;
        @InvocableVariable
        public String customerInterest;
        @InvocableVariable
        public Integer countOfAdultInsured;
        @InvocableVariable
        public Integer countOfChildrenInsured;
        @InvocableVariable
        public Date dobOfEldestInsured;
        @InvocableVariable
        public String cityOfResident;
        @InvocableVariable
        public String sourceCountry;
        @InvocableVariable
        public String targetCountry;
    }

}