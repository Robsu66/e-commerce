trigger VerificarEstoque on OrderItem (before insert, before update) {
    ContabilizacaoEstoqueHelper.verificarEstoque(Trigger.new);
}