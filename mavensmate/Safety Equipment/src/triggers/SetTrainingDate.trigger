trigger SetTrainingDate on Opportunity (after update) {
    
    //update the selected contact with the training date of the class he/she provided
   if (Utility.setTrainingDate = true){
	    for(Opportunity opp : trigger.new){ 
	        Opportunity beforeUpdate = System.Trigger.oldMap.get(opp.Id);   
	        Date xdate = opp.Certificate_Training__c;   
	        Date zdate = beforeUpdate.Certificate_Training__c;
	       
	        if(String.valueOf(zdate)  <> String.valueOf(xdate)){   
	            
	            try{                        
	                Contact c = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_1__c];
	                c.Last_Training_Performed__c = xdate;
	                update c;
	                
	            }catch (System.DmlException e) {
	                	for (Integer i = 0; i < e.getNumDml(); i++) {
	        			// Process exception here
	        			System.debug(e.getDmlMessage(i)); 
	    				}
				}
	
	            try{
	                Contact c2 = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_2__c];
	                c2.Last_Training_Performed__c = xdate;
	                update c2;
	             }catch (System.DmlException e) {
	                	for (Integer i = 0; i < e.getNumDml(); i++) {
	        			// Process exception here
	        			System.debug(e.getDmlMessage(i)); 
	    				}
				}
	    
	            try{        
	                Contact c3 = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_3__c];
	                c3.Last_Training_Performed__c = xdate;
	                update c3;
	           }catch (System.DmlException e) {
	    				for (Integer i = 0; i < e.getNumDml(); i++) {
	        			// Process exception here
	        			System.debug(e.getDmlMessage(i)); 
	    				}
				}
	
	            try{
	                Contact c4 = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_4__c];
	                c4.Last_Training_Performed__c = xdate;
	                update c4;
	            }catch (System.DmlException e) {
	    				for (Integer i = 0; i < e.getNumDml(); i++) {
	        			// Process exception here
	        			System.debug(e.getDmlMessage(i)); 
	    				}
				}
	        
	        }//end if date change
	    }//end for
    
 	}//end utility boolean

}//end trigger