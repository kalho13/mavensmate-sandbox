@isTest
private class TestScheduledOpportunity {

    static testMethod void myUnitTest() {
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
	   contacts[1].Main_Contact__c = true;  //set one of the contacts as the Main Contact
	   contacts[1].Email='kal@ropescoursesinc.com';
	   insert contacts;	
	   
	   List<OpportunityContactRole> roles = TestConfiguration.createOpportunityContactRoles('Decision Maker', 2, accts, oppsOne, contacts);
	   roles[1].IsPrimary=true;

	 try{
	 	insert roles;
	 	
	 }catch(Exception e){
	 	System.debug(e);
	 }
	  
	   List<Opportunity> opps = [SELECT Id, Name, StageName, Type_of_Work__c FROM Opportunity WHERE AccountId =: accts[0].Id];      

	   for(Opportunity o : opps){
	   	o.StageName='Scheduled';
	   }     
	   
	   try{
	   	  update opps;
	   }catch(Exception e){
	   	  System.debug(e);
	   }
	
		List<Opportunity> oppsThree = [SELECT Name, StageName, Type_of_Work__c FROM Opportunity WHERE AccountId =: accts[0].Id];
		//add some asserts here
		for(Opportunity o : oppsThree){
			System.assert(o.StageName=='Scheduled');
		}
		
		Contact mainContact = [SELECT LastName, Email, Main_Contact__c FROM Contact c WHERE c.Main_Contact__c = true and c.AccountId =:accts[0].id ];
		System.assert(mainContact.Email!=null);	 
    }
}