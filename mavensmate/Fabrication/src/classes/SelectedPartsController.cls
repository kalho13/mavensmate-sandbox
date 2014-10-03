public with sharing class SelectedPartsController {
    /*
        k.howell 5/14/2014
        Returns child parts to the job based on checkboxes selected.  Can look at the Fabrication, Paint and Shipping records independently.
    */
      /*
        Testing requires inserting a job and parts, then querying the parts
    */

	public Job__c job;
    List<Job_Part__c> selectedParts = new List<Job_Part__c>();
    public String errorMessage {get;set;}
    public Boolean checkFabrication{get; set; }
    public Boolean checkPaint{get; set; }
    public Boolean checkShipping{get; set; }
    public Boolean checkRemainingItems{get;set;}
    public String soql;
    public String jobId;
 

    //this controller is used to pass in the job information for the testing code
    public SelectedPartsController(Job__c j){
        this.job = j;
        jobId = j.Id;
    }


    public SelectedPartsController(ApexPages.StandardController stdController) {
        this.job = (Job__c)stdController.getRecord();
        jobId = job.Id;
    }  

    public List<Job_Part__c> getSelectedParts(){
        soql='';
        soql = 'SELECT ID,Name,Quantity__c,Rollup_Paint_Complete__c,Paint_Remaining__c,Quantity_To_Be_Loaded__c,Rollup_Loaded_Items__c,Fabrication_Quantity_Complete__c,'
            +'Weight_Single_Part__c,Fabrication_Quantity_Remaining__c, Description__c,Fabrication__c,Paint__c,Shipping__c FROM Job_Part__c WHERE Job_Part__c.Job__r.Id =:jobId';

        if(checkRemainingItems==true){
            if(checkFabrication==true){soql += ' AND Fabrication__c = true AND Fabrication_Quantity_Remaining__c > 0'; }
            if(checkShipping==true){soql += ' AND Shipping__c = true AND Job_Part__c.Paint_Remaining__c > 0'; }
            if(checkPaint==true){soql += ' AND Paint__c = true AND Job_Part__c.Quantity_To_Be_Loaded__c > 0' ;}
        }else{
            if(checkFabrication==true){soql += ' AND Fabrication__c = true';}
            if(checkShipping==true){soql += ' AND Shipping__c = true';}
            if(checkPaint==true){soql += ' AND Paint__c = true';}
        }             
        soql += ' ORDER BY Name ASC';
        selectedParts = Database.query(soql);
        return selectedParts;
    }


    /*

    pass in the id of the parent record.  This is in the url when the parent record is displayed

    */

    public pageReference doNew(){
        Job_Part__c part = new Job_Part__c();
        part.Job__c = job.id;
        part.Name = 'New Part Name Here';
        insert part;
        //create a new parts object
        //add the job id and name
        //open the record in the edit mode
        PageReference pr = new PageReference('/'+part.id);
        //pr.setRedirect(true);
        return pr;

    }

   
/*
 public Pagereference doSaveAndNew(){
      try{
        //save the current object
        sController.save();
        //Get the Meta Data for Training_Participants__c
        Schema.DescribeSObjectResult describeResult = sController.getRecord().getSObjectType().getDescribe();
        //Create pageReference for creating a new sObject and add any inbound query string parameters
        PageReference pr = new PageReference('/'+describeResult.getKeyPrefix()+'/e?' + queryString);
        //Don't redirect with the viewstate of the current record
        pr.setRedirect(true);
        return pr;
      } catch(Exception e){
        ApexPages.addMessages(e);
        return null;
      }
    }

public void newContact()
    {
       if (updateContacts())
       {
          Contact cont=new Contact(FirstName=newContactFirstName, LastName=newContactLastName, AccountId=getAccount().id);
          insert cont;
         
          newContactFirstName=null;
          newContactLastName=null;
          contacts=null;
       }
    }

    */
}