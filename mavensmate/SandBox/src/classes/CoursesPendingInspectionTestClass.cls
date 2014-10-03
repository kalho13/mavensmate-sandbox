@isTest
private class CoursesPendingInspectionTestClass {
	
	 //successful tests
	 static testMethod void validCoursesPendingInspection(){
    	CourseWrapper cw = new CourseWrapper();
    	System.assertEquals(cw.checked,false); 
    	
    	CourseWrapper cw2 = new CourseWrapper(new Course_Detail__c(name='Test1'));
    	System.assertEquals(cw2.course.name,'Test1');
    	System.assertEquals(cw2.checked,false); 
    	
    	/*
    	CoursesPendingInspectionController c = new CoursesPendingInspectionController();    	
    	c.first();
    	 c.last();
        c.previous();
        c.next();
        c.cancel();
        c.getInspections();
        c.filterCourses();
         c.getCourses();
        c.process();    
        String x =  c.getPreviousYearInspectionDate('a1aQ0000000aFX4');  
        System.assertEquals(x, '1999-01-01');
      */  
       // PageReference testPage = Page.CourseWrapperList;
       // Test.setCurrentPage(testPage);
       // String  returnPage = c.process().getURL();
       // System.assertEquals('/a1c?fcf=00B30000008bldn', returnPage);
        
        
        //create inspection
        //add to key
        //get from key
        //adds nothign so far
        Account a = new Account(Name='Test Account');
        insert a;
        
        Course_Detail__c cd = new Course_Detail__c(Name='ABC', Account__c=a.id);
        insert cd;
        
         Map<String, Course_Inspection__c> inspectionMap = new Map<String, Course_Inspection__c>();
        Course_Inspection__c ci = new Course_Inspection__c(Course_Description__c='Inspect1', Course__c=cd.Id);
        insert ci;
        Course_Inspection__c ci2 = [Select id, Course_Description__c FROM Course_Inspection__c WHERE id=:ci.Id];
        System.assertEquals(ci2.Course_Description__c, 'Inspect1');
        
        // Map<String, Course_Inspection__c> inspectionMap = new Map<String, Course_Inspection__c>();
      //  inspectionMap.put(ci.id, ci);
      //  Course_Inspection__c ci3 = inspectionMap.get(ci.id);
       //// System.assertEquals(String.valueOf(ci3.Inspection_Complete__c), null);
       // System.assertEquals(inspectionMap.size(), 1);
      //  System.assert(!inspectionMap.containsKey('ABC'));
       // System.assertEquals(inspectionMap.containsKey(ci.id), ci.id);
        
       // Course_Inspection__c cx = (Course_Inspection__c)inspectionMap.get(ci.id);
       // assetEquals(cx.Course_Description__c, 'Inspect1');
       
      // if(inspectionMap.containsKey(id)){
    	//	Course_Inspection__c i = inspectionMap.get(id);
    	
	 }

}