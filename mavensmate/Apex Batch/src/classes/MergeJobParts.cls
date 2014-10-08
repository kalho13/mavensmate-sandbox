global class MergeJobParts implements Database.Batchable<sObject> {
	
	String query;
	String job;

	
	//USE THE CONSTRUCTOR TO LOOK UP GLOBAL INSTANCE VARIABLE TO CONTROL WHICH JOBS THIS RUNS AGAINST
	global MergeJobParts() {

	}

	global MergeJobParts( String jobNumber) {
		job = jobNumber;
	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Name, Id, Quantity__c FROM Job_Part__c WHERE Job__r.Name = \'' + job + '\'';
        return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Job_Part__c> scope) {
   		scope.sort();
         for(Integer i = 0; i < scope.size()-1;i++ ){
            
         	if(scope[i].Name == scope[i+1].Name){
         		
         		scope[i].Quantity__c = scope[i].Quantity__c + scope[i+1].Quantity__c;

         		//fabrication child records to merge
         		List<Job_Fabrication_Detail__c> details = [SELECT Id, Name, Work_Entry_Quantity__c, Job_Part__c from Job_Fabrication_Detail__c where Job_Part__c =: scope[i+1].Id];
         		if(details.size()>0){

	         		for(Integer a = 0; a<details.size(); a++){
	         			details[a].Job_Part__c = scope[i].Id;
	         		}
	         		update details;
         		}

         		//shipping child records to merge
         		List<Job_Shipping_Details__c> shipping = [SELECT Id, Name, Number_Loaded__c, Job_Part__c from Job_Shipping_Details__c where Job_Part__c =: scope[i+1].Id];
         		if(shipping.size()>0){
         			for(Integer b = 0; b<details.size(); b++){
	         			shipping[b].Job_Part__c = scope[i].Id;
	         		}
	         		update shipping;
         		}

         		Database.delete(scope[i+1]);
         		DataBase.emptyRecycleBin(scope[i+1]); 
         		scope.remove(i+1);
         	}
         }      
         update scope;
	}
	
	global void finish(Database.BatchableContext BC) {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 
		mail.setToAddresses(new String[] {'kal@ropescoursesinc.com'});
		mail.setReplyTo('kal@ropescoursesinc.com');
		mail.setSenderDisplayName('Batch Processing');
		mail.setSubject('Batch Process Completed');
		mail.setPlainTextBody('Batch Process has completed');
 
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		
	}
}
