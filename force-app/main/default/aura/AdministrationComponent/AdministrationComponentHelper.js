({
    getAnomalies : function(component, event, helper){
        var action = component.get("c.getAnomalies");
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var anomalyList = response.getReturnValue();
                component.set("v.noAnomalyFound", anomalyList.length === 0);
                component.set("v.anomalyList", anomalyList);
                helper.handleRecordVisibility(component, event, helper, component.get("v.currentListViewName"));
            } else{
                alert('Something went wrong');
            }
            component.set("v.isLoading", false);
        });
        $A.enqueueAction(action);
    },
    
    handleRecordVisibility : function(component, event, helper, selectedMenuItemValue){
        var anomalyList = component.get("v.anomalyList");
        var noAnomalyFound = true;
        for(var anomaly of anomalyList){
            if(selectedMenuItemValue === 'All'){
                anomaly.isShown = true;
                noAnomalyFound = false;
            } else if(selectedMenuItemValue === 'Unreported' && !anomaly.Reported__c){
                anomaly.isShown = true;
                noAnomalyFound = false;
            } else if(anomaly.Type__c.includes(selectedMenuItemValue.split(' ')[0])){
                anomaly.isShown = true;
                noAnomalyFound = false;
            } else {
                anomaly.isShown = false;
            }
        }
        component.set("v.noAnomalyFound", noAnomalyFound);
        component.set("v.anomalyList", anomalyList);
    },
})