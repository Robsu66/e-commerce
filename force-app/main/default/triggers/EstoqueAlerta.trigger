trigger EstoqueAlerta on Product2 (after update) {
    List<Product2> produtosZerados = new List<Product2>();

    for (Product2 prod : Trigger.new) {
        if (prod.QuantidadeEstoque__c == 0 && Trigger.oldMap.get(prod.Id).QuantidadeEstoque__c != 0) {
            produtosZerados.add(prod);
        }
    }

    if (!produtosZerados.isEmpty()) {
        EstoqueAlertaHelper.enviarNotificacaoEstoqueZerado(produtosZerados);
    }
}