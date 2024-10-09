public class OrderHelper {
    public static void sendOrderCompletionEmails(List<Order> orders) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Order ord : orders) {
            Account account = [SELECT Name, Email__c FROM Account WHERE Id = :ord.AccountId LIMIT 1];
            
            if (account.Email__c != null) {
                String surveyUrl = 'https://empathetic-wolf-2eq0m4-dev-ed.trailblaze.my.site.com/avaliapedido/s/order/' + ord.Id;
                String emailBody = '<p>Olá ' + account.Name + ', seu pedido foi confirmado. Aqui estão as informações:</p><br>' +
                                   '<p>Data: ' + ord.EffectiveDate.format() + '</p><br>' +
                                   '<p>Valor total: ' + ord.TotalAmount + '</p><br>' +
                                   '<p>Forma de pagamento utilizada: ' + ord.FormaPagamento2__c + '</p><br>' +
                                   '<p>Por favor, realize essa pesquisa de satisfação do seu pedido:' + '</p><br>' +
                                   '<a href="'+ surveyUrl +'"> Link da Pesquisa </a>';
                                   

                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { account.Email__c });
                email.setSubject('Seu pedido foi concluído');
                email.setHtmlBody(emailBody);

                emails.add(email);
            }
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}