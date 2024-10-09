# E-commerce Salesforce

Este projeto é uma implementação de uma plataforma de e-commerce utilizando Salesforce, com o objetivo de explorar as funcionalidades da plataforma, como triggers, Apex, SOQL, Communities, e outros recursos relevantes para o desenvolvimento de um sistema de vendas online.

## Requisitos

### **Cadastro de Produtos:**
- Nome
- SKU (Código de Identificação)
- Preço
- Quantidade em Estoque

### **Cadastro de Clientes**
- Nome
- Endereço
- Telefone
- E-mail
- Forma de Pagamento Preferencial (Cartão, Pix, Boleto, Cheque)

### **Criação de Pedido**
- Data do Pedido
- Produtos
- Valor Total
- Status do Pedido: Em Carrinho / Definir Forma de Pagamento / Pedido Concluído

### **Regras de Negócio**
- **Gestão de Produtos**: Controle de estoque e listagem de produtos.
- **Gestão de Pedidos**: Criação, atualização e cancelamento de pedidos.
- **Automação de Processos**: Implementação de triggers para automatizar fluxos de negócios, como controle de estoque e validação de pedidos.
- **Avaliação de Compras**: Envio de pesquisas de satisfação após a conclusão de pedidos, permitindo que os clientes avaliem suas compras.
- **Pagamento**: Processos de definir e validar formas de pagamento em diferentes etapas do pedido.
- **Communities**: Utilização do Salesforce Communities para permitir que os clientes acompanhem seus pedidos e façam avaliações.
- **Integração de Email**: Envio de e-mails automáticos para confirmação de compra, lembretes e atualizações de status do pedido.

## Estrutura do Projeto

- **Apex Classes**
  - `OrderController`: Controla as ações relacionadas aos pedidos, como criação e fechamento de pedidos.
  - `PagamentoPadraoHelper`: Gerencia as formas de pagamento preferenciais.
  - `ControleQuantidadeHelper`: Valida a quantidade disponível em estoque.
  - `AvaliarPedidoController`: Lida com a lógica de avaliação de pedidos.
  
- **Triggers**
  - `ControleQuantidade`: Valida o estoque no momento da compra.
  - `ValidaData`: Garante que os pedidos não sejam criados com datas anteriores à data atual.
  
- **Componentes Aura**
  - Formulários para atualização de status de pedidos, envio de avaliações e visualização de detalhes do pedido.
  
- **SOQL Queries**
  - Consultas de dados para verificar o estoque, buscar informações de produtos e gerenciar pedidos em tempo real.

## Fotos do Projeto

**Validação da Conta**
![conta_validacao](images/conta_validacao.png)

**Validação do Produto**
![produto_validacao](images/produto_validacao.png)

**Validação de Data**
![data_validacao](images/data_validacao.png)

**Validação de Pedido**
![pedido_validacao](images/pedido_validacao.png)

**Validação de Pedido Paralelo**
![pedido_paralelo_validacao](images/em_carrinho_validacao.png)

**E-mail de Estoque**
![estoque_email](images/estoque_email.png)

**E-mail de Pedido**
![pedido_email](images/pedido_email.png)

**Avaliação do Pedido**
![avaliacao](images/avaliacao.png)
