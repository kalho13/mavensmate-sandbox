trigger updateCost on Tool_Entry__c (after update) {
	/*
	when the cost of a tool changes this trigger will go out and change the 
	cost of all copies of this tool that have been assigned to the different tool boxes
	*/
	 	if (Utility.updateCost){
		   		
		   		System.debug('^^^^^^^^^^^ ' + Utility.updateCost + ' ^^^^^^^^^^^');
			for(Tool_Entry__c tool : trigger.new){	
				Tool_Entry__c beforeUpdate = System.Trigger.oldMap.get(tool.Id);
				
				if(beforeUpdate.Cost__c <> tool.cost__c ){
					
					List<Assigned_Tool__c> assigned = [SELECT Tool_Cost__c, Quantity__c from Assigned_Tool__c WHERE Tool_Entry__c =: tool.Id];
					
					for(Assigned_Tool__c a : assigned){
						if(a.Quantity__c <> null && a.Quantity__c > 0){
							a.Tool_Cost__c = tool.Cost__c * a.Quantity__c;
						}else{
							a.Tool_Cost__c = tool.Cost__c;
						}				
					}
					try{
						update assigned;
					}catch(Exception e){
						
					}			
				}
				//check and see if the cost value has changed
				
			}
	
	 	}
}