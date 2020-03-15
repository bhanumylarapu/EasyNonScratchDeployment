@isTest
public with sharing class EinsteinInsuranceBotCaseCreateTest {

@isTest
    private static void testCaseCreate(){
        
        EinsteinInsuranceBotCaseCreateService.CustomerRequest req = new EinsteinInsuranceBotCaseCreateService.CustomerRequest();
        req.customerQuery = 'I have home built 10 years back, looking for home insurance for it';
        req.customerName = 'Test User';
        req.customerEmail = 'test@xyz.com';
        
        Test.startTest();
           
        List<Case> result =  EinsteinInsuranceBotCaseCreateService.createCase(new List<EinsteinInsuranceBotCaseCreateService.CustomerRequest>{req});
     
        System.assertEquals(1, result.size(), 'Expected case creation for customer query');
         
        Test.stopTest();
    }

}