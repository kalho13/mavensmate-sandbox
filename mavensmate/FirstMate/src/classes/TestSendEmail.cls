@isTest
private class TestSendEmail {
	
	//I need to update an Opportunity with the Type as project and stage as scheduled
	//my naming should be testing for the trigger or the actual send email code?
    static testMethod void sendEmailTest() {
         List<Account> accts = TestConfiguration.createAccounts('Account', 1);
	   insert accts;
	   
	    List<Opportunity> oppsOne = TestConfiguration.createOpportunities('Opp', 5, accts, 'Prospecting');
	    for(Opportunity o : oppsOne){
	    	o.Type='Project';
	    	o.Type_of_Work__c = 'Project';
	    	o.Shipping_Delivery_Address__c = '1300 Lincoln Rd. Allegan, MI 49010';
	    }
	    
   	   insert oppsOne;
   	   
   	   //now I have the opportunities.  Need to query and initiate the trigger when scheduled.		
	   List<Contact> contacts = TestConfiguration.createContacts('Contact', 5, accts);
	   contacts[3].Main_Contact__c = true;  //set one of the contacts as the Main Contact
	   contacts[3].Email='kal@ropescoursesinc.com';
	   insert contacts;	
	  
	   List<Opportunity> opps = [SELECT Id, Name, StageName, Type_of_Work__c FROM Opportunity WHERE AccountId =: accts[0].Id];

	   for(Opportunity o : opps){
	   	o.StageName='Scheduled';
	   }
	   update opps;
	
		List<Opportunity> oppsThree = [SELECT Name, StageName, Type FROM Opportunity WHERE AccountId =: accts[0].Id];
		//add some asserts here
		for(Opportunity o : oppsThree){
			System.assert(o.StageName=='Scheduled');
		}
		
		Contact mainContact = [SELECT LastName, Email, Main_Contact__c FROM Contact c WHERE c.Main_Contact__c = true and c.AccountId =:accts[0].id ];
		System.assert(mainContact.Email!=null);	 
    }
}