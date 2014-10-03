trigger toolDetail on Assigned_Tool__c (before insert, before update) {

//	if (Utility.toolDetail){
		
	    for(Assigned_Tool__c tool : trigger.new){
		   	if (Utility.toolDetail){
		   		
		   		System.debug('^^^^^^^^^^^ ' + Utility.toolDetail + ' ^^^^^^^^^^^');
		       //before inserting the tool go and find the cost.  Cannot calculate this field which would be easier because I want it as a rollup field to the parent.
		        try{
		            Tool_Entry__c te = [SELECT Id, Cost__c From Tool_Entry__c where Id =: tool.Tool_Entry__c];
		   
		           	if(tool.Quantity__c <> null && tool.Quantity__c > 0){
						tool.Tool_Cost__c = te.Cost__c * tool.Quantity__c;
					}else{
						tool.Tool_Cost__c = te.Cost__c;
					}
		        }Catch(Exception e){    }		
			}
		}

}