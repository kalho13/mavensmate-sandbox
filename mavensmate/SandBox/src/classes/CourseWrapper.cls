public with sharing class CourseWrapper {
	
	public Boolean checked{ get; set; }
    public Course_Detail__c course { get; set;}
    
     public CourseWrapper(){
        course = new Course_Detail__c();
        //course.describeObject();
        checked = false;
    }
    
    public CourseWrapper(Course_Detail__c c){
        course = c;
        checked = false;
    }
    
    
   /*
    //test cases
     public static testMethod void testMe() { 
    	CourseWrapper cw = new CourseWrapper();
    	System.assertEquals(cw.checked,false); 
    	CourseWrapper cw2 = new CourseWrapper(new Course_Detail__c(name='Test1'));
    	System.assertEquals(cw2.course.name,'Test1');
    	System.assertEquals(cw2.checked,false); 
    }
*/

}