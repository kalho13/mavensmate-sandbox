public class CourseSelectController {
    public Course_Detail__c courseDetail{get;set;} //add
    List<CourseWrapper> courses {get;set;}  

    //this saves the records to the StandardController where they can be accessed to create a WrapperClass
    public ApexPages.StandardSetController standardSetController {
        get {
            if(standardSetController == null) {
                standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Account__c, Model__c, Name, Year_Built__c, Selected__c, Status__c from Course_Detail__c WHERE Status__c='Open']));
                // sets the number of records in each page set
                standardSetController.setPageSize(20);
            }
            return standardSetController;
        }
        set;
    }   
    
    // returns a list of wrapper objects for the sObjects in the current page set
    public List<CourseWrapper> getCourses() {       
        courses = new List<CourseWrapper>();
        for (Course_Detail__c course : (List<Course_Detail__c>)standardSetController.getRecords())
            courses.add(new CourseWrapper(course)); 
        return courses;
    }
    
    public PageReference process() {
        List<Course_Inspection__c> addInspections = new List<Course_Inspection__c>();
        for (CourseWrapper cw : courses) {
            if (cw.checked){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,cw.course.name));
                Course_Inspection__c inspection = new Course_Inspection__c();
                inspection.Course__c = cw.course.Id;
                inspection.Name = cw.course.Name;  //this is the course id?
                inspection.Course_Description__c =   cw.course.Name + ' - ' + cw.course.model__c + ' - ' + cw.course.Year_Built__c;
                //inspection.Inspection_Year__c = String.valueOf(date.today().year());
                inspection.Inspection_Status__c = 'Pending';
                addInspections.add(inspection);  //if the inspection has been checked then it is added to the addInspectionsList
            }//end if
        }//end for
        //now insert the addInspections List
        try{
            insert addInspections;                  
            }catch (DmlException e){
                 for (Integer i = 0; i < e.getNumDml(); i++) {
                    // Process exception here 
                    ApexPages.addMessage(new ApexPages.message(APexPages.severity.INFO,e.getDmlMessage(i) ));
                  }//end for
                } //end catch
        return null;
    }
    
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
    
    public static testMethod void testOne(){
        
        CourseSelectController c = new CourseSelectController();
        c.first();
        c.last();
        c.previous();
        c.next();
        c.cancel();
        c.getCourses();
        c.process();
        
        //SomeController controller = new SomeController (null);
    //PageReference ref = c.cancel();
   // System.assert(ref.getUrl() == '/apex/CourseWrapperList');
   // System.assert(ApexPages.getMessages().size() == 0); 
        
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Test Course Name'));
        //PageReference ref =new PageReference('/apex/CourseWrapperList');
        //Test.setCurrentPage(ref); 
        //system.AssertEquals(ApexPages.hasMessages(),true );
        System.assert(ApexPages.getMessages().size() == 1);
        System.assert(ApexPages.getMessages().get(0).getDetail() == 'Test Course Name');
        System.assert(ApexPages.getMessages().get(0).getSeverity() == ApexPages.Severity.INFO); 
        
        
        
        //Test.setCurrentPage(Page.CourseWrapperList);
        //String nextPage = c.process().getUrl();
 // System.assertEquals('/apex/CourseWrapperList', nextPage);
        
          
  
        
        /*
        Course_Inspection__c inspection = new Course_Inspection__c();
                inspection.Course__c = 'a1aQ0000000aE3p';
                inspection.Name = 'Test Course 1';  //this is the course id?
                inspection.Course_Description__c =  'Test Course 1 Description';
                inspection.Inspection_Year__c = date.today().year();
                inspection.Inspection_Status__c = 'Pending';
                
                insert inspection;
        */
        //  system.assertEquals(Page.SomeOtherPage.getURL(), testPRTC.changeThePageAction().getURL());
        
        /*
         static testmethod void testChangeThePageAction(){
  
    PageReferenceTestingController testPRTC = 
      new PageReferenceTestingController();
  
    system.assertEquals(Page.SomeOtherPage, 
                        testPRTC.changeThePageAction());
  }
        
        
        */
    //public PageReference process();
        
        //ApexPages.StandardSetController s = new StandardSetController();
        //s.setPageNumber(0);
        //Integer i = c.getPageNumber();
        
        //public List<CourseWrapper> getCourses() {     
    //  courses = new List<CourseWrapper>();
    //  for (Course_Detail__c course : (List<Course_Detail__c>)standardSetController.getRecords())
    ////        courses.add(new CourseWrapper(course)); 
    //  return courses;
    //}
        
        
        
        /*
        //this is not a valid test
        ApexPages.StandardSetController standardSetController;
        standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Account__c, Model__c, Name, Year_Built__c, Selected__c, Status__c from Course_Detail__c WHERE Status__c='Open']));
        standardSetController.setPageNumber(1);
         System.assertEquals(1, standardSetController.getPageNumber());
         */
         /*
         
         public static testmethod void testselected() {
        
        List<Course_Inspection__c> inspections = new List<Course_Inspection__c>();
        
        for(Integer i=0;i<10;i++) {
        Course_Inspection__c c = new Course_Inspection__c();
        c.Name='TEST' + i;
        c.Course__c = 
            inspections.add(new Course_Inspection__c(Name = 'TEST' + i));
        }
        
        insert accounts;
        
        ApexPages.StandardSetController con = new ApexPages.StandardSetController(accounts);
        con.setSelected(accounts);
        Extension ext = new Extension(con);
        
        Test.startTest();
        ext.save();
        Test.stopTest();
        
        System.assert(ext.success);
    }
    */
        
    }
 
}