public with sharing class EinsteinInsuranceBotPolicyLookup {
    
    @InvocableMethod(label='Insurance Bot Get Valid Insurance Policy Number' description='Returns whether a policy number is valid or not')
    public static List<Boolean> isValidPolicyNumber(List<String> policyNumber) {
    
       // Check if the user has read access on the Insurance_PolicyHolder__c field
        if (!Schema.sObjectType.Insurance_PolicyHolder__c.fields.Id.isAccessible()) {
           // Returning null, error handling is done in the UI side of it
          return null;
        }

        List<Insurance_PolicyHolder__c> policy = [select Id,Policy_Number__c
                                              from Insurance_PolicyHolder__c
                                              where Policy_Number__c = :policyNumber
                                              ];
        
      
        if(policy != null && policy.size() == 1) {
            return new List<Boolean> {true};
        }
        
        return new List<Boolean> {false};
    }
}