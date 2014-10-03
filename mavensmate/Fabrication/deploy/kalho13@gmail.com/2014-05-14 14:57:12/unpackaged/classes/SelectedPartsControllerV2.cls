public with sharing class SelectedPartsControllerV2 {

	 /*
        k.howell 5/14/2014
        Returns child parts to the job based on checkboxes selected.  Can look at the Fabrication, Paint and Shipping records independently.
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


    public SelectedPartsControllerV2(ApexPages.StandardController stdController) {
        this.job = (Job__c)stdController.getRecord();
        jobId = job.Id;
    }  

    public List<Job_Part__c> getSelectedParts(){
        soql='';
        soql = 'SELECT ID,Name,Quantity__c,Rollup_Paint_Complete__c,Paint_Remaining__c,Quantity_To_Be_Loaded__c,Rollup_Loaded_Items__c,Fabrication_Quantity_Complete__c,'
            +'Weight_Single_Part__c,Fabrication_Quantity_Remaining__c, Description__c,Fabrication__c,Paint__c,Shipping__c FROM Job_Part__c WHERE Job_Part__c.Job__r.Id =:jobId';

        if(checkRemainingItems==true){

             if(checkFabrication==true){
                    soql += ' AND Fabrication__c = true AND Fabrication_Quantity_Remaining__c > 0';
                 }

                 if(checkShipping==true){
                   soql += ' AND Shipping__c = true AND Job_Part__c.Paint_Remaining__c > 0';               
                }
                 if(checkPaint==true){
                   soql += ' AND Paint__c = true AND Job_Part__c.Quantity_To_Be_Loaded__c > 0' ;               
                }

            }else{
                 
                if(checkFabrication==true){
                    soql += ' AND Fabrication__c = true';
                 }

                 if(checkShipping==true){
                   soql += ' AND Shipping__c = true';               
                }
                 if(checkPaint==true){
                   soql += ' AND Paint__c = true';               
                }
            }             
  
        selectedParts = Database.query(soql);
        return selectedParts;
    }
}