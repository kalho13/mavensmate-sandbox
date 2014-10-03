public with sharing class ManageInspectionsController {
	
	List<Course_Detail__c> courses = new List<Course_Detail__c>(); 
    List<Course_Detail__c> courseList = new List<Course_Detail__c>();    
    Map<String, Course_Inspection__c> inspectionMap = new Map<String, Course_Inspection__c>();
    Set<ID> remainingCourses = new Set<ID>();
  
    public ApexPages.StandardSetController standardSetController {
        get {
            if(standardSetController == null) {
               standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([select Id,Name, Account__c, Model__c, Year_Built__c, Serial_Number__c, Status__c, Distributor__c, Selected__c from Course_Detail__c WHERE Status__c='Active']));
                standardSetController.setPageSize(20);   // sets the number of records in each page set
            }
            return standardSetController;
        }
        set;
    } 
    
    public List<Course_Detail__c> getCourses(){
      	List<Course_Detail__c> courses = standardSetController.getRecords(); 
 		//get a list of valid inspections
   	for(Course_Inspection__c inspection:[select Id, Course__r.Id, Inspection_Complete__c, Inspection_Status__c, Name from Course_Inspection__c WHERE Inspection_Status__c='Scheduled' or Inspection_Status__c='Pending'  ]){
	     	inspectionMap.put(inspection.Course__r.Id, inspection);
        }
		//loop through course and cannot find a related inspection then include this course for inspection creation
        for(Course_Detail__c course:(List<Course_Detail__c>)standardSetController.getRecords()){
		     if(!inspectionMap.containsKey(course.Id)){	remainingCourses.add(course.Id); }
       }
        
        //SOQL an abbreviated list of courses that need inspection records. 
        courseList = [select Id,Name, Account__c, Model__c, Year_Built__c, Serial_Number__c, Status__c, Distributor__c, Selected__c from Course_Detail__c WHERE Id = :remainingCourses];
         
    	return courseList;    	
    }   
  
    //create inspection records for selected courses.  This should not be the code that creates the new inspection record.  That should be a trigger when the previous record is completed
     public PageReference process() {
        List<Course_Inspection__c> inspectionList = new List<Course_Inspection__c>();
        for (Course_Detail__c cl: courseList) {
        
            if (cl.Selected__c){             	
               Course_Inspection__c inspection = new Course_Inspection__c();
              inspection.Course__c = cl.Id;
               inspection.Course_Description__c =   cl.Name + ' - ' + cl.Model__c + ' - ' + cl.Year_Built__c;
             //  inspection.Inspection_Year__c = String.valueOf(date.today().year());  //'is this something I want here?'
               inspection.Inspection_Status__c = 'Pending';
             //  inspection.Previous_Inspection_Date__c = Date.valueOf(getPreviousYearInspectionDate(cl.id));//'is this something I want here?'
               inspectionList.add(inspection);  //if the inspection has been checked then it is added to the addInspectionsList
            }//end if
           
        }//end for
        //now insert the inspectionList List
        try{
            insert inspectionList;                  
            }catch (DmlException e){
                 for (Integer i = 0; i < e.getNumDml(); i++) {ApexPages.addMessage(new ApexPages.message(APexPages.severity.INFO,e.getDmlMessage(i) ));}//end for
                } //end catch
                
                PageReference pageRef = new PageReference('/a0b?fcf=00Bd00000051m6s');  //what am I referencing here?
        return pageRef;
        
    }
    
  /*
     //compare the id of the course to the course ids in the inspection list from last year.  If I find last years inspection record I need to return the date of inspection
     //what if there are many inspections? What one am I getting?
    public String getPreviousYearInspectionDate(String id){    
    	if(inspectionMap.containsKey(id)){
    		Course_Inspection__c i = inspectionMap.get(id);
    		//need to check for a null value in the Inspection_Complete__c field
    		if(i.Inspection_Complete__c == null){return '1999-01-01';}else{	return String.valueOf(i.Inspection_Complete__c); }  		
    	}else{return '1999-01-01';}    	
    }
     */ 

    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {return standardSetController.getHasNext(); }
        set;
    }
    
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {return standardSetController.getHasPrevious();}
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {return standardSetController.getPageNumber();}
        set;
    }
    
    // returns the first page of records
    public void first() {
        standardSetController.first();
    }
 
    // returns the last page of records
    public void last() {
        standardSetController.last();
    }
 
    // returns the previous page of records
    public void previous() {
        standardSetController.previous();
    }
 
    // returns the next page of records
    public void next() {
        standardSetController.next();
    }
    
        // returns the PageReference of the original page, if known, or the home page.
    public void cancel() {
        standardSetController.cancel();
    }
    

}