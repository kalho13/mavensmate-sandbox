@isTest
private class TestCertificationStatus {

    static testMethod void myUnitTest() {
    	
    	/*
    		Need to create the following record types.
    		1.  Account
    		2.  Contact
    		3.  Opportunbity
    		4.  Course
    		5.  Course Inspections
    		6.  Training Certifications (for the contacts)
    	
    	*/
    	//I am adding a single account as I am testing a button on the account record
    	 List<Account> accts = TestConfiguration.createAccounts('Account', 1);
 		insert accts;	 
		
		//Add Contacts
		List<Contact> contacts = TestConfiguration.createContacts('Name ', 4, accts);
		insert contacts;
		
		//Add Certifications to the Contacts
		List<Certification__c> certifications = TestConfiguration.createCertifications('None', 3, contacts, Date.valueOf('2012-11-04'));
		certifications[0].Certification_Type__c = 'Inspection - Custom';
		certifications[1].Certification_Type__c = 'Training - SkyTrail';
		certifications[2].Certification_Type__c = 'Training - Zip Line';
		insert certifications;
		
		//Add Opportunities
		List<Opportunity> opps = TestConfiguration.createOpportunities('Opportunity ', 4, accts, 'Closed Won');
		
		opps[0].Shipping_Delivery_Address__c='123 Main';
		opps[1].Shipping_Delivery_Address__c='123 Main';
		opps[2].Shipping_Delivery_Address__c='123 Main';
		opps[3].Shipping_Delivery_Address__c='123 Main';	
		
		String multi = 'Training;Internal;Project;Inspection Training;';
		opps[0].Type_of_Work__c='Project';
		opps[1].Type_of_Work__c= multi;
		opps[1].Certificate_Training__c= Date.valueOf('2011-11-04');
		opps[2].Type_of_Work__c='Internal';
		opps[3].Type_of_Work__c=multi;
		opps[3].Certificate_Training__c= Date.valueOf('2013-04-13');
	
		insert opps;	 
	    
	    //with the account created I will create 3 course records
	    //should all of these courses be active?
	    List<Course_Detail__c> courses = TestConfiguration.createCourses('Course ', 3, accts);	    
	   
	    for(Course_Detail__c c: courses){
	    	c.Status__c = 'Active';
	    }
	    
 		insert courses;	 		 
		
		//add the course inspections at 3 per course		
		List<Course_Inspection__c> inspections = TestConfiguration.createInspections('Inspection ', 3, courses);
		
		//mark some of the inspections as archivedc	
		inspections[0].Archive__c = true;
		inspections[1].Archive__c = true;
		inspections[3].Archive__c = true;
		inspections[4].Archive__c = true;
		inspections[6].Archive__c = true;
		inspections[7].Archive__c = true;

	 	insert inspections;	 
	 
	 	List<Account> a = [SELECT Id, Name from ACCOUNT where Id =: accts[0].Id];
	 	
	 	//pass in the acct to the CertificationStatusController constructor
	 	CertificationStatusController controller = new CertificationStatusController(a[0]);
	 	
	 	//get the number of courses found an perform an assertion
	 	List<Course_Detail__c> courses1 = controller.getCourses();
	 	Integer csize = courses1.size();
		system.assertEquals(csize, 3);
	 	
	 	//test the number of course inspections return
	 	List<Course_Inspection__c> inspection1 = controller.getInspections();
	 	Integer isize = inspection1.size();
		system.assertEquals(isize, 3);
		
		//test the number of opportunities returned
		List<Opportunity> opps1 = controller.getOpportunities();
		Integer osize = opps1.size();						
		system.assertEquals(osize, 2);
	
		//test the number of certifications returned
		List<Certification__c> certification1 = controller.getCertifications();
		Integer cesize = certification1.size();
		system.assertEquals(cesize, 12);

    }
}