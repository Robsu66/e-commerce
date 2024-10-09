public class ContabilizacaoEstoqueHelper {
    
    public static void verificarEstoque(List<OrderItem> orderItems) {
        // Armazena os IDs dos produtos adicionados
        Set<Id> productIds = new Set<Id>();
        for (OrderItem oi : orderItems) {
            productIds.add(oi.Product2Id);
        }
        
        // Buscar a quantidade de estoque e o nome dos produtos
        List<Product2> products = [SELECT Id, Name, QuantidadeEstoque__c FROM Product2 WHERE Id IN :productIds];
        Map<Id, Product2> productMap = new Map<Id, Product2>();
        for (Product2 p : products) {
            productMap.put(p.Id, p);
        }
        
        // Verificar se a quantidade solicitada excede o estoque disponível
        for (OrderItem oi : orderItems) {
            Product2 product = productMap.get(oi.Product2Id);
            if (product != null && product.QuantidadeEstoque__c != null && oi.Quantity > product.QuantidadeEstoque__c) {
                // Exibir erro na tela se a quantidade for maior que o estoque disponível
                oi.addError('A quantidade solicitada (' + oi.Quantity + ') para o produto ' + product.Name +
                            ' excede o estoque disponível (' + product.QuantidadeEstoque__c + ').');
            }
        }
    }
    
    // Verifica e deduz estoque ao mudar o status para "Definir Forma de Pagamento" ou "Pedido Concluído"
    public static void verificarEDeduzirEstoque(List<Order> orders) {
        Set<Id> orderIds = new Set<Id>();
        for (Order o : orders) {
            orderIds.add(o.Id);
        }
        
        // Buscar todos os OrderItems relacionados aos pedidos
        List<OrderItem> orderItems = [SELECT Id, Product2Id, Quantity, Product2.Name FROM OrderItem WHERE OrderId IN :orderIds];
        Map<Id, Decimal> productStock = new Map<Id, Decimal>();
        
        // Agregar a quantidade total por produto
        for (OrderItem oi : orderItems) {
            if (!productStock.containsKey(oi.Product2Id)) {
                productStock.put(oi.Product2Id, 0);
            }
            productStock.put(oi.Product2Id, productStock.get(oi.Product2Id) + oi.Quantity);
        }
        
        // Buscar o estoque atual dos produtos
        List<Product2> products = [SELECT Id, QuantidadeEstoque__c FROM Product2 WHERE Id IN :productStock.keySet()];
        Map<Id, Decimal> currentStock = new Map<Id, Decimal>();
        for (Product2 p : products) {
            currentStock.put(p.Id, p.QuantidadeEstoque__c);
        }
        
        // Verificar se a quantidade solicitada excede o estoque disponível
        for (OrderItem oi : orderItems) {
            Decimal availableStock = currentStock.get(oi.Product2Id);
            
            if (availableStock != null && oi.Quantity > availableStock) {
                // Exibir erro e impedir fechamento caso o estoque seja insuficiente
                oi.addError('Erro: A quantidade solicitada (' + oi.Quantity + ') para o produto ' + oi.Product2.Name +
                            ' excede o estoque disponível (' + availableStock + '). Pedido não pode avançar.');
            } else if (availableStock != null && orders[0].Status == 'Pedido Concluído') {
                // Deduzir o estoque apenas no fechamento final (status "Pedido Concluído")
                currentStock.put(oi.Product2Id, availableStock - oi.Quantity);
            }
        }
        
        // Atualizar o estoque dos produtos caso o pedido seja concluído
        if (orders[0].Status == 'Pedido Concluído') {
            List<Product2> updatedProducts = new List<Product2>();
            for (Product2 p : products) {
                p.QuantidadeEstoque__c = currentStock.get(p.Id);
                updatedProducts.add(p);
            }
            update updatedProducts;
        }
    }
}