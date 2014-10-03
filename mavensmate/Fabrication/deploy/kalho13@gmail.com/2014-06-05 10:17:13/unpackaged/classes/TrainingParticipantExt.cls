public with sharing class TrainingParticipantExt {

    private Apexpages.StandardController sController;
    private Training_Participants__c trainingParticipants;
    //private Training_Participants__c editTrainingParticipant;
    private String queryString;
    public String trainingRole{get;set;}

 
    public TrainingParticipantExt(ApexPages.StandardController controller) {
        sController = controller;
        this.trainingParticipants = (Training_Participants__c)sController.getRecord();
        List<String> pageUrl = ApexPages.currentPage().getUrl().split('\\?');
        queryString = pageUrl[1]; 
        trainingRole = 'Trainee';  // this is the default radio button selection
    }

    public List<SelectOption> getRole(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Instructor', 'Instructor'));
        options.add(new SelectOption('Trainer', 'Trainer'));
        options.add(new SelectOption('Trainee', 'Trainee'));
        return options;
    }

    public Pagereference doSaveAndNew(){
      try{
        trainingParticipants.Training_Role__c = trainingRole;
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
         if(trainingRole=='Trainee'){
            trainingParticipants.Trainer__c =null;
        }else{
             trainingParticipants.Participant__c='';   
        }
        upsert trainingParticipants;
        return new PageReference('/'+trainingParticipants.Training_Class__c);

    }

    public PageReference doCancel(){
        return sController.cancel();
    }

}