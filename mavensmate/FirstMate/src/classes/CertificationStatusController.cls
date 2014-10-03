public class CertificationStatusController {
	
	private final Account acct;
	
	 public CertificationStatusController(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }
    

    public List<Course_Detail__c> getCourses(){
    	 List<Course_Detail__c> courses = [Select Id, Name, Model__c, Account__c from Course_Detail__c Where Account__c = :acct.id];    	
    	return courses;
      }
  
    public List<Course_Inspection__c> getInspections(){
    	 List<Course_Inspection__c> inspections =     
    	[SELECT Id, Name, Inspection_Complete__c, Course__r.Model__c, Course__r.Account__r.Name FROM Course_Inspection__c WHERE Course__c IN
    	(SELECT Id FROM Course_Detail__c WHERE Account__c = :acct.id	)];    	
    	return inspections;
    }
    
    public List<Certification__c> getCertifications(){
    		 List<Certification__c> certifications =     		
    		[SELECT Id, Name, Contact__r.Name, Expiration_Date__c FROM Certification__c WHERE Contact__c IN
    			(SELECT Id FROM Contact WHERE Account.Id = :acct.id	) and Expiration_Date__c >= TODAY];    		
    		return certifications;    	
    }
   
}