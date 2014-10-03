public with sharing class InspectionSelectController {
    //1.  First I need a coursewrapper instead of an inspection wrapper
    //2.This all should be in a new class
    
    
    //List<Course_Inspection__c> inspections;// = new List<Course_Inspection__c>();
    List<Course_Detail__c> courses = new List<Course_Detail__c>();
    Map<String, Course_Detail__c> courseMap ;
    
    
//query a list of courses with the inspection year as not the current year
//this will be the list of inspections that needs to be created so will be the list of courses to display.


//this saves the records to the StandardController where they can be accessed to create a WrapperClass
    public ApexPages.StandardSetController standardSetController {
        get {
            if(standardSetController == null) {
               // standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Course__c, Name from Course_Inspection__c WHERE Inspection_Year__c=2012]));
                 standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Course__c, Name from Course_Inspection__c ]));
                // sets the number of records in each page set
                standardSetController.setPageSize(20);
            }
            return standardSetController;
        }
        set;
    }   
    
    List<InspectionWrapper> inspections {get;set;}  
    
    public List<InspectionWrapper> getInspections() {       
        inspections = new List<InspectionWrapper>();
        for (Course_Inspection__c inspection : (List<Course_Inspection__c>)standardSetController.getRecords())
            inspections.add(new InspectionWrapper(inspection)); 
            
            loadCourses();
            removeCourses();
        return inspections;
    }
    
    //create a course map of all of the courses
    //then iterate through the list of inspections returned and remove those related course objects
    //List<>
 
    private void loadCourses(){    	
         courseMap = new Map<String, Course_Detail__c>();   
        for(Course_Detail__c cd:[select Id, Account__c, Model__c, Name, Year_Built__c, Selected__c, Status__c from Course_Detail__c WHERE Status__c='Open'] ){
                courseMap.put(cd.Id,cd);        
                }
    }
   
    //lets slim down the list a ways and get rid of courses that already have inspections
    private void removeCourses(){
        
        //why do I need an inspection wrapper here?  I need a coursewrapper as that is what I am going to display with the checkbox
        //for(CourseWrapper cc:allCourses){
        //ApexPages.StandardSetController
        for (Course_Inspection__c inspection : (List<Course_Inspection__c>)standardSetController.getRecords()){
            //inspections.add(new InspectionWrapper(inspection)); 
        //for (InspectionWrapper i : inspections){
            if(courseMap.containsKey(inspection.Course__c)){
                courseMap.remove(inspection.Course__c);
            }
        }
    
    //Map<String,Account> mapAccounts = new Map<String,Account>();
    for(String key:courseMap.keySet()){  System.debug('courseMap Iteration ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ' + courseMap.get(key));}
    
//  for (courseMap.Entry<String, Course_Detail__c> entry : courseMap.entrySet()){
   //   System.Debug(entry.getKey() + '/' + entry.getValue());
    //}
    }


    /*
    Returns a list that contains all of the values in the map in arbitrary order. For example:

Map<String, String> colorCodes = 
   new Map<String, String>();

colorCodes.put('Red', 'FF0000');
colorCodes.put('Blue', '0000A0');

List<String> colors = new List<String>();
colors = colorCodes.values();
    
    
    */
    
    //now that I have the list of course and the list of inspections remove the course if the inspection is found
    
    /*
    Map<string, string> colorCodes = 
   new Map<String, String>();

colorCodes.put('Red', 'FF0000');
colorCodes.put('Blue', '0000A0');

Boolean contains = 
   colorCodes.containsKey('Blue');
System.assertEquals(contains, True);
    
    
    */
    
    /*
    
    Account myAcct = new Account();                        //Define a new account 
    
Map<Integer, Account> m = new Map<Integer, Account>(); // Define a new map 
    
m.put(1, myAcct);                  // Insert a new key-value pair in the map 
    
System.assert(!m.containsKey(3));  // Assert that the map contains a key 
    
Account a = m.get(1);               // Retrieve a value, given a particular key 
    
Set<Integer> s = m.keySet();
    
    
    */

}