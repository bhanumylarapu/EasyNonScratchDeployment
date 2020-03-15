public class ChatbotLightningController {
    @AuraEnabled
    public static String getClientName() {
    	return userinfo.getFirstName();    
    }
    
    @AuraEnabled
    public static String createCase(String product, String description, String email, String priority) {
        // Find contact
        List<Contact> listContacts = [
                                         SELECT
                                             Id
                                         FROM
                                             Contact
                                         WHERE
                                             Email =: email
                                         LIMIT
                                             1
                                     ];
                                             
        Case c = new Case();
        c.description = description;
        c.product__c = product;
        c.priority = priority;
        c.status = 'New';
        c.origin = 'Chat';
        if(null != listContacts && !listContacts.isEmpty()) {
            c.contactId = listContacts[0].id;
        }
        insert c;
        
        Case newCase = [SELECT CaseNumber FROM Case WHERE Id =: c.id LIMIT 1];
        return newCase.caseNumber;
    }
    
	@AuraEnabled
    public static String getCaseDetails(String caseNumber) {
        List<Case> listCases = [
                                   SELECT
                                       Id,
                                       Description,
                                       Priority,
                                       Status,
                                       CaseNumber,
            						   product__c
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
            String s = '';
            s += '\nCase Number: ' + listCases[0].caseNumber;
            s += '\nProduct: ' + listCases[0].product__c;
            s += '\nDescription: ' + listCases[0].Description;
            s += '\nPriority: ' + listCases[0].Priority;
            s += '\nStatus: ' + listCases[0].Status;
            return s;
        }
    }
}