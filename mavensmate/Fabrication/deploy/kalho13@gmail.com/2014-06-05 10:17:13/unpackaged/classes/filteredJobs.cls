public with sharing class filteredJobs {

    public filteredJobs(){}
    public Job__c job;
   // public Job_Part__c selectedParts;
    List<Job_Part__c> selectedParts = new List<Job_Part__c>();

    //public SafetyEquipmentController(){}
    //public Safety_Equipment__c assign;
    public String errorMessage {get;set;}
    //List<Safety_Equipment__c> safetyList = new List<Safety_Equipment__c>();
  

 public filteredJobs(ApexPages.StandardController stdController) {
        job = (Job__c)stdController.getRecord();
  }

	//private final sObject mysObject;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    //public filteredJobs(ApexPages.StandardController stdController) {
    //    this.mysObject = (sObject)stdController.getRecord();
   // }

   // public String getRecordName() {
   //     return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
   // }


  //    public MyFilter(){
  //  YourObjReference = new CustomObject__c();

  //}
  //public CustomObject__c YourObjReference{get;set;}
  //public List<CustomObject__c>  yourObjList{get;set;}
  //public void filterRecords(){
  //  yourObjList = new List<CustomObject__c>();
  //  yourObjList = [SELECT Name FROM ]CustomObject__c WHERE LookupField__c=:YourObjReference.LookupField__c];
  //}
}