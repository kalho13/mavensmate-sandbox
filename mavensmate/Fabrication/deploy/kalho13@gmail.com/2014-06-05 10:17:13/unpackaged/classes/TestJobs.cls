@isTest
private class TestJobs {
	
	//compare the flags with expected results

	@IsTest static void init(){



		List<Account> testAccounts = TestConfiguration.createAccounts('Account', 2);
		insert testAccounts;
		List<Job__c> testJobs = TestConfiguration.createJobs(3, testAccounts);
		insert testJobs;
		List<Job_Part__c> testParts = TestConfiguration.createJobParts(10, testJobs);

		//iterate through the parts and set fabrication to true

		for(Job_Part__c p:testParts){
			p.Fabrication__c=true;
		}

		insert testParts;

		//get a job that was created
		List<Job__c> queryJob =  [SELECT Id, Name FROM Job__c where Id =: testJobs[0].Id];
		SelectedPartsController controller = new SelectedPartsController(queryJob[0]);

		controller.checkFabrication=true;
		controller.checkPaint=false;
		controller.checkShipping=false;

		//now call then selectedParts method
		List<Job_Part__c> queryParts = controller.getSelectedParts();


		//check for the number of parts returned
		Integer partCount = queryParts.size();
		system.assertEquals(partCount, 10);
		system.assertEquals(queryParts[2].Fabrication__c, true);
		system.assertEquals(queryParts[1].Paint__c, false);
		system.assertEquals(queryParts[2].Shipping__c, false);
		system.assertEquals(controller.checkPaint, false);

		//get a list of parts that were create

		//verify the parts have Fabrcation__c as true

		//ApexPages.StandardController sc = new ApexPages.StandardController(equipment); //ok
		//SafetyEquipmentController cont = new SafetyEquipmentController(sc); //ok
	}
	
	
}