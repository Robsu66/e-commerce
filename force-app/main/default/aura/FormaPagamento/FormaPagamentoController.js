({
    handleSubmit: function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam('fields');
        
        component.find('ProdutoPedido').submit(fields);
        
    },
    handleSuccess: function(component, event, helper) {
        helper.showToast(component, event, helper, 'Sucesso!', 'success', 'Forma de Pagamento Confirmada')
        // const action = component.get("c.fecharPedido")
        // action.setParams({
        //     recordId: component.get('v.recordId')
        // })
        // action.setCallback(this, function(response) {
        //     const state = response.getState();
        //     if (state === "SUCCESS"){
        //         helper.showToast(component, event, helper, 'Sucesso!', 'success', 'Forma de Pagamento Confirmada')
        //         $A.get("e.force:refreshView").fire()
        //     }
        // })
        // $A.enqueueAction(action)
    },
    handleError: function(component, event, helper) {
        helper.showToast(component, event, helper, 'Erro!', 'error', 'Inconsistência nos dados')
    }
    
})