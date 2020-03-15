public with sharing class EinsteinBotQueryArticle {
    
    @InvocableMethod(label='get Article' description='get list of Article for BOT')
    public static List<ArticleOutput> createCase(List<ArticleRequest> reqs) {
        ArticleRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        }     
        String aQues = req.aQuestion;
        List<ArticleOutput> articleOutputs = new List<ArticleOutput>();
        String aName;
        
        if(aQues.containsIgnoreCase('billing')){
            aName = '000001001';
        } else if(aQues.containsIgnoreCase('order')){
            aName = '000001000';
        } else {
            return Null;
        }
        
        
        Knowledge__kav orderQuery = [SELECT id, articleNumber, knowledgeArticleID, question__C, answer__c, summary from Knowledge__kav where articleNumber =:aName LIMIT 1];
       
        
        if(orderQuery.Id!= NULL){
            ArticleOutput orderOutput = new ArticleOutput();
            orderOutput.aSummary = orderQuery.summary;
            orderOutput.aURL = 'https://deloitte-einstein-service.my.salesforce.com/' + orderQuery.id;
            
            articleOutputs.add(orderOutput);
            return articleOutputs;
        }
        else{
            return Null;
        }
        
     } 
     public class ArticleRequest {
    
        @InvocableVariable
        public string aQuestion;
        
    }
    
    public class ArticleOutput {
    
        @InvocableVariable
        public string aSummary;
        @InvocableVariable
        public string aURL;
        
    }
}