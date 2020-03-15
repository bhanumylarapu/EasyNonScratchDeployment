public with sharing class EinsteinInsuranceBotPaymentService {
    
    @InvocableMethod(label='Insurance Bot Create Case for Payment' description='Creates a case for payment of insurance policy')
    public static List<Case> createCase(List<string> policyNumber) {
    
       // Check if the user has create access on the Case fields
      if (!Schema.sObjectType.Case.fields.Status.isCreateable() || !Schema.sObjectType.Case.fields.Subject.isCreateable()) {
          // Returning null, error handling is done in the UI side of it
          return null;
      }
    
       string subject;
       if (policyNumber != null) {
           subject = 'Initiate payment for policy renew of user having policy number ' + policyNumber;
       } else {
           subject = 'Initiate payment for new customer';
       }
    
        Case caseObj = new Case(
            Status = 'New',
            Subject = subject);
                
        insert caseObj;
        caseObj = [select id, casenumber, subject from case where id = : caseObj.id];
                
        return new List<Case>{caseObj};
      
    }
}