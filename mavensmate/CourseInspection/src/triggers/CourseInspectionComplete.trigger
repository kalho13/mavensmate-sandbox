trigger CourseInspectionComplete on Course_Inspection__c (after insert, after update) {

	if(trigger.isInsert){
		for(Course_Inspection__c inspection : trigger.new){ 
		    if(inspection.Status__c == 'Complete' & inspection.Inspection_Complete__c !=null){
		    	date completeDate = inspection.Inspection_Complete__c;
		    	Course_Inspection__c newInspection = new Course_Inspection__c();		    	
		    	newInspection.Status__c = 'Next Annual';
				newInspection.Date_of_Expiration__c = completeDate.addYears(1); //is a calculated field?  No should not be
		    	newInspection.Course__c = inspection.Course__c;
		    	newInspection.Date_of_Last_Inspection__c = completeDate;
		    	Integer year =  inspection.Inspection_Complete__c.year() + 1; 
		    	newInspection.Name =  String.valueOf(year) + ' Inspection'; 
		    	insert newInspection;		   
		    }
		}
	}else{
		for(Course_Inspection__c inspection : trigger.new){  
		    Course_Inspection__c oldRecord = System.Trigger.oldMap.get(inspection.Id);
		    Course_Inspection__c updatedRecord = System.Trigger.newMap.get(inspection.Id);		
		    if(oldRecord.Status__c != 'Complete' & updatedRecord.Status__c == 'Complete'){
		    	date completeDate = updatedRecord.Inspection_Complete__c;
		    	Course_Inspection__c newInspection = new Course_Inspection__c();
		    	newInspection.Course__c = updatedRecord.Course__c;		    	
		     	newInspection.Status__c = 'Next Annual';
		     	newInspection.Date_of_Last_Inspection__c = completeDate;
		     	newInspection.Date_of_Expiration__c = completeDate.addYears(1); //is a calculated field?  No should not be
		     	Integer year =  inspection.Inspection_Complete__c.year() + 1; 
		    	newInspection.Name =  String.valueOf(year) + ' Inspection'; 
		    	insert newInspection;
		    }
		}
	}

}