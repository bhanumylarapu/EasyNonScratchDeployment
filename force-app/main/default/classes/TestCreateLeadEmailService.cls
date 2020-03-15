@IsTest
private class TestCreateLeadEmailService {
@isTest static  void testGetCallout_InsertLead(){
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
                
        email.plainTextBody = 'From: aditi sharma <aditi.sharma448@gmail.com>';
        email.fromAddress ='test@test.com';
        String contactEmail = 'test@domain.com';
        email.subject = 'RE:Dummy Subject';
        
        CreateLeadEmailService  objCreateLeadEmail = new CreateLeadEmailService ();
        
        Test.startTest();
        Messaging.InboundEmailResult result = objCreateLeadEmail.handleInboundEmail(email, env);
        Test.stopTest();               
        Lead  objLead = [select ID,leadSource from Lead];
        system.assertEquals(objLead.leadSource,'Email');
    }
    @isTest static  void testGetCallout_InsertLead_RE(){
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
                
        email.plainTextBody = 'From: aditi sharma <aditi.sharma448@gmail.com>';
        email.fromAddress ='test@test.com';
        String contactEmail = 'test@domain.com';
        email.subject = 'RE:Dummy Subject';
        
        CreateLeadEmailService  objCreateLeadEmail = new CreateLeadEmailService ();
        
        Test.startTest();
        Messaging.InboundEmailResult result = objCreateLeadEmail.handleInboundEmail(email, env);
        Test.stopTest();               
        Lead  objLead = [select ID,leadSource from Lead];
        system.assertEquals(objLead.leadSource,'Email');
    }
    @isTest static  void testGetCallout_InsertLead_REFW(){
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
                
        email.plainTextBody = 'From: aditi sharma <aditi.sharma448@gmail.com>';
        email.fromAddress ='test@test.com';
        String contactEmail = 'test@domain.com';
        email.subject = 'RE:FW:Dummy Subject';
        
        CreateLeadEmailService  objCreateLeadEmail = new CreateLeadEmailService ();
        
        Test.startTest();
        Messaging.InboundEmailResult result = objCreateLeadEmail.handleInboundEmail(email, env);
        Test.stopTest();               
        Lead  objLead = [select ID,leadSource from Lead];
        system.assertEquals(objLead.leadSource,'Email');
    }
	/* @isTest 
    static  void testGetCallout_InsertAttachment(){
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        email.plainTextBody = 'From: aditi sharma <aditi.sharma448@gmail.com>';
        email.fromAddress ='test@test.com';
        String contactEmail = 'test@domain.com';
        email.subject = 'FW:Dummy Subject';
        Test.startTest();       
        Lead objLead = new Lead();
        objlead.LastName  = email.subject;
        objlead.Company =  email.subject;
        objlead.Description = email.plainTextBody;
        objlead.LeadSource = 'Email';
        objlead.Email = 'aditi.sharma448@gmail.com';
        insert objlead;
        CreateLeadEmailService  objCreateLeadEmail = new CreateLeadEmailService ();
        Messaging.InboundEmailResult result = objCreateLeadEmail.handleInboundEmail(email, env);
        Test.stopTest();
        Lead  objLeadmatch = [select ID,LastName from Lead];
        system.assertEquals(objLeadmatch.LastName,email.subject);
    } */  
}