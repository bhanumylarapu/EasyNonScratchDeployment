public with sharing class EinsteinServiceCaseQueryBot {

    @InvocableMethod(label='QueryCases' description='search a case for Case Mangement Bot')
    public static List<CaseOutput> createCase(List<CaseRequest> reqs) {
        List<CaseOutput> response = new List<CaseOutput>();
        
        CaseRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        } 
        Map<String, case> mapCaseStatus = new Map<String, case>();
        
        for(case caseObj : [select id, casenumber, subject, owner.name, ClosedDate, Status from case where casenumber = : req.caseNumber]){
            mapCaseStatus.put(caseObj.casenumber, caseObj);
        }
        
        if(mapCaseStatus.isEmpty()){
            return null;
        }
        
        for (String caseNum : mapCaseStatus.keySet())
        {
            CaseOutput csObj = new CaseOutput();
            csObj.caseNumber = mapCaseStatus.get(caseNum).casenumber;
            csObj.caseId = mapCaseStatus.get(caseNum).id;
            csObj.caseCloseStatus = mapCaseStatus.get(caseNum).Status;
            csObj.caseOwnerName = mapCaseStatus.get(caseNum).owner.name;
            response.add(csObj);
        }
        return response;
    }
    
    public class CaseRequest {
    
        @InvocableVariable
        public string caseNumber;
        
    }
    
    public class CaseOutput {
    
        @InvocableVariable
        public string caseNumber;
        @InvocableVariable
        public string caseId;
        @InvocableVariable
        public string caseCloseStatus;
        @InvocableVariable
        public String caseOwnerName;
        
    }
}