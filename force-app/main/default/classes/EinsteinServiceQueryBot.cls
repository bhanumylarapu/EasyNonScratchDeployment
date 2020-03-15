public with sharing class EinsteinServiceQueryBot {

    @InvocableMethod(label='QueryCaseBot' description='search a case for Case Mangement Bot')
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
            CaseOutput res = new CaseOutput();
                res.caseId = mapCaseStatus.get(caseNum).id;
                res.caseNumber = mapCaseStatus.get(caseNum).casenumber;
                
            if(mapCaseStatus.get(caseNum).ClosedDate != null){
                
                DateTime dT = System.now();
                Date CurrDate = date.newinstance(dT.year(), dT.month(), dT.day());
                
                Date closedate = date.newinstance(mapCaseStatus.get(caseNum).ClosedDate.year(), mapCaseStatus.get(caseNum).ClosedDate.month(), mapCaseStatus.get(caseNum).ClosedDate.day());
                
                Integer caseCloseDays = closedate.daysBetween(CurrDate);
                if(caseCloseDays != null && caseCloseDays > 7) {
                   res.caseCloseStatus = 'new';
                } else if(caseCloseDays != null && caseCloseDays <= 7) {
                    res.caseCloseStatus = 'reOpen';
                } else {
                    res.caseCloseStatus = 'checkAgain';
                }
            } else {
                res.caseCloseStatus = 'checkAgain';
            }
            response.add(res);
        }
        return response;
        //return null;
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
        
    }
}