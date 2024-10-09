trigger EmailAlerta on Order (after update) {
    List<Order> completedOrders = new List<Order>();
    
    for (Order ord : Trigger.new) {
        if (ord.Status == 'Pedido Concluído' && ord.Status != Trigger.oldMap.get(ord.Id).Status) {
            completedOrders.add(ord);
        }
    }
    
    if (!completedOrders.isEmpty()) {
        OrderHelper.sendOrderCompletionEmails(completedOrders);
    }
}