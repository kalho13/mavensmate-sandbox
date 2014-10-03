@isTest
public with sharing class TestConfiguration {
	
	public static List<Account> createAccounts(String baseName, Integer count){		
		List<Account> results = new List<Account>();		
		for(Integer a = 0; a<count; a++){
			results.add(new Account(Name = baseName + String.valueOf(a)));
		}
		return results;
	}
	
	public static List<Contact> createContacts(String baseName, Integer count, List<Account> accounts){
		List<Contact> contacts= new List<Contact>();		
		for(Account a: accounts){			
			for(Integer c=0; c<count; c++){
				contacts.add(new Contact(LastName=baseName + String.valueOf(c), AccountId=a.Id));
			}
		}		
		return contacts;
	}
	
	public static List<Certification__c> createCertifications(String baseName, Integer count, List<Contact> contacts, Date certificationDate){
		List<Certification__c> certifications = new List<Certification__c>();
		for(Contact c: contacts){
			for(Integer i = 0; i<count; i++){
				certifications.add(new Certification__c(Contact__c=c.Id, Certification_Date__c=certificationDate));
			}
		}
		return certifications;
	}
	
	public static List<Opportunity> createOpportunities(String baseName, Integer count, List<Account> accounts, String stageName){
		List<Opportunity> opportunities= new List<Opportunity>();		
		for(Account a: accounts){			
			for(Integer c=0; c<count; c++){
				opportunities.add(new Opportunity(Name=baseName + String.valueOf(c), AccountId=a.Id, StageName=stageName, CloseDate=Date.today().addDays(10)));
			}
		}		
		return opportunities;
	}
	
	
	//Loop through Accounts
	//Loop through Opportunities
	//Loop through Contacts
	//Create OpportunityContactRole for each contact for the opportunity
	public static List<OpportunityContactRole> createOpportunityContactRoles(String baseName, Integer count, List<Account> accounts, List<Opportunity> opportunities, List<Contact> contacts){
		List<OpportunityContactRole> opportunityContactRoles= new List<OpportunityContactRole>();
		
		for(Account a: accounts){		
			for(Opportunity o: opportunities){
				for(Contact c: contacts){				
							opportunityContactRoles.add(new OpportunityContactRole(Role=baseName, ContactId=c.Id, OpportunityId = o.Id));
				}
			}
		}		
		return opportunityContactRoles;
	}
	
	public static List<Course_Detail__c> createCourses(String baseName, Integer count, List<Account> accounts){
		List<Course_Detail__c> courses = new List<Course_Detail__c>();
		for(Account account: accounts){
			for(Integer c=0; c<count; c++){
				courses.add(new Course_Detail__c(Name=baseName + String.valueOf(c),Account__c=account.Id ));
			}
		}		
		return courses;
	}
	
	public static List<Course_Inspection__c> createInspections(String baseName, Integer count, List<Course_Detail__c> courses){
		List<Course_Inspection__c> inspections = new List<Course_Inspection__c>();		
		for(Course_Detail__c course: courses){
				for(Integer c=0; c<count; c++){
					inspections.add(new Course_Inspection__c(Name=baseName + String.valueOf(c), Course__c = course.Id));  
				}			
			}
		return inspections;
	}

	public static List<Safety_Equipment__c> createSafetyEquipmentInventory(Integer startSerialNumber, String status, String model,Integer count){
		List<Safety_Equipment__c> safetyEquipment = new List<Safety_Equipment__c>();

		for(Integer s = 0; s<count; s++){
			safetyEquipment.add(new Safety_Equipment__c(Serial_Number__c = startSerialNumber+s, Model__c = model, Status__c = status));
		}

		return safetyEquipment;
	}

	public static List<Safety_Equipment__c> assignSafetyEquipment(Integer startSerialNumber, Integer count, List<Account> accounts){
		List<Safety_Equipment__c> safety = new List<Safety_Equipment__c>();		
		for(Account a: accounts){			
			for(Integer c=0; c<count; c++){
				safety.add(new Safety_Equipment__c(Start_Serial_Number__c = startSerialNumber+c, Account__c=a.Id));
			}
		}		
		return safety;
	}

}