public with sharing class TrainingParticipantExt {

    private Apexpages.StandardController sController;
    private Training_Participants__c trainingParticipants;
    private String queryString;
    public String participant {get;set;}

    public TrainingParticipantExt(ApexPages.StandardController controller) {
        sController = controller;
        trainingParticipants = (Training_Participants__c)sController.getRecord();

        List<String> pageUrl = ApexPages.currentPage().getUrl().split('\\?');
        queryString = pageUrl[1];   
        participant='Trainee';
    }


    //String[] roles = new String();
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Instructor', 'Instructor'));
        options.add(new SelectOption('Trainer', 'Trainer'));
        options.add(new SelectOption('Trainee', 'Trainee'));
        return options;
    }

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

    public PageReference doCancel(){
        return sController.cancel();
    }

}