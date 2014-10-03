public with sharing class TestCourseList {
	
	public static testMethod void testMe() { 
	 	//Course_Detail__c c = new Course_Detail__c(name='Test1');
	 	//CourseWrapper cw2 = new CourseWrapper(new Course_Detail__c(name='Test1'));	
	 	//System.assertEquals(cw2.course.name,'Test1');
	 	
	 	List<Course_Detail__c> testCourses = [select Id, Account__c, Model__c, Name, Year_Built__c, Selected__c, Status__c from Course_Detail__c WHERE Status__c='Open'];
		ApexPages.StandardSetController setCon = new ApexPages.StandardSetController(testCourses);
		
	//	Account testAccountFromDb = 
    // //   [SELECT Id, Name FROM Course_Detail__c WHERE Id = 'a1aQ0000000aDnDIAU'];
    //  System.assertEquals(testAccount.Id, testAccountFromDb.Id);
  /*  
    Course_Inspection__c inspection;
		
		inspection = new Course_Inspection__c();
 				inspection.Course__c = 'a1aQ0000000aDnDIAU';
 				inspection.Name = 'Test Course 33';  //this is the course id?
 				//inspection.Course_Description__c =   'Test Course - Testt Model - 2012';
 				//inspection.Inspection_Year__c = date.today().year();
 				//inspection.Inspection_Status__c = 'Pending';
 			insert	inspection;
 			
 			Course_Inspection__c ct;
 			ct =  [SELECT  Name FROM Course_Inspection__c WHERE Name = 'Test Course 33'];
      System.assertEquals(inspection.Name, ct.Name);
 	*/		
 			

//mysetcontrollerextention ext = new mysetcontrollerextension(setcon);
	 	//cw2.add(new Course_Detail__c(name='Test2')); 
	 	
	 	//System.assertEquals(cw.add(c));
	 	//System.assertEquals(c.name,'Test1');
	 	//Course_Inspection__c i = new Course_Inspection__c();
	 	
	 	
	 	CourseWrapper cw = new CourseWrapper();
    	System.assertEquals(cw.checked,false); 
    	CourseWrapper cw2 = new CourseWrapper(new Course_Detail__c(name='Test1'));
    	System.assertEquals(cw2.course.name,'Test1');
    	System.assertEquals(cw2.checked,false); 
    	
    	CourseSelectController cs = new CourseSelectController();
    	//cs.selectedCourses = new List<Course_Detail__c>();
    	//List<Course_Detail__c> selectedCourses = new List<Course_Detail__c>();
    	
    	ApexPages.StandardSetController standardSetController;
    	standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Account__c, Model__c, Name, Year_Built__c, Selected__c, Status__c from Course_Detail__c WHERE Status__c='Open']));
    	standardSetController.setPageNumber(1);
    	 System.assertEquals(1, standardSetController.getPageNumber());
    	// CourseSelectController cs1 = new CourseSelectController(standardSetController);
    	
    	
    	//this section is not considered testing for the CourseSelectController Class
    	 Course_Inspection__c testInspect = [SELECT  Name, Course_Description__c FROM Course_Inspection__c WHERE Course__c = 'a1aQ0000000aDnDIAU'];
    	testInspect.Course_Description__c='New Description';        
     	update testInspect;   
	 
	     // Verify that the billingState field was updated in the database.
	     Course_Inspection__c updatedInspect = [SELECT  Course_Description__c, Name FROM Course_Inspection__c WHERE Course__c = 'a1aQ0000000aDnDIAU'];
	     System.assertEquals('New Description', updatedInspect.Course_Description__c);
		//end of section not being tested because of ??
		
	
	 }

}