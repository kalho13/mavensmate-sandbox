public with sharing class InspectionWrapper {
	
	public Boolean checked{ get; set; }
    public Course_Inspection__c inspection { get; set;}
    
     public InspectionWrapper(){
        inspection = new Course_Inspection__c();
        //course.describeObject();
        checked = false;
    }
    
    public InspectionWrapper(Course_Inspection__c i){
        inspection = i;
        checked = false;
    }
    
    
   
    //test cases
     public static testMethod void testMe() { 
    	InspectionWrapper iw = new InspectionWrapper();
    	System.assertEquals(iw.checked,false); 
    	InspectionWrapper iw2 = new InspectionWrapper(new Course_Inspection__c(name='Test1'));
    	//System.assertEquals(iw2.name,'Test1');
    	System.assertEquals(iw2.checked,false); 
    }
	

}