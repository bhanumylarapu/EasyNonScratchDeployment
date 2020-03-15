public with sharing class EinsteinInsuranceBotCaseCreateService {
    
    @InvocableMethod(label='Insurance Bot Create Case' description='Creates a case for insurance')
    public static List<Case> createCase(List<CustomerRequest> requests) {
    
      For (CustomerRequest request : requests) {
      
      // Check if the user has create access on the Case fields
      if (!Schema.sObjectType.Case.fields.Status.isCreateable() || !Schema.sObjectType.Case.fields.Subject.isCreateable()) {
          // Returning null, error handling is done in the UI side of it
          return null;
      }
        
        Case caseObj = new Case(
            Status = 'New',
            Subject = 'Reach out to user ' + request.customerName + ' having email id ' + request.customerEmail + ' for following question ' + request.customerQuery);
        insert caseObj;
   
        caseObj = [select id, casenumber, subject from case where id = : caseObj.id];
                
        return new List<Case>{caseObj};
     }
        return new List<Case>{new Case()};
      
    }
    
     public class CustomerRequest {
    
        @InvocableVariable(required=false)
        public string customerQuery;
        
        
        @InvocableVariable(required=false)
        public string customerName;
        
        @InvocableVariable(required=false)
        public string customerEmail;
        
    }
}