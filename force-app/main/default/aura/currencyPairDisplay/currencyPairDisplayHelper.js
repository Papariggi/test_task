({
    helperMethod : function(component, event, helper) {
        //once on init
        helper.callCurrencyPairCallback(component, helper);
        
        //every 'x' mins
        var intervalMs = 600000; //10 mins
        helper.callScheduler(component, helper, intervalMs);
    },
    callCurrencyPairCallback : function(component, helper) {
        var getPairsAction = component.get("c.getCalloutCurrencyPair");
        getPairsAction.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid && state == "SUCCESS") {
                var respMap = response.getReturnValue();
                //if response empty or error was received
                if (helper.isEmpty(respMap)) {
                    component.set("v.isResponseEmpty", true);
                }
                else {
                    var currencyPair = [];
                    for (var key in respMap) {
                        currencyPair.push({key:key, value:respMap[key]});
                    }
                    component.set("v.currencyPair", currencyPair);
                    component.set("v.isResponseEmpty", false);
                }
            }
        });
        $A.enqueueAction(getPairsAction);
    },
    callScheduler : function(component, helper, intervalMs) {
        window.setInterval($A.getCallback(function() {
            helper.callCurrencyPairCallback(component);
        }), intervalMs);
    },
    isEmpty : function (obj) {
        for (var prop in obj) {
            if (obj.hasOwnProperty(prop)) {
                return false;
            }
        }

        return JSON.stringify(obj) === JSON.stringify({});
    },
})
