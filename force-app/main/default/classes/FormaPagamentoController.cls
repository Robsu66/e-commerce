public with sharing class FormaPagamentoController {

    @AuraEnabled
    public static void fecharPedido(String recordId){
        update new Order(Id = recordId, Status = 'Pedido Concluído');
    }

}