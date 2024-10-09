({
    showToast : function(component, event, helper, titulo, tipo, mensagem) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": titulo,
            "type" : tipo,
            "message": mensagem
        });
        toastEvent.fire();
    }
})