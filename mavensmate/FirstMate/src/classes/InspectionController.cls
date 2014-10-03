global with sharing class InspectionController {
    
    //Use the userAgent value to determine if app is viewed from android or iPhone and returns corresponding script library. 
    public String phoneGapUrl{
            get{
                String userAgent = ApexPages.currentPage().getHeaders().get('User-Agent');
                if(userAgent.contains('android')){
                    return 'phonegap-1.2.0-android.js';
                }else{
                    return 'phonegap-1.2.0-ios.js';
                }               
            }
        }//end phoneGapUrl
        
        
    @RemoteAction
    global static List<Account> queryAccounts(){
        return[SELECT Name FROM Account WHERE Id IN (SELECT Account__c FROM Course__c)];
    }
        
  //  @RemoteAction
   //// global static List<Course__c> queryCustomers(String customerId) {
   //      return [SELECT Id, Name, Course_Type__c FROM Course__c  where Account__c =:customerId];
   // }
    
    
     @RemoteAction
    global static List<Course__c> queryCourses(String customerId) {
         return [SELECT Id, Course_Type__c FROM Course__c where Account__c =:customerId];
    }
    
    @RemoteAction
    global static List<Inspection__c> queryInspections(String courseId){
        return [SELECT Id, Name FROM Inspection__c WHERE Course__c =:courseId ];
    }
    
    /*
    
    @RemoteAction
    global static List<Time_Sheet__c>queryTimeSheets(String bookId){
        return[SELECT Id, Name, Hours_for_Time_Period__c, Time_Sheet_Start_Date__c, Time_Sheet_End_Date__c 
               FROM Time_Sheet__c 
               WHERE Time_Book__c = :bookId];
        
    }
    
    */
}