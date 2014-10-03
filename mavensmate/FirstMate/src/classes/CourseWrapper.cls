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

}