public without sharing class AvaliacaoPedidoController {
    @AuraEnabled
    
    public static string avaliacao(String nota, String recordId){
        try {
            system.debug(recordId);
            Order pedido = new Order (Id = recordId,  Avaliacao__c = nota);
            update pedido;
            return JSON.serialize('Success');
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}