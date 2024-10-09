trigger PagamentoPadrao on Order (before insert, before update) {
    PagamentoPadraoHelper.setDefaultPaymentMethod(Trigger.new);
}