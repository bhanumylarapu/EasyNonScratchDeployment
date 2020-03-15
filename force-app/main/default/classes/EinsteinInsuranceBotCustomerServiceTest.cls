@isTest
public with sharing class EinsteinInsuranceBotCustomerServiceTest {

@isTest
    private static void testCreateCustomerInsuranceDataForCar(){
        
        EinsteinInsuranceBotCustomerService.CustomerInsuranceRequest req = new EinsteinInsuranceBotCustomerService.CustomerInsuranceRequest();
        req.insuranceType = 'car';
        req.customerName = 'Test User';
        req.email = 'test@xyz.com';
        req.licensePlateNumber = 'LC34355';
        
        Test.startTest();
           
        List<Insurance_Customer__c> result =  EinsteinInsuranceBotCustomerService.createCustomerInsuranceData(new List<EinsteinInsuranceBotCustomerService.CustomerInsuranceRequest>{req});
     
        System.assertEquals(1, result.size(), 'Expected case creation for customer query');
         
        Test.stopTest();
    }
    
@isTest
    private static void testCreateCustomerInsuranceDataForHealth(){
        
        EinsteinInsuranceBotCustomerService.CustomerInsuranceRequest req = new EinsteinInsuranceBotCustomerService.CustomerInsuranceRequest();
        req.insuranceType = 'Health';
        req.customerName = 'Test User';
        req.email = 'test@xyz.com';
        req.countOfAdultInsured = 1;
        
        Test.startTest();
           
        List<Insurance_Customer__c> result =  EinsteinInsuranceBotCustomerService.createCustomerInsuranceData(new List<EinsteinInsuranceBotCustomerService.CustomerInsuranceRequest>{req});
     
        System.assertEquals(1, result.size(), 'Expected case creation for customer query');
         
        Test.stopTest();
    }

}