({
	startCallTimer : function(cmp,hourVal,minVal,secVal) {        
        amex_timer = {};
        var hours = parseInt(hourVal, 10);
        var minutes = parseInt(minVal, 10);
        var seconds = parseInt(secVal, 10);
        amex_timer.callTimerID = setInterval(
            $A.getCallback( function () {
                if (cmp.isValid()) {
                    hours = isNaN(hours) ? 0 : hours;
                    minutes = isNaN(minutes) ? 0 : minutes;
                    seconds = isNaN(seconds) ? 0 : seconds;
                    if (seconds < 59) {
                        seconds++;                            
                    } else {
                        seconds = 0;
                        if (minutes < 59) {                                
                            minutes++;
                        } else {
                            minutes = 0;
                            hours++;
                        }
                    }
                    secOut = seconds < 10 ? '0'+seconds : seconds;
                    minOut = minutes < 10 ? '0'+minutes : minutes;
                    cmp.set('v.timer',[secOut,minOut,hours]);
                }
            }), 1000 );        
    },
    stopCallTimer : function () {
        clearInterval(amex_timer.callTimerID);
        delete amex_timer;
    },
    addCls : function (target,className) {
        if(Array.isArray(target)) {
            for(var i=0, j = target.length; i < j; i++) {            
        		$A.util.addClass(target[i],className);
        	}
        } else {
            $A.util.addClass(target,className);
        }        
    }
    
})