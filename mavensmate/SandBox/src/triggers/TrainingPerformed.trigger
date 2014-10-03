trigger TrainingPerformed on Opportunity (after update) {
	
	for(Opportunity opp : trigger.new){	
		Opportunity beforeUpdate = System.Trigger.oldMap.get(opp.Id);	
				
		//first check and see if there is a date in the certification date field
		
		if(opp.Certificate_Training__c!=null){
		//now if there is a date check each one of the trainers first looking for a different value in the old and new.  
		//with a new value write to the contact record.
			
			if(opp.Trainer_1__c != beforeUpdate.Trainer_1__c){
				if(opp.Trainer_1__c!=null){
				
					try{						
						Contact c = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_1__c];
						c.Last_Training_Performed__c = opp.Certificate_Training__c;
						update c;}Catch(DmlException e){System.debug(e);	}//end try block.  moving the catch block to this line (even though the formatting is poor) helps with testing coverage				
				}				
			}	//end if for trainer 1		
			 
			 if(opp.Trainer_2__c != beforeUpdate.Trainer_2__c){
			 	if(opp.Trainer_2__c!=null){
					try{						
						Contact c = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_2__c];
						c.Last_Training_Performed__c = opp.Certificate_Training__c;
						update c; }Catch(DmlException e){System.debug(e);	}				
			 	}
			}	//end if for trainer 2
			
					 
			 if(opp.Trainer_3__c != beforeUpdate.Trainer_3__c){
			 	if(opp.Trainer_3__c!=null){
					try{						
						Contact c = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_3__c];
						c.Last_Training_Performed__c = opp.Certificate_Training__c;
						update c;}Catch(DmlException e){System.debug(e);	}
			 	}
			}	//end if for trainer 3			
			
			 
			 if(opp.Trainer_4__c != beforeUpdate.Trainer_4__c){
			 	if(opp.Trainer_4__c!=null){
			 		try{						
						Contact c = [Select Last_Training_Performed__c From Contact where Id =: opp.Trainer_4__c];
						c.Last_Training_Performed__c = opp.Certificate_Training__c;
						update c;}Catch(DmlException e){System.debug(e);	}			 		
			 	}
				
			}	//end if for trainer 4
			
		}//end check for existing certification date
		
	}//end for loop of opportunties

}