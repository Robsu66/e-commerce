public class PagamentoPadraoHelper {
    public static void setDefaultPaymentMethod(List<Order> orders) {
        // Obter IDs das contas associadas aos pedidos
        Set<Id> accountIds = new Set<Id>();
        for (Order ord : orders) {
            if (ord.AccountId != null) {
                accountIds.add(ord.AccountId);
            }
        }
        
        // Consultar as formas de pagamento preferenciais das contas
        Map<Id, Account> accounts = new Map<Id, Account>([
            SELECT Id, FormaPagamento__c FROM Account WHERE Id IN :accountIds
        ]);
        
        // Atribuir a forma de pagamento preferencial ao campo FormaPagamento2__c do pedido, se ele não estiver definido
        for (Order ord : orders) {
            if (ord.AccountId != null && accounts.containsKey(ord.AccountId)) {
                // Verifica se o campo FormaPagamento2__c está vazio ou não foi alterado
                if (ord.FormaPagamento2__c == null || ord.FormaPagamento2__c == '') {
                    ord.FormaPagamento2__c = accounts.get(ord.AccountId).FormaPagamento__c;
                }
            }
        }
    }
}