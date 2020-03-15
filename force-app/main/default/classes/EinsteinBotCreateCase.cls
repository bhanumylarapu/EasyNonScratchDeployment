public with sharing class EinsteinBotCreateCase {
    
    @InvocableMethod(label='Create Case' description='Creates a case for Billing Related issue')
    public static List<CustomerOutput> createCase(List<CustomerRequest> reqs) {
        CustomerRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        }     
        String orderNum = req.OrderNumber;
        String caseSubject  = req.problemSummary;
        
        List<CustomerOutput> orderOutputs = new List<CustomerOutput>(); 
        
        List<Order__c> orderQuery = [Select Id,Name,Contact__c from Order__c where Name =:orderNum LIMIT 1];
        Case caseObj = new Case(
            Status = 'New',
            Subject = caseSubject,
            Origin = 'Chat',
            Description = 'Duplicate Charge on Credit Card',
            Case_Intent__c = 'Billing Related',
            ContactId = orderQuery[0].Contact__c,
            OrderNumber__c = orderQuery[0].Id );
            
        insert caseObj; 
        
        caseObj = [select id, casenumber, subject from case where id = : caseObj.id];
        
        if(caseObj.Id != NULL){
            CustomerOutput orderOutput = new CustomerOutput();
            orderOutput.caseNumber = caseObj.caseNumber;
            
            orderOutputs.add(orderOutput);
            return orderOutputs;
        }
        else{
            return Null;
        }
        
     } 
     public class CustomerRequest {
    
        @InvocableVariable
        public string orderNumber;
        @InvocableVariable
        public string problemSummary;
        
    }
    
    public class CustomerOutput {
    
        @InvocableVariable
        public string caseNumber;
        
    }
}