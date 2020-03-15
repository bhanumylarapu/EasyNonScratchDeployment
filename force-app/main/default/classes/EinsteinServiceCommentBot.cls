public with sharing class EinsteinServiceCommentBot {

    @InvocableMethod(label='InsertCaseCommentBot' description='Creates a case comment for Case Mangement Bot')
    public static List<CustomerOutput> createCase(List<CustomerRequest> reqs) {
        CustomerRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        }     
        String caseId = req.caseId;
        String caseDescription  = req.caseDescription;
        
        List<CustomerOutput> response = new List<CustomerOutput>(); 
        
        CaseComment caseObj = new CaseComment(
            CommentBody = caseDescription,
            ParentId = caseId);
            
        insert caseObj; 
        CustomerOutput orderOutput = new CustomerOutput();
            orderOutput.caseId = caseObj.ParentId;
            
            response.add(orderOutput);
            return response;
     } 
     public class CustomerRequest {
    
        @InvocableVariable
        public string caseId;
        @InvocableVariable
        public string caseDescription;
        
    }
    
    public class CustomerOutput {
    
        @InvocableVariable
        public string caseId;
        
    }
}