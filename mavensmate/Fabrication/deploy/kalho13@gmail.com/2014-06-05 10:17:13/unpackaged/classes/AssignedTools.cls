public with sharing class AssignedTools {
	private static Integer FIRST_BREAK = 30;
	private static Integer SUBSEQ_BREAKS = 40;
	
	private List<Assigned_Tool__c> toolLineItems;
	private final Tool_Box__c toolbox;
	public List<List<Assigned_Tool__c>> toolList = new List<List<Assigned_Tool__c>>();
	public List<Assigned_Tool__c> toolPage = new List<Assigned_Tool__c>();
	
	public AssignedTools(ApexPages.StandardController stdController) {
         toolbox = [SELECT Id, Name, Tool_Box_Value__c FROM Tool_Box__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
          prepareQuoteLinesforPrinting();
    } 
    
     public List<Assigned_Tool__c> getAssignedTools(){
    	return [SELECT Id, Name, Quantity__c, Serial_Number__c, Calculated_Tool_Cost__c, Tool_Box__r.Name, Tool_Entry__r.Name, Date_Assigned__c FROM Assigned_Tool__c  WHERE Tool_Box__c = :toolbox.Id ORDER BY Tool_Entry__r.Name];
    } 
    
    public List<List<Assigned_Tool__c>> getTools(){
    	return toolList;
    }
    
     public Tool_Box__c getToolBox() {
        return toolbox;
    }
    
    private void prepareQuoteLinesforPrinting(){
		Integer counter = 0;		
		boolean firstBreakFound = false;  //this is set to true after the tools have been added to the first page
		boolean setSubSeqBreak = false;
		Integer breakPoint = FIRST_BREAK;		
		toolLineItems = getAssignedTools();
		
		
		for(Assigned_Tool__c tool: toolLineItems){  //see if we can skip the intermediate variable
			if(counter<=breakPoint){ //continue if the breakpoint number for a page has not been reached.  This is reset as we transition from page to page
				toolPage.add(tool);
				counter++; //increment the counter				
			}
			
			if(counter==breakPoint){//have reached a page breakpoint
				if(!firstBreakFound){//this means this is the first page
					firstBreakFound=true;
					setSubSeqBreak = true;						
				}
				
				counter = 0;  //set back to 0 for the first tool on the page				
				toolList.add(toolPage.deepClone());	//add completed page to toolList of many pages		
				toolPage.clear();
			}
			
			if(setSubSeqBreak){
				breakPoint=SUBSEQ_BREAKS; //change the number of tools on a page for pages after the first
				setSubSeqBreak = false;  //only need to change the number of tools on the page once				
			}			
		}
		
		if(!toolPage.isEmpty()){  //if taoolPage is not empty that means there is a partial page of tools that also need to be displayed (as the last page)
			toolList.add(toolPage.deepClone());			
		}
		
    }

}