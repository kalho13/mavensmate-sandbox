public with sharing class CertificationStatusController {
private final Account acct;	

	public CertificationStatusController(Account a){
		this.acct = a;
		
	}

	 public CertificationStatusController(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }    

    public List<Course_Detail__c> getCourses(){
    	 List<Course_Detail__c> courses = [Select Id, Name, Model__c, Account__c, Compliancy__c from Course_Detail__c Where Account__c = :acct.id];    	
    	return courses;
      }
  
    public List<Course_Inspection__c> getInspections(){
    	 List<Course_Inspection__c> inspections =     
    	[SELECT Id, Name, Inspection_Complete__c, Inspection_Expiration__c, Course__r.Model__c, Course__r.Compliancy__c, Course__r.Account__r.Name, Course__r.Id FROM Course_Inspection__c WHERE Archive__c=False and Course__c IN
    	(SELECT Id FROM Course_Detail__c WHERE Account__c = :acct.id	)];    	
    	return inspections;
    }
    
    
    public List<Certification__c> getCertifications(){    	
    		 List<Certification__c> certifications =     		
    		[SELECT Id, Name, Contact__r.Name, Contact__r.Id, Contact__r.Last_Training_Performed__c, Certification_Type__c, Certification_Date__c, Expiration_Date__c FROM Certification__c WHERE Contact__c IN
    			(SELECT Id   FROM Contact WHERE Account.Id = :acct.id	) and Expiration_Date__c >= TODAY  ORDER BY Expiration_Date__c desc];    		
    		return certifications;    	
    }
    
     public List<Opportunity> getOpportunities(){    	
    		 List<Opportunity> opportunities =     	
    		[SELECT Id, Sales_Order_Number_2__c, Trainer_1__c, Trainer_2__c, Trainer_3__c, Trainer_4__c, Trained_By_Old_Computed__c, Certificate_Training__c, Type_Of_Training__c, Type_Of_Work__c FROM Opportunity WHERE AccountId = :acct.id  AND Type_of_Work__c includes('Training') AND StageName='Closed Won' ORDER BY Certificate_Training__c desc];	
    	
    		return opportunities;    	
    }
}