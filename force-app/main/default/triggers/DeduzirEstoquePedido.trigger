trigger DeduzirEstoquePedido on Order (after update) {
    List<Order> ordersToCheck = new List<Order>();
    
    // Verificar se o status foi atualizado para "Definir Forma de Pagamento" ou "Pedido Concluído"
    for (Order o : Trigger.new) {
        Order oldOrder = Trigger.oldMap.get(o.Id);
        if ((o.Status == 'Definir Forma de Pagamento' || o.Status == 'Pedido Concluído') && oldOrder.Status != o.Status) {
            ordersToCheck.add(o);
        }
    }

    if (!ordersToCheck.isEmpty()) {
        ContabilizacaoEstoqueHelper.verificarEDeduzirEstoque(ordersToCheck);
    }
}