@isTest
public with sharing class EinsteinInsuranceBotQuoteServiceTest {

@isTest
    private static void testGetQuoteForCarInsurance(){
        
        EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest req = new EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest();
        req.insuranceType = 'car';
        req.vehicleRegistrationDate = date.today();
        
        Test.startTest();
           
        List<Integer> result =  EinsteinInsuranceBotQuoteService.getQuote(new List<EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest>{req});
     
        System.assertEquals(95, result.get(0), 'Expected quote for car insurance');
         
        Test.stopTest();
    }


@isTest
    private static void testGetQuoteForHealthInsurance(){
        
        EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest req = new EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest();
        req.insuranceType = 'Health';
        req.countOfAdultInsured = 2;
        req.countOfChildrenInsured = 2;
        req.cityOfResident = 'New York';
        
        Test.startTest();
           
        List<Integer> result =  EinsteinInsuranceBotQuoteService.getQuote(new List<EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest>{req});
     
        System.assertEquals(300, result.get(0), 'Expected quote for health insurance');
         
        Test.stopTest();
    }

@isTest
    private static void testGetQuoteForTravelInsurance(){
        
        EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest req = new EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest();
        req.insuranceType = 'Travel';
        req.countOfAdultInsured = 1;
        req.countOfChildrenInsured = 1;
        req.sourceCountry = 'USA';
        req.targetCountry = 'India';
        
        Test.startTest();
           
        List<Integer> result =  EinsteinInsuranceBotQuoteService.getQuote(new List<EinsteinInsuranceBotQuoteService.CustomerInsuranceRequest>{req});
     
        System.assertEquals(110, result.get(0), 'Expected quote for health insurance');
         
        Test.stopTest();
    }
}