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

		List<Course_Inspection__c> inspections = TestConfiguration.createInspections('inspection name ', 1, courses);
		inspections[0].Course__c = courses[0].Id;
		inspections[0].Inspection_Complete__c = date.today();
		inspections[0].Status__c = 'Complete';
		insert inspections;

		List<Course_Inspection__c> i = [SELECT Id, Status__c, Date_of_Next_Inspection__c, Inspection_Complete__c FROM Course_Inspection__c];
		i[0].Status__c = 'Complete';
		i[0].Inspection_Complete__c = date.today();
		upsert inspections;  //this should trip the trigger to create a new record

		System.assertEquals(i[0].Status__c, 'Complete');
		System.assertEquals(i[0].Inspection_Complete__c, date.today());
		System.assertEquals(i[0].Date_of_Next_Inspection__c,date.today()+365);

		List<Course_Inspection__c> i2 = [SELECT Id, Status__c, Date_of_Next_Inspection__c, Inspection_Complete__c FROM Course_Inspection__c];

		i2[1].Status__c = 'Complete';
		i2[1].Inspection_Complete__c = date.today();
		upsert i2;		

		System.assertEquals(i[1].Status__c, 'Next Annual');
		System.assertEquals(i[1].Date_of_Next_Inspection__c, date.today()+365);

		List<Course_Inspection__c> i3 = [SELECT Id, Status__c, Date_of_Next_Inspection__c, Inspection_Complete__c FROM Course_Inspection__c];

		System.assertEquals(i3[2].Status__c, 'Next Annual');
		System.assertEquals(i3[2].Date_of_Next_Inspection__c, date.today()+365);


	}
	
}