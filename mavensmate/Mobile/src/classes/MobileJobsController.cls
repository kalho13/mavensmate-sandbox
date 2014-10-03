public with sharing class MobileJobsController {

	private string jobs;
	private string parts;

	public MobileJobsController() {
		List<Job__c> jobList = [SELECT Id, Name, Status__c FROM Job__c WHERE Status__c='Open'];	
		List<Job_Part__c> partList = [SELECT Id, Name FROM Job_Part__C WHERE Job__r.Name = '2249'];

		 jobs = JSON.serialize(jobList);
		 //parts = JSON.serialize(partList);
        system.debug('Jobs as JSON: ' + jobs);	
	}

public string getParts(){
		return parts;
	}

	public string getJobs(){
		return jobs;
	}
}