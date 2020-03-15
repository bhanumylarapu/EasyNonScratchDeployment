@isTest
public with sharing class EinsteinInsuranceBotPolicyServiceTest {

@isTest
    private static void testWithValidPolicy(){
        
        List<Insurance_Customer__c> req = EinsteinInsuranceBotTestingUtil.createTestInsuranceCustomer();
       
        Test.startTest();
           
        List<Insurance_PolicyHolder__c> result = EinsteinInsuranceBotPolicyService.createCustomerPolicyData(req);
        
        System.assertEquals(1, result.size(), 'Expected case creation for customer query');
        
        Test.stopTest();
    }

}