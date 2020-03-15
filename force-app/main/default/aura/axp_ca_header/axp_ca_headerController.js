({
    doInit : function(cmp, evt, helper) {
        var timer = cmp.get('v.timer');
        // call startCallTimer by passing HH:MM:SS values
        helper.startCallTimer(cmp,timer[2],timer[1],timer[0]);         
    },
	jqLoaded : function(component, event, helper) {
        $(document).ready(function() {            
        });
	},
    endCurrentCall : function (cmp, evt, helper) {
        evt.preventDefault();
        helper.stopCallTimer();
        
        var thiObj = evt.target;
        var toggleEle = [];	// array of elements to be toggled
        var toRemoveEle = [];	//array of elements to be removed
        
        cmp.set('v.callEnded',true);
        helper.addCls(cmp.find('caHeader'),'ca-call-ended-header');
        
        var callEndEvt = cmp.getEvent('callEndEvent');
        callEndEvt.setParam('callEnded',true);
        callEndEvt.fire();
    },
    preventDefault : function (cmp, evt, helper) {
        evt.preventDefault();
    },
    clickReloadCallAssistant : function (cmp, evt, helper) {
        evt.preventDefault();
        var triggerAppRefresh = cmp.getEvent('triggerAppRefreshEvent');
        triggerAppRefresh.setParams({
            'instantAppRefresh':true
        });
        triggerAppRefresh.fire();
    }
})