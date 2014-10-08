public with sharing class v8MapController {
  
   public List<Course_Detail__c> courseList;
   public List<Course_Detail__c> getCourseList(){return courseList;}
  
  public v8MapController(){
    ApexPages.currentPage().getHeaders().put('content-disposition', 'attachemnt; filename=\"googleEarth.kml"');
    System.debug('content-disposition ' +   ApexPages.currentPage().getHeaders().get('content-disposition'));
    courseList =getOpenCourses();
  
  }
  
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
           WHERE Status__c='Active' and Account__r.Location__Latitude__s != null];        
           
   }   
}