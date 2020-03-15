public class ChatbotPageController {    
    @RemoteAction
    public static Case createCase(String description, String product, String communicate, string priority) {
        // Find contact
        List<Contact> listContacts = new List<Contact>();
        if(!String.isBlank(communicate)) {
            listContacts =   [
                                 SELECT
                                     Id, email, phone
                                 FROM
                                     Contact
                                 WHERE
                                     Email =: communicate OR phone = :communicate
                                 LIMIT
                                     1
                             ];
        }
                        
        Case c = new Case();
        c.description = description;
        c.product__c = product;
        c.priority = 'Medium';
        c.status = 'New';
        c.origin = 'Chat';
        if(null != listContacts && !listContacts.isEmpty()) {
            c.contactId = listContacts[0].id;
        }
        insert c;
        
        Case newCase = [SELECT CaseNumber,contactEmail, product__c FROM Case WHERE Id =: c.id LIMIT 1];
        
        String caseNumber = newCase.caseNumber;
        while(caseNumber.charAt(0) == 48) {
            caseNumber = caseNumber.removeStart('0');
        }
        return newCase;
    }
    
    @RemoteAction
    public static String getCaseDetails(String caseNumber) {
        if(null != caseNumber) {
            caseNumber = caseNumber.replace(' ', '');
        }
        Integer count = 8 - caseNumber.length();
        for(Integer i = 0; i < count; i++) {
            caseNumber = '0' + caseNumber;
        }
        List<Case> listCases = [
                                   SELECT
                                       Id,
                                       Description,
                                       Priority,
                                       Status,
                                       Product__c,
                                       CaseNumber
                                   FROM
                                       Case
                                   WHERE
                                       CaseNumber =: caseNumber
                                   LIMIT
                                       1
                               ];
        if(null == listCases || listCases.isEmpty()) {
            return 'No such case found';
        }        
        else {
            String caseNumber1 = listCases[0].caseNumber;
            while(caseNumber1.charAt(0) == 48) {
                caseNumber1 = caseNumber1.removeStart('0');
            }
            String s = '';
            s += '</br>Case Number: ' + caseNumber1;
            s += '</br>Product: ' + listCases[0].product__c;
            s += '</br>Description: ' + listCases[0].Description;
            s += '</br>Priority: ' + listCases[0].Priority;
            s += '</br>Status: ' + listCases[0].Status;
            return s;
        }
    }    
}