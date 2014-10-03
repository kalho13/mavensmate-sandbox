trigger CourseInspectionComplete on Course_Inspection__c (after insert, after update) {

	if(trigger.isInsert){
		for(Course_Inspection__c inspection : trigger.new){ 
		    if(inspection.Status__c == 'Complete' & inspection.Inspection_Complete__c !=null){
		    	Course_Inspection__c newInspection = new Course_Inspection__c();		    	
		    	newInspection.Status__c = 'Next Annual';
		    	newInspection.Date_of_Next_Inspection__c = newInspection.Date_of_Next_Inspection__c = inspection.Inspection_Complete__c + 365;
		    	newInspection.Course__c = inspection.Course__c;
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
		    	Course_Inspection__c newInspection = new Course_Inspection__c();
		    	newInspection.Course__c = updatedRecord.Course__c;
		    	newInspection.Date_of_Last_Inspection__c = updatedRecord.Inspection_Complete__c;
		    	newInspection.Date_of_Next_Inspection__c = newInspection.Date_of_Next_Inspection__c = updatedRecord.Inspection_Complete__c + 365;
		     	newInspection.Status__c = 'Next Annual';
		     	Integer year =  inspection.Inspection_Complete__c.year() + 1; 
		    	newInspection.Name =  String.valueOf(year) + ' Inspection'; 
		    	insert newInspection;
		    }
		}
	}

}