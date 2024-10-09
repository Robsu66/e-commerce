({
    handleClick : function(component, event, helper) {
        var action =component.get("c.avaliacao");
        var recordId = component.get('v.recordId');
        action.setParams({ 
            recordId: recordId,
            nota: component.get('v.value') 
        });
        console.log("component.get('v.recordId')" + component.get('v.recordId'));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("Resposta enviada com sucesso, obrigado");
            }
            else if (state === "INCOMPLETE") {
                alert("Não foi possível completar a operação, Desculpe");
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Houve um erro:" + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Houve um erro desconhecido");
                }
            }
        });
        $A.enqueueAction(action);
    }
})