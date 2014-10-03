public class courseGridController {
	
	
   @RemoteAction
   public static List<Course_Detail__c> getOpenCourses(){
   	return [SELECT Id, Name, Account__r.Name, Distributor__c, Account__r.ShippingStreet, Account__r.ShippingCity, Account__r.ShippingState, Account__r.ShippingPostalCode, Account__r.ShippingCountry, Model__c, Year_Built__c, Status__c 
   				FROM Course_Detail__c 
   				WHERE Status__c='Active'
   				LIMIT 10];      	
   }	
   
   
   @RemoteAction
   public static List<Task> getAllTasks(){
   	return [Select t.Who.FirstName, t.Who.LastName, t.Who.Id, t.WhoId, t.Who.Type, t.Status, t.Id, t.Description, t.ActivityDate From Task t Where t.ActivityDate > 2010-02-28 ];   	
   }
   
   @RemoteAction
   public static List<Task> getCurrentUserTasks(){
   	System.debug('userInfo :' + UserInfo.getUserId());
   	return [Select subject, Id, activitydate,reminderdatetime, whoId, whatId from Task where OwnerId =:UserInfo.getUserId()];   	
   }

}