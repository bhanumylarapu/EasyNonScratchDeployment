@isTest
public with sharing class EinsteinInsuranceBotPolicyLookupTest {

@isTest
    private static void testWithValidPolicy(){
        
        List<Insurance_PolicyHolder__c> policies = EinsteinInsuranceBotTestingUtil.createTestInsuranceCustomerWithPolicy();
        List<String> policyNumber = new List<String> {policies.get(0).Id};
        Test.startTest();
           
        List<Boolean> result = EinsteinInsuranceBotPolicyLookup.isValidPolicyNumber(policyNumber);
        
        System.assertEquals(true, result.get(0), 'Expected valid policy number');
         
        Test.stopTest();
    }
    

@isTest
    private static void testWithInvalidPolicy(){
        
        Test.startTest();
           
        List<Boolean> result = EinsteinInsuranceBotPolicyLookup.isValidPolicyNumber(new List<String> {'1234'});
        
        System.assertEquals(false, result.get(0), 'Expected invalid policy number');
         
        Test.stopTest();
    }
    

}