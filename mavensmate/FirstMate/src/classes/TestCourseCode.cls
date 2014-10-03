@IsTest
private class TestCourseCode {
	
	//create accounts
	//create courses
	//create inspections
	
	//assert they are all related
	
	static testMethod void testSetup(){
		//create accounts
		//create courses
		//create inspections
		//static final Integer A = 10;
		//static Integer accts = 10;
		//static final Integer crs = 2;
		//static final Integer inp = 4;
		
	}
	
	static void createRecords(){
		 List<Account> accounts = new List<Account>();
		 List<Course_Detail__c> courses = new List<Course_Detail__c>();
		 List<Inspection__c> inspections = new List<Inspection__c>();
		 
		for(Integer a = 0; a<10; a++){
			accounts.add(new Account(Name='Customer ' + String.valueOf(a)));
		}
		insert accounts;
		
		
		for(Account a: accounts){	//for each account
			System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$ accountId ' + a.Id + ' Name: ' + a.Name);
			for(Integer c = 0; c < 2; c++){ //add 2 courses
				courses.add(new Course_Detail__c(Name='Course ' + String.valueOf(c), Account__c = a.Id));				
			}		
		}
		
		insert courses;
		
		for (Course_Detail__c c: courses){
			for(Integer i = 0; i<4; i++){
				//inspections.add(new Inspection__c(Name='Inspection ' + String.valueOf(i), Course_Detail__c = c.Id ));
			}
			
			
		}
		
		
	}
	
	static void createCourseRecords(){
		List<Course_Detail__c> courses = new List<Course_Detail__c>();
		
		for(Integer a = 0; a<2; a++){
			
		}
		for(Integer i=0; i<10; i++){
			//how to tie the accounts?
		}
		
	}
	
	
	
	static void createInspectionRecords(String id){
		
	}

}