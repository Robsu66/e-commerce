public with sharing class EstoqueAlertaController {
    @AuraEnabled
    public static void atualizarStatusParaConcluido(Id recordId) {
        Order order = [SELECT Id, Status FROM Order WHERE Id = :recordId LIMIT 1];
        if (order != null && order.Status == 'Definir Forma de Pagamento') {
            order.Status = 'Pedido Concluído';
            update order;
        }
    }
}