@isTest
public with sharing class EinsteinInsuranceBotPaymentServiceTest {

@isTest
    private static void testCreateCase(){
        
        List<String> policyNumber = new List<String> {'sa567547'};
        Test.startTest();
           
        List<Case> result = EinsteinInsuranceBotPaymentService.createCase(policyNumber);
        
        System.assertEquals(1, result.size(), 'Expected case creation for payment of existing customer');
         
        Test.stopTest();
    }
    

@isTest
    private static void testCreateCaseWithoutPolicyNumber(){
        
        Test.startTest();
           
        List<Case> result = EinsteinInsuranceBotPaymentService.createCase(null);
        
        System.assertEquals(1, result.size(), 'Expected case creation for payment for new customer');
         
        Test.stopTest();
    }
        

}