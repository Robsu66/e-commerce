public class EstoqueAlertaHelper {
    public static void enviarNotificacaoEstoqueZerado(List<Product2> produtosParaNotificar) {
        for (Product2 produto : produtosParaNotificar) {
            String destinatario = 'robsondiaswp@gmail.com';
            String assunto = 'Estoque Zerado: ' + produto.Name;
            String corpo = 'O estoque do produto ' + produto.Name + ' atingiu zero.';

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { destinatario });
            email.setSubject(assunto);
            email.setPlainTextBody(corpo);

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }
    }
}