public with sharing class EinsteinServiceBot {

    @InvocableMethod(label='InsertCaseBot' description='Creates a case for Case Mangement Bot')
    public static List<CustomerOutput> createCase(List<CustomerRequest> reqs) {
        CustomerRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        }     
        String caseType = req.issueType;
        String caseSubject  = req.issueDescription;
        String caseComment = req.issueAdditionalDescription;
        
        List<CustomerOutput> response = new List<CustomerOutput>(); 
        
        Case caseObj = new Case(
            Status = 'New',
            Subject = caseSubject,
            Origin = 'Chat',
            Description = caseComment,
            Type = caseType);
            
        insert caseObj; 
        
        caseObj = [select id, casenumber, subject from case where id = : caseObj.id];
        
        if(caseObj.Id != NULL){
            CustomerOutput orderOutput = new CustomerOutput();
            orderOutput.caseNumber = caseObj.caseNumber;
            
            response.add(orderOutput);
            return response;
        }
        else{
            return Null;
        }
        
     } 
     public class CustomerRequest {
    
        @InvocableVariable
        public string issueType;
        @InvocableVariable
        public string issueDescription;
        @InvocableVariable
        public string issueAdditionalDescription;
        
    }
    
    public class CustomerOutput {
    
        @InvocableVariable
        public string caseNumber;
        
    }
}