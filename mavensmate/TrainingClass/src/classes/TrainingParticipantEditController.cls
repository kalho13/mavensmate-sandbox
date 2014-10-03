public with sharing class TrainingParticipantEditController {

	private Apexpages.StandardController sController;
    private Training_Participants__c trainingParticipants;
    private String queryString;
    public String trainingRole{get;set;}
  
    public TrainingParticipantEditController(ApexPages.StandardController controller) {
        sController = controller;
        this.trainingParticipants = (Training_Participants__c)sController.getRecord();
        //trainingRole = trainingParticipants.Training_Role__c;
         if(trainingParticipants.Training_Role__c==null){  //we have a new record
           trainingRole = 'Trainee';  // this is the default radio button selection
        }else{
           trainingRole = trainingParticipants.Training_Role__c; //get the existing role value
      }
        List<String> pageUrl = ApexPages.currentPage().getUrl().split('\\?');
        queryString = pageUrl[1]; 
  }

    public List<SelectOption> getRole(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Instructor', 'Instructor'));
        options.add(new SelectOption('Trainer', 'Trainer'));
        options.add(new SelectOption('Trainee', 'Trainee'));
        return options;
    }

    public Pagereference doSaveAndNew(){
       
        trainingParticipants.Training_Role__c = trainingRole;
        if(trainingRole=='Trainee'){
            trainingParticipants.Trainer__c =null;
        }else{
             trainingParticipants.Participant__c='';   
        }

      try{        
        upsert trainingParticipants;
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

    public PageReference doSave(){
        trainingParticipants.Training_Role__c = trainingRole;
        //based on the role value make sure the other field for contact is empty
        if(trainingRole=='Trainee'){
            trainingParticipants.Trainer__c =null;
        }else{
             trainingParticipants.Participant__c='';   
        }

        upsert trainingParticipants;

        //return new PageReference('/' + trainingParticipants.Training_Class__r.ID);
        return new PageReference('/'+trainingParticipants.Training_Class__c);

    }

    public PageReference doCancel(){
        return sController.cancel();
    }
}