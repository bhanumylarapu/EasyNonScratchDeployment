global class CreateLeadEmailService implements Messaging.InboundEmailHandler {
     // lastcommunication date : create this field on lead object
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                           Messaging.InboundEnvelope env){
             List<Lead>listLead = new List<Lead>();
             Map<string,Lead>mapLeadEmail = new Map<string,Lead>();
             Lead objLead = new Lead();
             Matcher match;
             String leadLastName;
             String LeadCompany;
             
             Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
                String leadEmail;
                system.debug('email.subject@@'+email.subject);
                if(email.subject.contains('RE:')){
                    string newSubject = email.subject.remove('RE:');
                    if(newSubject.contains('FW:')){
                        leadLastName = newSubject.remove('FW:');
                        LeadCompany = newSubject.remove('FW:');
                    }else{
                        leadLastName = newSubject;
                        LeadCompany = newSubject;
                    }                   
                }
                else if(email.subject.contains('FW:')){
                    string newSubject = email.subject.remove('FW:');
                    system.debug('newSubject$$'+newSubject);
                    if(newSubject.contains('RE:')){
                        leadLastName = newSubject.remove('RE:');
                        LeadCompany = newSubject.remove('RE:');
                    }else{
                        leadLastName = newSubject;
                        LeadCompany = newSubject;
                    }                   
                }
                else {
                    leadLastName = email.subject;
                    LeadCompany = email.subject; 
                }                
                String leadDescrip = email.plaintextbody;                          
                String leadSource = 'Email';
                String parentEmail = email.plaintextbody.substringAfter('From: ').substringBefore('>');
                system.debug('parentEmail@@'+parentEmail);
                
                if(parentEmail!= ''){
                    match = Pattern.compile('[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+').matcher(parentEmail);
                } 
                system.debug('match@@'+match);              
                if(match!=null){
                    while (match.find()) {
                        leadEmail = match.group();
                        break;
                    }
                }   
                system.debug('leadEmail@@'+leadEmail);
                if(leadEmail!=null){
                 //   for(Lead objLeadAttch : [select id,email,LeadSource from Lead where email =: leadEmail and LeadSource =: leadSource]){
                 //       mapLeadEmail.put((objLeadAttch.email+objLeadAttch.LeadSource),objLeadAttch);
                 //   }

                    /*if(mapLeadEmail.isEmpty()){ */
                        objLead = new Lead (LastName = leadLastName,Company = LeadCompany , Description = leadDescrip,LeadSource = leadSource,Email = leadEmail,Deloitte_Contact_Email__c = email.fromAddress,Last_Communication_Date__c= system.today(),Skip_Duplicate_Rule__c= true);
                        listLead.add(objLead);                   
                    /*}else{
                        // Decrypt the attachment body and then set it.
                        Attachment attach=new Attachment();
                        attach.Body= Blob.valueOf(email.plaintextbody);
                        attach.Name=email.subject;                    
                        attach.ParentID=mapLeadEmail.get(leadEmail+leadSource).Id;
                        objLead = new Lead(Id = mapLeadEmail.get(leadEmail+leadSource).Id , Last_Communication_Date__c = system.today());
                        listLead.add(objLead);

                        try{
                            insert(attach);
                        } 
                        catch(System.DMLException e) {
                            system.debug('e@@'+e);
                        } 
                    }*/
                }
                else{
                    system.debug('No Email Address Found to Create a Lead');
                }
                
                if(!listLead.isEmpty()){
                     try{
                        upsert listLead;
                      } 
                      catch(System.DMLException e) {
                         system.debug('e@@'+e);
                      }                             
                }
                        
                return null;
      }
    }