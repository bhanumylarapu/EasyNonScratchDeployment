@isTest
public with sharing class EinsteinInsuranceBotTestingUtil {
 
    
    public static List<Insurance_Customer__c> createTestInsuranceCustomer(){
        List<Insurance_Customer__c> results = new List<Insurance_Customer__c>();
 
        Insurance_Customer__c c = new Insurance_Customer__c();
            c.Insurance_Type__c = 'Car';
            c.Customer_Name__c = 'Test User';
            
        results.add(c);
        
        insert results;
        return results;
    }
    
     public static List<Insurance_PolicyHolder__c> createTestInsuranceCustomerWithPolicy(){
     
         List<Insurance_PolicyHolder__c> results = new List<Insurance_PolicyHolder__c>();
            
         List<Insurance_Customer__c> c = EinsteinInsuranceBotTestingUtil.createTestInsuranceCustomer();
 
         Insurance_PolicyHolder__c i = new Insurance_PolicyHolder__c();
            i.Insurance_Customer__c = c.get(0).Id;
         
         results.add(i);
        
         insert results;
        return results;
    }   
}