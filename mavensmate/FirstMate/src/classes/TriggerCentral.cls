public class TriggerCentral implements TriggerInterface{
	
	public static TriggerCentral activefunction = null;
	
	public void inProgressEntry(
		String TriggerObject,
		Boolean IsBefore,
		Boolean IsDelete,
		Boolean IsAfter,
		Boolean IsInsert,
		Boolean IsUpdate,
		Boolean IsExecuting,
		List<SObject> newList,
		Map<ID, SObject> newMap,
		List<SObject> oldList,
		Map<ID, SObject> oldMap	
	){
	//code here
	
	}
	
	
	public void MainEntry(
		String TriggerObject,
		Boolean IsBefore,
		Boolean IsDelete,
		Boolean IsAfter,
		Boolean IsInsert,
		Boolean IsUpdate,
		Boolean IsExecuting,
		List<SObject> newList,
		Map<ID, SObject> newMap,
		List<SObject> oldList,
		Map<ID, SObject> oldMap	
	){
	
	//code here
	
	}
	
	public static Map<ID, Opportunity> oppMap = new Map<ID, Opportunity>();
	
	//automatically creates a course record when the opportunity is set to Closed Won?
	//what if one has already been created?
	//what if multiple course records need to be added for the opportunity?
	
	public static void createCourseRecord(List<Opportunity> newList, Map<ID, Opportunity> newMap,List<Opportunity> oldList,	Map<ID, Opportunity> oldMap){
		
		//Map<ID, Course_Detail__c> courses = new Map<ID, Course_Detail__c>();
		List<Course_Detail__c> courseList = new List<Course_Detail__c>();
	
		
		//how would multiples occur?  An import or some other bulk addition?	
		for (Opportunity i: newList) {	
			
			if(i.StageName == 'Closed Won'){
				courseList.add(new Course_Detail__c(Name='Course ' + i.OrderNumber__c , Account__c = i.AccountId ));
				
				
			}
			
			System.debug('********************************** ' + i.StageName);
			System.debug('********************************** ' + i.AccountId);
			
		}
		
		insert courseList;
		
	}//end createCourseRecord

}