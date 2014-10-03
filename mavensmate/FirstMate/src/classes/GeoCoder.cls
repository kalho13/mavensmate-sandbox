public class GeoCoder {

	public static Account acct;	
	

	
	 public GeoCoder(ApexPages.StandardController stdController) {
       acct = (Account)stdController.getRecord();
       //System.debug('getParameter ' + ApexPages.currentPage().getParameters().get('id'));
      // System.debug('################# Account Id is ' + acct.Id);
	
    }
	
	
	@RemoteAction
	public static List<Account> getAccounts(String key){
		 return [SELECT Id, Name, BillingCity, BillingState, BillingStreet, BillingPostalCode, BillingCountry, Location__Latitude__s, Location__Longitude__s FROM Account WHERE Id =:key];
		
	}	
	
	@RemoteAction
	public static void setLocation(Double latitude, Double longitude, String key){		
		//this works to this point.  Now what is the best way to get a handle on the account and pass the long and lat?
		System.debug('************* setLocation Latitude ' + latitude);
		System.debug('************** setLocation Latitude ' + longitude);
		
		Account account = [SELECT Id, Name, BillingCity, BillingState, BillingStreet, BillingPostalCode, BillingCountry FROM Account WHERE Id =:key];
		account.Location__Latitude__s = latitude;
		//account.Location__Longitude__s = longitude;
		update account;
	}

}