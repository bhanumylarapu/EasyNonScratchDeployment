global class chatBotAssistantController_Clone{
    
    public Case objCase{get;set;}
    public static textAnalysisResponse objAnalysis{get;set;}
    public string priority{get;set;}
    public date openedDate {get; set;}
    public string type{get; set;}
    public string status{get;set;}
    public string subject{get;set;}
    public string user_state{get;set;}
    public string cv{get;set;}
    public static Map<string, list<string>> mapEntity{get;set;}
    public static String JsonMap{get;set;} 
    public static String current_userName{get;set;} 
    //public API_AI_Setting__c objConfig{get;set;} 
    public string objConfig{get;set;} 
    
    //constructor
    public chatBotAssistantController_Clone(ApexPages.StandardController stdController) {
         Case caserec = (Case)stdController.getRecord();
         objCase= [Select Id, Subject,type, priority, status, createdDate, owner.Name from Case where Id=: caserec.Id];
         objAnalysis = new textAnalysisResponse();
         subject = null;     
         cv = null;
         priority= null;
         status= null;
         type= null;
         User objUser = [Select Id, state, Name from User where Id=: UserInfo.getUserId()];
         
         current_userName = objUser.name;
         user_state= objUser.state;
         mapEntity = new Map<string,list<string>>();
         JsonMap = null;
         API_AI_Setting__c Config = API_AI_Setting__c.getValues('Default');
         objConfig = JSON.serialize(Config);
    }
    
    public void init(){
        //Cache.Session.put('settings', JSON.serialize(objConfig));
    }
    
    @AuraEnabled
    public static String getConfig() {
         API_AI_Setting__c Config = API_AI_Setting__c.getValues('Default');
         String objConfig = JSON.serialize(Config);
         return objConfig;
    }
    
    @AuraEnabled
    public static String getUserName() {
         User objUser = [Select Id, state, Name from User where Id=: UserInfo.getUserId()];
         return objUser.name;
    }
    
    @AuraEnabled
    public static User getUserDetails() {
         User objUser = [Select Id, state, Name from User where Id=: UserInfo.getUserId()];
         return objUser;
    }
    
    @AuraEnabled
    public static Case getCase(String caseId) {
         case selcobjCase = [Select Id, subject, status, priority, type, createdDate, owner.Name from Case where Id=: caseId];
         return selcobjCase;
    }
    
    
    //api call to wit.ai for text analysis
    @RemoteAction @AuraEnabled
    global static string gettextAnalysis(string strFinalSpeech){
    /*    string mapKey;
        mapEntity = new Map<string,list<string>>();
        
        if(strFinalSpeech!=null) {
            strFinalSpeech = strFinalSpeech.trim();
        }
        system.debug('&&&' +strFinalSpeech);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        API_AI_Setting__c objFields = API_AI_Setting__c.getValues('Default');
        
        req.setEndpoint(objFields.URL__c + '?v=' + objFields.v__c);
        req.setMethod('POST');        
        req.setHeader('Authorization','Bearer ' + objFields.acces_token__c);
        req.setHeader('Content-Type','application/json');
        
        textAnalysisReq objReq = new textAnalysisReq();
        objReq.lang = 'en';
        objReq.query = strFinalSpeech;
        objReq.sessionId = '43443344';
        
        String jsonString = json.serializePretty(objReq);
        req.setBody(jsonString);
        res = h.send(req);
        String response_debug = res.getBody() +' '+ res.getStatusCode();
        string response = res.getBody();
        System.debug('Response -->' + response);
        
        if(response != null) {
            objAnalysis = (textAnalysisResponse)JSON.deserialize(response,textAnalysisResponse.class);
            System.debug('Response =' + objAnalysis );
            mapEntity.clear();
            if(objAnalysis.result != null) {
                if( (objAnalysis.result).parameters != null) {
                    
                    // Shrykant API 
                    
                    //revenue
                    if( ((objAnalysis.result).parameters).Annual_Revenue != null  ) {
                        mapKey = 'Annual Revenue';
                        
                        if(mapEntity.containsKey(mapKey)) {
                            mapEntity.get(mapKey).add( (((objAnalysis.result).parameters).Annual_Revenue) );        
                        }
                        else {
                            mapEntity.put(mapKey, new List<string>{(((objAnalysis.result).parameters).Annual_Revenue)});
                        }
                     
                    }
                    
                    //charge volume
                    if( ((objAnalysis.result).parameters).Charge_volume != null  ) {
                        mapKey = 'Charge Volume';
                        
                        if(mapEntity.containsKey(mapKey)) {
                            mapEntity.get(mapKey).add( (((objAnalysis.result).parameters).Charge_volume) );        
                        }
                        else {
                            mapEntity.put(mapKey, new List<string>{(((objAnalysis.result).parameters).Charge_volume)});
                        }
                     
                    }
                    
                    //Place
                    if( ((objAnalysis.result).parameters).Place != null  ) {
                        mapKey = 'Place';
                        
                        if(mapEntity.containsKey(mapKey)) {
                            mapEntity.get(mapKey).add( (((objAnalysis.result).parameters).Place) );        
                        }
                        else {
                            mapEntity.put(mapKey, new List<string>{(((objAnalysis.result).parameters).Place)});
                        }
                     
                    }
                    
                    //amount
                    if( ((objAnalysis.result).parameters).amount_money != null  ) {
                        mapKey = 'money';
                        
                        if(mapEntity.containsKey(mapKey)) {
                            mapEntity.get(mapKey).add( String.valueOf ((((objAnalysis.result).parameters).amount_money).amount) );        
                        }
                        else {
                            mapEntity.put(mapKey, new List<string>{String.valueOf ((((objAnalysis.result).parameters).amount_money).amount)});
                        }
                     
                    }
                    
                    //command
                    if( ((objAnalysis.result).parameters).Commands != null  ) {
                        mapKey = 'command';
                        
                        if(mapEntity.containsKey(mapKey)) {
                            mapEntity.get(mapKey).add( (((objAnalysis.result).parameters).Commands) );        
                        }
                        else {
                            mapEntity.put(mapKey, new List<string>{(((objAnalysis.result).parameters).Commands)});
                        }
                    }
                    
                    
                    //document
                    if( ((objAnalysis.result).parameters).SendDocuments != null  ) {
                        mapKey = 'document';
                        
                        string docName;
                        if((((objAnalysis.result).parameters).SendDocuments).contains('send you the')) {
                            docName = (((((objAnalysis.result).parameters).SendDocuments).remove('send you the')).trim()).capitalize();    
                        }
                        else {
                            docName = (((((objAnalysis.result).parameters).SendDocuments).remove('send you')).trim()).capitalize();
                        }
                        
                        if(mapEntity.containsKey(mapKey)) {
                            mapEntity.get(mapKey).add( docName );        
                        }
                        else {
                            mapEntity.put(mapKey, new List<string>{docName});
                        }
                    }
                    // Shrykant API 
                
                }
            }
        }
        
        JsonMap=JSON.serialize(mapEntity);
        
        //System.debug('%%mapEntity' + mapEntity);
        //System.debug('%%mapEntity' + JsonMap);
        */
        return JsonMap;
    }
    
    
    //api call to google prediction api
    @RemoteAction @AuraEnabled
    global static string predictSuggestions(string cv, String revenue, string state){
        
   /*      System.debug('--->$$$cv' + cv);
          System.debug('--->$$$revenue' + revenue);
           System.debug('--->$$$state' + state);
      
        List<string> optionList = new List<string>();
        List<string> csvInstanceList = new List<string>();  
        API_AI_Setting__c objConfig = API_AI_Setting__c.getValues('Default');
        cv = cv.remove('[');
        cv = cv.remove(']');
        revenue= revenue.remove('[');
       revenue= revenue.remove(']');
         state= state.remove('[');
        state= state.remove(']');
        
        csvInstanceList.add(state);
        csvInstanceList.add(revenue.unescapeHtml4());
        csvInstanceList.add(cv.unescapeHtml4());
        
        predictWrapper reqBody = new predictWrapper();
        Input predictInput = new Input();
        predictInput.csvInstance = csvInstanceList;
        reqBody.input = predictInput;
        System.debug('--->$$$reqBody' + reqBody);
       
        String access_token = AEXP_jwtCreate.get_access_token(objConfig.Google_API_Service_Account_Id__c);
        System.debug('acces_token--->' +access_token);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
       // req.setEndpoint('https://www.googleapis.com/prediction/v1.6/projects/rare-shadow-149503/trainedmodels/amexBotV2/predict?access_token='+access_token);
        req.setEndpoint('https://www.googleapis.com/prediction/v1.6/projects/' + objConfig.Google_Prediction_Project_Name__c + '/trainedmodels/' +  objConfig.Google_Prediction_Model_Name__c+ '/predict?access_token='+access_token);
        
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        System.debug('--->$$$req' + Json.serializePretty(reqBody));
        
        System.debug('--->$$$state' +state.charAt(0));
        System.debug('--->$$$revenue' + revenue);
        System.debug('--->$$$cv' + cv);
        
        req.setBody(Json.serialize(reqBody));
        res = h.send(req);
        String response_debug = res.getBody() +' '+ res.getStatusCode();
        string response = res.getBody();
        
        PredictionResponse responseObj = new PredictionResponse();
        responseObj = (PredictionResponse)Json.deserialize(response,PredictionResponse.class);
        
        System.debug('--->$$$' + responseObj);
        
        for(OutputMulti objOptions: responseObj.outputMulti){
            if(objOptions.label != 'NA' && Double.ValueOf(objOptions.score) > 0) {
                optionList.add(objOptions.label);
            }
        }
        
        System.debug('--->$$$optionList -->' + optionList);
        return JSON.serialize(optionList);
        */
        return null;
        
    }
    
    //api call to google prediction api
    @RemoteAction
    global static boolean addFollowupTask(string cardOption, String leadId, string type){
        System.debug('cardOption-->' + cardOption + 'leadrec ' + leadId);
        //TaskAllocation__c objAllocation = new TaskAllocation__c();
        //objAllocation = [Select Id, Agent_Name__c from TaskAllocation__c where Card_Name__c =: cardOption and State__c=:state];
        list<Task> tasklist = new list<Task>();
        list<Event> lstNewEvents= new list<Event>();
        
        if(type == 'task') {
            task objTask = new task();
            objTask.OwnerId = Userinfo.getuserId();
            objTask.WhoId = leadId;
            objTask.Subject = 'Follow-up';
            objTask.status = 'Not Started';
            if(cardOption != '' && cardOption != 'NA') {
                objTask.description = 'Send '+ cardOption + 'enrollment paperwork and benefit disclosure';
            }
            else {
                objTask.description = 'Follow-Up with Customer for Card requirement';
            }
            tasklist.add(objTask);
        }
        
        if(type == 'event') {
            datetime myDateTime = datetime.now();
            Datetime newDateTime = myDateTime.addDays(7);
            Event e = new Event();
            e.StartDateTime = newDateTime;
            e.EndDateTime = newDateTime;
            e.Subject = 'Follow-up Meeting';
            e.WhoId = leadId;
            lstNewEvents.add(e);
        }
        
        try{
            if(type == 'task' && !tasklist.isEmpty()) {
                insert tasklist;
                tasklist.clear();
            }
            
            if(type == 'event' && !lstNewEvents.isEmpty()) {
                insert lstNewEvents;
                lstNewEvents.clear();
            }
            return true;
        }
        catch(Exception e) {
            System.debug('error happend:- ' + e.getMessage());
            return false;
        }
        return null;
    }
    
        
    
    public static sObject createObject(String typeName) {
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
        if (targetType == null) {
            // throw an exception
        }
        // Instantiate an sObject with the type passed in as an argument
        //  at run time.
        return targetType.newSObject(); 
    }
    
    
    //api call to google prediction api
    @RemoteAction
    global static boolean updateRecord(string command, String field, string val, string recId){
    /*    System.debug('command-->'+ command);
        System.debug('field-->'+ field);
        System.debug('val-->'+ val);
        System.debug('recId-->'+ recId);
        
        List<SObject> sObjectsToUpdate = new List<SObject>();
        AEXP_Voice_UpdateFields__c objFields = AEXP_Voice_UpdateFields__c.getValues(field);
        List<task> tasklist = new List<task>();
        
        string fieldtoUpdate = objFields.API_Field_Name__c;
        
        try {
            sObject objUpdate = createObject('Lead');
            objUpdate.put('Id' , recId);
            if(command == 'update_revenue' || command == 'update_cv') {
                system.debug('fieldtoUpdate -->' + fieldtoUpdate );
                objUpdate.put(fieldtoUpdate, decimal.valueOf(val)); 
            }
            else if(command == 'transfer_owner' || command  == 'location_not_in_territory') {
                User objUser = [Select Id, Name from User where Name = 'Amandeep singh'];
                objUpdate.put(fieldtoUpdate, objUser.Id);
                
                task objTask = new task();
                objTask.OwnerId = objUser.Id;
                objTask.WhoId = recId;
                objTask.Subject = 'Customer Enquiry';
                objTask.status = 'Not Started';
                objTask.description = 'Follow-Up with Customer';
                tasklist.add(objTask);   
            }
            else {
                objUpdate.put(fieldtoUpdate, val);
            }
            
                        
            System.debug('objUpdate-->'+ objUpdate);
            sObjectsToUpdate.add(objUpdate);
            
            if(!sObjectsToUpdate.isEmpty()) {
                update sObjectsToUpdate;
            }
            
            if(!tasklist.isEmpty()) {
                upsert tasklist;
            }
            
            return true;
        }
        catch(Exception e){
            System.debug('Error happned---:::' + e.getMessage());
            return false;
        }*/
        
        return null;
        
        
    }
    
    
    //api call to google prediction api
    @RemoteAction
    global static boolean sendEmail(string recId){
                
    /*    try {
            String docID = '015W0000000EBcj';
            Lead objLead = [Select Id, Email from Lead where Id =: recId];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            //String[] toAddresses = new String[]{objLead.Email}; //uses email limits
            //mail.setToAddresses(toAddresses);
            mail.setReplyTo('pratik.agwekar@aexp.com');
            mail.setSenderDisplayName('CRM Support');
            mail.setSubject('Product Details');
            mail.setPlainTextBody('Your Email has been sent'); 
            
            mail.setTargetObjectId(recId);
            mail.saveAsActivity = false;
       
            //Set email file attachments
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            
            Document objDoc = [Select Id, Name, Body, BodyLength,type,Contenttype from Document where Id =: docID];
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(objDoc.Name + '.' + objDoc.type);
            efa.setContenttype(objDoc.Contenttype);
            efa.setBody(objDoc.Body);
            fileAttachments.add(efa);
            
            mail.setFileAttachments(fileAttachments);
            //Send email
            
            system.debug(Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }));
            return true;
        }
        catch(Exception e){
            System.debug('Error happned---:::' + e.getMessage());
            return false;
        }*/
        
        return null;
        
        
    }
    
    
    //attache call notes
    @RemoteAction
    global static boolean attachCallNotes(string recId, String filebody, string filename){     
    /*    List<Attachment> lstAttachment = new List<Attachment>();
        String finalbody = null;
        filebody = filebody.removeStart('[');
        filebody = filebody.removeEnd(']');
        
        for(String s: filebody.split(',')) {
            if(finalbody == null) {
                finalbody = s;
            }
            else {
                finalbody = finalbody + '\n' + s;
            }
        }
        
        System.debug('--->' + finalbody );
        
        try {
            Attachment attach = new Attachment();
            Blob body = Blob.valueOf(finalbody);
            attach.Body = body;
            attach.Name = filename;
            attach.ParentId = recId;
            lstAttachment.add(attach);
            insert lstAttachment;
            return true;
        }
        catch(Exception e){
            System.debug('Error happned---attachCallNotes:::' + e.getMessage());
            return false;
        }*/
        
        return null;
    }
    
    
    //attache call notes
    @RemoteAction
    global static boolean addSuggestionFeedback(string feedback, string leadname, string recId, string agent_name){     
     /*   List<VA_Suggestion_Feedback__c> listSuggestion = new List<VA_Suggestion_Feedback__c>();
        List<suggestionWrapper> listWrapper = new  List<suggestionWrapper>();
        try {
            listWrapper = (List<suggestionWrapper>)JSON.deserialize(feedback,List<suggestionWrapper>.class);
            for(suggestionWrapper objWrap: listWrapper) {
                AEXP_Voice_Commands__c objCommand = AEXP_Voice_Commands__c.getValues(objWrap.command);
                VA_Suggestion_Feedback__c objSuggestion = new VA_Suggestion_Feedback__c();
                objSuggestion.Suggestion__c = objCommand.Sentence__c;
                objSuggestion.Status__c = objWrap.status;
                objSuggestion.Agent_Name__c = agent_name;
                objSuggestion.Client_Name__c= leadname;
                objSuggestion.RecordID__c= recId;
                objSuggestion.Category__c = objCommand.Category__c;
                listSuggestion.add(objSuggestion);
            }
            insert listSuggestion;
            return true;
        }
        catch(Exception e) {
            System.debug('Error happned---attachCallNotes:::' + e.getMessage());
            return false;
        }
        System.debug('fffff' + listWrapper);
        */
        return null;
    }

    /***Wrapper for api.ai text analysis ***/
    public class textAnalysisReq {
        public String query;
        public String lang;
        public String sessionId;
    }   
    
    public class textAnalysisResponse {
        public Result result {get;set;}
    }
    
    public class Result{
        public Parameters parameters {get;set;}     
    }
    
    public class Parameters {
        /* ***Pratik API ***/
        /*public Amount_of_money amount_of_money{get;set;}
        public String variable {get;set;} 
        public String command {get;set;} 
        public String document {get;set;} 
        public string Place;*/
        
        
        /*** Shreykant API **/
        public amount_money amount_money{get;set;}
        public String Commands {get;set;} 
        public string Place{get;set;} 
        public string Annual_Revenue{get;set;}
        public string Charge_volume{get;set;}
        public string SendDocuments{get;set;}
        
    }
    
    public class amount_money{
        public Integer amount {get;set;}
    }
    
    /***wrapper ends***/
    
    /**** Wrapper for Google prediction ***/

    public class predictWrapper {
        public Input input;
    }
    
    public class Input {
        public List<String> csvInstance;
    }
    
    public class PredictionResponse {
        public String kind;
        public String id;
        public String selfLink;
        public String outputLabel;
        public List<OutputMulti> outputMulti;
    }

    public class OutputMulti {
        public String label;
        public String score;
    }
    /**Wrapper Ends**/
    
    public class suggestionWrapper{
        public string command;
        public string status;
        public string category;
    }
    
}