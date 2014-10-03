public with sharing class CourseController {
	
	private Course__c course;
	private Boolean bUpdate = true;
	private ApexPages.StandardController extendedController {get;set;}

	public CourseController(ApexPages.StandardController stdController){			
		  extendedController = stdController;
          this.course= (Course__c)extendedController.getRecord();
          if(course.id==null){bUpdate=false;}	
	}
		
	public Course__c getCourse() { return course;} 

	public PageReference mySave() {	
		PageReference displayCourse = Page.displayCourse;
		displayCourse.setRedirect(true);
		displayCourse.getParameters().put('id', course.id);	
		
		if(bUpdate){
			update course;
			return displayCourse;
		}else{
			insert course;
			extendedController = new ApexPages.StandardController(course);
		}
		return displayCourse;
	}
	
	public PageReference edit(){
		PageReference editCourse = Page.Course;
		editCourse.setRedirect(true);
		editCourse.getParameters().put('id', course.id);				
	    return editCourse;
	}
}