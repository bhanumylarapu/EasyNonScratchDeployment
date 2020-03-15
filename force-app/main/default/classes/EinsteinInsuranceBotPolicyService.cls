public with sharing class EinsteinInsuranceBotPolicyService {

 
    @InvocableMethod(label='Insurance Bot Create Policy' description='Create a policy for a customer')
    public static List<Insurance_PolicyHolder__c> createCustomerPolicyData(List<Insurance_Customer__c> reqs) {
    
        Insurance_Customer__c req = reqs.get(0);

        if(req == null) { return null; }
        
        // Check if the user has create access on the Insurance_PolicyHolder__c fields
       if (!Schema.sObjectType.Insurance_PolicyHolder__c.fields.Insurance_Customer__c.isCreateable()) {
          // Returning null, error handling is done in the UI side of it
          return null;
       }
        
        Insurance_PolicyHolder__c policyObj = new Insurance_PolicyHolder__c();
        policyObj.Insurance_Customer__c = req.Id;
        
        insert policyObj;
        
        return new List<Insurance_PolicyHolder__c>{policyObj};
    }

}