public class AccountController {
	
	@RemoteAction 
	public static List<Account> getAll(){
		  return [SELECT Id, Name FROM Account ORDER BY Name LIMIT 20];	
	}
	
	
	@RemoteAction
	public static List<Account> getAccounts(){
		 return [SELECT Id, Name, BillingCity, BillingState, BillingStreet, BillingPostalCode, BillingCountry, Location__Latitude__s, Location__Longitude__s FROM Account ORDER BY Name LIMIT 20];
		
	}

}