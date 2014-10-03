public class mapV4Controller {
	
	   
   @RemoteAction
   public static List<Course_Detail__c> getOpenCourses(){
   	return [SELECT 
   				Id, 
   				Name, 
   				Account__r.Name, 
   				Account__r.Location__Latitude__s, 
   				Account__r.Location__Longitude__s,
   				Account__r.ShippingStreet, 
   				Account__r.ShippingCity, 
   				Account__r.ShippingState, 
   				Account__r.ShippingPostalCode, 
   				Account__r.ShippingCountry, 
   				Account__r.Website,
   				Model__c, 
   				Year_Built__c, 
   				Status__c 
   				FROM Course_Detail__c 
   				WHERE Status__c='Open' and Account__r.Location__Latitude__s != null];      	
   				
   }	
   
   @isTest
   private static void testGetOpenCourses(){
   	List<Course_Detail__c> control = new List<Course_detail__c>();
   	Account account = new Account(Name='Customer One', Location__Latitude__s=36.3809047);
   	insert account;
   	control.add(new Course_Detail__c(Name='Course1', Status__c='Open', Account__c = account.id));
   	control.add(new Course_Detail__c(Name='Course2', Status__c='Open', Account__c = account.id));
   	insert control;
   	List<Course_Detail__c> actual = mapV4Controller.getOpenCourses();
   	System.assert(actual.size()==2);
   }  
 
}