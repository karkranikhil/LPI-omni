({
	doinit : function(component, event, helper) {
		var action = component.get("c.getPiclistFieldValue");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for (var key in result) {
                    fieldMap.push({ key: key, value: result[key] });
                }
                component.set("v.licensetypes", fieldMap);
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) { 
                        // log the error passed in to AuraHandledException
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
	},
    searchlicenses : function(component, event, helper) {
        
		var action = component.get("c.searchlicensesandpermits");
        var searchkey = component.get("v.searchkey");
        /*if(!searchkey){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "message": "Please enter Licensee Name or License Number",
                    "type":"error"
                });
            toastEvent.fire();
            return;
        }*/
        action.setParams({searchkey:searchkey,typeoflicense:component.get("v.typeoflicense")});
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.listOfResults", result);
                //alert(component.get("v.listOfResults").length) ;
                if(component.get("v.listOfResults").length>0){
                    component.set("v.showTable", true);
                }
            }
        });
        $A.enqueueAction(action);
	},
    
   
})