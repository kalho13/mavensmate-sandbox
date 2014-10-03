@isTest
private class InspectionMapController_Test {
	
	@isTest  private static void testGetCourseInspections(){
    
    List<Account> accounts = TestConfiguration.createAccounts('Account Name', 1);
    accounts[0].Location__Latitude__s = 31.82752;
    accounts[0].Location__Longitude__s = -85.83021;
    insert accounts;
    List<Course_Detail__c> courses = TestConfiguration.createCourses('Course Name', 2, accounts);
    courses[0].Distributor__c = true;
    courses[1].Distributor__c = false;
    courses[1].Status__c='Active';
    insert courses;
    List<Course_Inspection__c> inspections = TestConfiguration.createInspections('Inspection Name', 2, courses);
    inspections[0].Status__c = 'Complete';
    inspections[1].Date_of_Last_Inspection__c = Date.parse('08/13/2014');
    inspections[1].Status__c = 'Next Annual';
   insert inspections;    
   
    List<Course_Inspection__c> actualInspections = inspectionMapController.getCourseInspections();
   // System.debug('actualInspections returned: ' + actualInspections.size());
    System.assertEquals(actualInspections.size(), 0);
   }  
	
	
	
}