public class mapV3Controller {
	
	   
   @RemoteAction
   public static List<Course_Detail__c> getOpenCourses(){
   	return [SELECT Id, Name, Account__r.Name, Distributor__c, Account__r.ShippingStreet, Account__r.ShippingCity, Account__r.ShippingState, Account__r.ShippingPostalCode, Account__r.ShippingCountry, Model__c, Year_Built__c, Status__c 
   				FROM Course_Detail__c 
   				WHERE Status__c='Open'
   				LIMIT 10];      	
   }			

}