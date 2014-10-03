@IsTest
private class TestSetTrainingDateTrigger {
	
	//used to test the TrainingPerformed Trigger
	
	 static testMethod void myUnitTest() {
	 	
	 	//create an account
	   List<Account> accts = TestConfiguration.createAccounts('Account', 1);
	   
	   try{
	 		insert accts;	 	
	 	}catch(DmlException e){
	 		System.debug(e);
		}
	   
	   //create a couple of opportunity
	    List<Opportunity> oppsOne = TestConfiguration.createOpportunities('Opp', 2, accts, 'Closed Won');
	    for(Opportunity o : oppsOne){
	    	o.Type='Training';
	    	o.Type_of_Work__c = 'Training';
	    	o.Shipping_Delivery_Address__c = '1300 Lincoln Rd. Allegan, MI 49010';
	    }
	    
		  
   	    try{
	 		 insert oppsOne;	 	
	 	}catch(DmlException e){
	 		System.debug(e);
		}
   	   
   	 //create a couple of contacts for the account		
	   List<Contact> contacts = TestConfiguration.createContacts('Contact', 4, accts);
	   
	   contacts[0].Email='kal@ropescoursesinc.com';
	   contacts[0].Certified__c = true;
	   contacts[1].Email='brad@ropescoursesinc.com';
	   contacts[1].Certified__c = true;
	   contacts[2].Email='george@ropescoursesinc.com';
	   contacts[2].Certified__c = true;
	   contacts[1].Email='jon@ropescoursesinc.com';
	   
	   
	   try{
	 		insert contacts;		 	
	 	}catch(DmlException e){
	 		System.debug(e);
		}
	
	 
	 //look up the opportunitie we created and add the contacts as trainers and set the training certified date.  The update of the opportunities will
	 //trigger the SetTraining Date Trigger
	List<Opportunity> opps = [SELECT Id, Name, Trainer_1__c, Trainer_2__c, StageName, Certificate_Training__c, Type_of_Work__c FROM Opportunity WHERE AccountId =: accts[0].Id];
	
	 for(Opportunity o : opps){
	 	
	   	o.Certificate_Training__c=Date.today();
	   	o.Trainer_1__c = contacts[0].Id;
	   	o.Trainer_2__c = contacts[1].Id;
	   	o.Trainer_3__c = contacts[2].Id;
	   }     
	   
	   try{
	   	  update opps;
	   }catch(DmlException e){
	   	  System.debug(e);
	   }
	   
		
	//now that I have update the opportunity it should of ran the trigger.  Check and see if the contact has been updated
	
	List<Contact> c = [SELECT Id, Name, Last_Training_Performed__c FROM Contact WHERE AccountId =: accts[0].Id];
		
	System.assert(c[0].Last_Training_Performed__c  <> null);	
	System.assert(c[1].Last_Training_Performed__c <> null);
	System.assert(c[2].Last_Training_Performed__c <> null);
	System.assert(c[3].Last_Training_Performed__c == null);	
	
	   }

}