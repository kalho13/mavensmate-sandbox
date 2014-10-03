public with sharing class ToolboxContents {
	
	//this is starting on the page of the toolbox, not the contents
	private final Tool_Box__c toolbox;
	/*
	public ToolboxContents(ApexPages.StandardController stdController) {
        this.toolbox = (Tool_Box__c)stdController.getRecord();
    }  
	*/
	//public ToolboxContents(){}
	/*
	 public ApexPages.StandardSetController standardSetController {
        get {
            if(standardSetController == null) {
                standardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name, Tool_Box_Value__c FROM Tool_Box__c  WHERE Id = :ApexPages.currentPage().getParameters().get('id')]));
                // sets the number of records in each page set
            }
            return standardSetController;
        }
        set;
    }   
	*/

    public ToolboxContents() {
        toolbox = [SELECT Id, Name, Tool_Box_Value__c FROM Tool_Box__c 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
  
    public Tool_Box__c getToolBox() {
        return toolbox;
    }
    
    public List<Assigned_Tool__c> getAssignedTools(){
    	return [SELECT Id, Name, Quantity__c, Serial_Number__c, Calculated_Tool_Cost__c, Tool_Box__r.Name, Tool_Entry__r.Name, Date_Assigned__c FROM Assigned_Tool__c  WHERE Tool_Box__c = :toolbox.Id ORDER BY Tool_Entry__r.Name];
    }  

}