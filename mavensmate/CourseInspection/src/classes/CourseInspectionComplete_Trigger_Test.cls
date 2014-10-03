@isTest
private class CourseInspectionComplete_Trigger_Test {
	
	@isTest static void test_method_one() {

		List<Account> accounts = TestConfiguration.createAccounts('AccountName ', 1);
		insert accounts;

		List<Opportunity> opps = TestConfiguration.createOpportunities('opp Name ', 1, accounts, 'Scheduled');
		opps[0].Shipping_Delivery_Address__c = '123 Main';

		insert opps;

		List<Course_Detail__c> courses = TestConfiguration.createCourses('Course Name ', 1, accounts);		
		courses[0].Account__c = accounts[0].Id;
		courses[0].Opportunity__c = opps[0].Id;
		courses[0].Model__c = 'Explorer';
		insert courses;

		List<Course_Inspection__c> inspections = TestConfiguration.createInspections('inspection name ', 2, courses);

		//fire the trigger for a new record that is complete.  This should create the 3rd record
		inspections[0].Course__c = courses[0].Id;
		inspections[0].Inspection_Complete__c = date.today();
		inspections[0].Status__c = 'Complete';

		//no trigger here
		inspections[1].Course__c = courses[0].Id;
		inspections[1].Status__c = 'Scheduled';
		insert inspections;

		date tempDate = date.today();
		date expDate = tempDate.addYears(1);

		//Now Update the record to trigger the trigger
		List<Course_Inspection__c> i = [SELECT Id, Status__c, Date_Of_Expiration__c, Date_Of_Last_Inspection__c, Inspection_Complete__c FROM Course_Inspection__c];

		//this assert works fine
		System.assertEquals(i[0].Status__c, 'Complete');
		System.assertEquals(i[0].Inspection_Complete__c, date.today());
		System.assertEquals(i[2].Date_Of_Last_Inspection__c, date.today());


		//update and update the 2nd record to get the trigger to fire to create the 3rd record
		i[1].Status__c = 'Complete';
		i[1].Inspection_Complete__c = date.today();
		upsert i;  

		List<Course_Inspection__c> i2 = [SELECT Id, Status__c, Date_Of_Expiration__c, Date_Of_Last_Inspection__c, Inspection_Complete__c FROM Course_Inspection__c];
		//Test the assert again the 3rd record created
		System.assertEquals(i2[2].Status__c, 'Next Annual');
		System.assertEquals(i2[2].Inspection_Complete__c, null);
		System.assertEquals(i[2].Date_Of_Expiration__c,expDate); //we now should have an expiration date

		//now update the 3rd record that was created automatically by the trigger to complete and fire the trigger again
		i2[2].Status__c = 'Complete';
		i2[2].Inspection_Complete__c = date.today();
		upsert i2;		

		List<Course_Inspection__c> i3 = [SELECT Id, Status__c, Date_Of_Expiration__c, Date_Of_Last_Inspection__c, Inspection_Complete__c FROM Course_Inspection__c];

		System.assertEquals(i3[2].Status__c, 'Complete');
		System.assertEquals(i3[2].Date_Of_Expiration__c, expDate);


	}
	
}