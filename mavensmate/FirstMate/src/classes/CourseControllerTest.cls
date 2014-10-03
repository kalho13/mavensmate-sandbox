@isTest
private class CourseControllerTest {	
		
		static CourseController ext;
		static Course__c course;
		static PageReference pref;		 
				 
		 //set everything up here for each test Method
		 private static void init(){
		 	course= new Course__c(Account__c = '001d000000BO7Cb', Course_Type__c='Navigator');
		 	insert course;
		 	pref = Page.Course;
		 	pref.getParameters().put('id',course.id);
		 	Test.setCurrentPage(pref);
		 	
		 	ApexPages.standardController controller = new ApexPages.standardController(course);
		 	ext = new CourseController(controller);	
		 }
		 
		 static testMethod void testExtension(){		 	
		 	
		 	init();
		 	Test.startTest();		 			 	
		 	pref = ext.mySave();
				 	
		 	System.assertNotEquals(pref.getUrl(),'/'+ext.getCourse().Id);
		 	System.assertEquals(pref.getUrl(), '/apex/displaycourse?id=' + ext.getCourse().Id);
		 	System.assertNotEquals(ext.getCourse().Course_Type__c,'Discover');		 	
		 	
		 	pref = ext.edit();
		 	System.assertEquals(pref.getUrl(), '/apex/course?id=' + ext.getCourse().Id);
		 }
	
}