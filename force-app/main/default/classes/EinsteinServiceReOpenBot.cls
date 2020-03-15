public with sharing class EinsteinServiceReOpenBot {

    @InvocableMethod(label='ReOpenCaseBot' description='reopen a case for Case Mangement Bot')
    public static List<CaseOutput> createCase(List<CaseRequest> reqs) {
        List<CaseOutput> response = new List<CaseOutput>();
        
        CaseRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        } 
        
        Case caseObj = new Case(
            Id = req.caseId,
            Status = 'Reopen',
            Reason_reopened__c = req.caseCloseStatus);
        
        try{   
            update caseObj;
            
            CaseOutput orderOutput = new CaseOutput();
            orderOutput.caseNumber = caseObj.caseNumber;
            
            response.add(orderOutput);
            return response;
        } catch(exception e){
            return null;
        }
        
    }
    
    public class CaseOutput {
    
        @InvocableVariable
        public string caseNumber;
        
    }
    
    public class CaseRequest{
    
        @InvocableVariable
        public string caseId;
        @InvocableVariable
        public string caseCloseStatus;
        
    }
}