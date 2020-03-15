({  
    doInit: function(cmp) {
        cmp.set("v.chatbotSessionId", Math.random() * 10000000000000000000);
        cmp.set("v.lastChatbotResponse", null);
		var action = cmp.get("c.getClientName");
		action.setCallback(this, function(response){
        	var state = response.getState();
	        if (state === "SUCCESS") {
	            cmp.set("v.clientName", response.getReturnValue());
         	}
      	});
        $A.enqueueAction(action);      
    },

    handleChatbotResponse : function(cmp, event) {
		var param = event.getParam('arguments');
        var data = param.data;        
        cmp.set("v.lastChatbotResponse", data);
        var agentMessage = cmp.get("v.lastChatbotResponse").responseJSON.result.fulfillment.speech;        
        if(0 == data.responseJSON.result.contexts.length && data.responseJSON.result.metadata.intentName == 'New Case') {
            var params = data.responseJSON.result.parameters;
			var action = cmp.get("c.createCase");
            action.setParams({ 
                			 	product : params.About[0],
                				description: params.Description[0],
                                email : params.Email[0],
                                priority : params.Priority[0]
                             });
			action.setCallback(this, function(response) {
				var state = response.getState();
                if (state === "SUCCESS") {
                	cmp.appendAgentChat(agentMessage + response.getReturnValue());
                }
            });
            $A.enqueueAction(action);            
        }
        else if(0 == data.responseJSON.result.contexts.length && data.responseJSON.result.metadata.intentName == 'Existing Case') {
            var params = data.responseJSON.result.parameters;                
            var action = cmp.get("c.getCaseDetails");
            action.setParams({ caseNumber : params.caseNumber[0]});
			action.setCallback(this, function(response) {
				var state = response.getState();
                if (state === "SUCCESS") {
                	cmp.appendAgentChat(agentMessage + response.getReturnValue());
                }
            });
            $A.enqueueAction(action);
        }  
        else {
            cmp.appendAgentChat(agentMessage);
        }
    },

    appendAgentChat : function(cmp, event) {
        var params = event.getParam('arguments');
        var message = params.message;
        message = message.replace('<clientname>', cmp.get("v.clientName"));
        message = message.replace('<clientName>', cmp.get("v.clientName"));        
        var chatLog = cmp.find("chatLog").get("v.value");
        cmp.getCurrentTime();
        chatLog += cmp.get("v.currentTime") + ' Agent: ' + message;
        cmp.find("chatLog").set("v.value", chatLog + '\n'); 
        $('.chatLog').scrollTop($('.chatLog')[0].scrollHeight);
	},
 
    chatbotSendMessage : function(cmp, event) {
		var params = event.getParam('arguments');
        var userText = params.userText;
        // Form request body
        var reqBody = new Object();
        reqBody.lang = 'en';
        reqBody.query = userText;
        reqBody.sessionId = cmp.get("v.chatbotSessionId");
        
        // Fill in the contexts
        var lastChatbotResponse = cmp.get("v.lastChatbotResponse");
        if(null != lastChatbotResponse && 0 < lastChatbotResponse.responseJSON.result.contexts.length) {
            reqBody.contexts = lastChatbotResponse.responseJSON.result.contexts;
            reqBody.contexts[reqBody.contexts.length - 1].parameters.Name = userText;                
		}           

        // Make call to Google API
        $.ajax({
            url: "https://api.api.ai/v1/query?v=20150910",
            type: "POST",
            data: JSON.stringify(reqBody),
            contentType: "application/json",
            headers: { 'Authorization' : 'Bearer ' + '44b71f3521a34e1dba4d10ae4380fcfa' },
            complete: cmp.handleChatbotResponse
        });   
	},
        
    getCurrentTime : function(cmp, event) {
        var date_obj = new Date();
        var hour = date_obj.getHours();
        var minute = date_obj.getMinutes();
        var amPM = (hour > 11) ? "pm" : "am";
        if(hour > 12) {
            hour -= 12;
        } else if(hour == 0) {
            hour = "12";
        }
        if(minute < 10) {
            minute = "0" + minute;
        }
        cmp.set("v.currentTime", hour + ":" + minute + amPM);
    },  
    
    sendChat : function(cmp, event) {
        var userText = cmp.find("chatInput").get("v.value");
        cmp.find("chatInput").set("v.value", "");
        var chatLog = cmp.find("chatLog").get("v.value");
        cmp.getCurrentTime();
        chatLog += cmp.get("v.currentTime") + ' Me: ' + userText;
        cmp.find("chatLog").set("v.value", chatLog + '\n');
        cmp.find("chatInput").set("v.value", '');
        cmp.chatbotSendMessage(userText);
	},
    
    handleSendButtonClick : function(cmp, event) {
        cmp.sendChat();
    },
    
    handleClientInputKeyUp : function(cmp, event) {
    	if(event.getParams().keyCode == 13){
        	cmp.sendChat();
    	}
    }
})