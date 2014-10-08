@isTest
private class publicMapControllerTest {
	
@isTest
   private static void testGetOpenCourses(){
    List<Course_Detail__c> control = new List<Course_detail__c>();
    Account account = new Account(Name='Customer One', Location__Latitude__s=36.3809047, Location__Longitude__s = -85.83021);
    insert account;
    control.add(new Course_Detail__c(Name='Course1', Status__c='Active', Account__c = account.id));
    control.add(new Course_Detail__c(Name='Course2', Status__c='Active', Account__c = account.id));
    insert control;
    List<Course_Detail__c> actual = publicMapController.getOpenCourses();
    System.assert(actual.size()!=2);
   } 
	
}