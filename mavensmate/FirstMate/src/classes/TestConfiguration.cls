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
	
	public static List<Opportunity> createOpportunities(String baseName, Integer count, List<Account> accounts, String stageName){
		List<Opportunity> opportunities= new List<Opportunity>();		
		for(Account a: accounts){			
			for(Integer c=0; c<count; c++){
				opportunities.add(new Opportunity(Name=baseName + String.valueOf(c), AccountId=a.Id, StageName=stageName, CloseDate=Date.today().addDays(10)));
			}
		}		
		return opportunities;
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

}