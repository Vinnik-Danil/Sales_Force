({
    doInit : function(component, event, helper) {
        component.set("v.isLoading", true);
        helper.getAnomalies(component, event, helper);
	},
    
    handleListSelect : function(component, event, helper) {
		var selectedMenuItemValue = event.getParam("value");
        if(selectedMenuItemValue !== component.get("v.currentListViewName")){
            component.set("v.currentListViewName", selectedMenuItemValue);
            helper.handleRecordVisibility(component, event, helper, selectedMenuItemValue);
        }
	},
    
    onMenuOpen : function(component, event, helper) {
        var selectedOption = component.get("v.currentListViewName");
        for(var item of component.find("menuItems")){
            item.set("v.checked", item.get("v.value") === selectedOption);
        }
    },
    
    generateReport: function(component, event, helper) {
        component.set("v.isLoading", true);
        var action = component.get("c.generateAnomalyReport");
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Report was generated successfully!",
                    "type": "success"
                });
                toastEvent.fire();
                helper.getAnomalies(component, event, helper);
            } else{
                alert('Something went wrong');
            }
            component.set("v.isLoading", false);
        });
        $A.enqueueAction(action);
	},
    
    getWeather: function(component, event, helper) {
        component.set("v.isLoading", true);
		var action = component.get("c.getCurrentWeather");
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                helper.getAnomalies(component, event, helper);
            } else{
                alert('Something went wrong');
            }
        });
        $A.enqueueAction(action);
	},
})