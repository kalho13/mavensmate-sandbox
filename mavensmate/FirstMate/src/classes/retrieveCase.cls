public with sharing class retrieveCase {
	
	public String getContactName(){		
		return 'Kelvin Howell';
	}
	
	public List<Case> getCases(){
		return [SELECT status, subject FROM Case WHERE Contact.name = 'Kelvin Howell' AND status !='Closed' limit 5];
	}

}