public class customAccountController {
      private final Account account;

      public customAccountController() {
            account = [Select Id, Name, Rating, CustomerPriority__c, Description, Phone,
            BillingStreet, BillingCity, BillingState, BillingPostalCode from Account 
            where id = :ApexPages.currentPage().getParameters().get('id')];
      }

      public Account getAccount() {
            return account;
      }

      public PageReference save() {
            update account;
            return null;
      }
}