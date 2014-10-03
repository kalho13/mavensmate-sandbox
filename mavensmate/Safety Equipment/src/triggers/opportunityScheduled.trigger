trigger opportunityScheduled on Opportunity (after update) {
    
    //always assume bulk even if intended for single
    //if the stage is Scheduled then fire off an email to the primary contact in the Opportunity Contact Roles
    
    String templateId = [select id from EmailTemplate where Name ='Internal Contacts - Customers'].id;
        
    for(Opportunity opp : trigger.new){ 
        
        Opportunity beforeUpdate = System.Trigger.oldMap.get(opp.Id);       
        if(beforeUpdate.StageName !='Scheduled' && opp.StageName=='Scheduled'){     
            if(opp.Type_of_Work__c != null){
                List<String> values = opp.Type_of_Work__c.split(';');
                Set<String> tempSet = new Set<String>();
                tempSet.addAll(values); 
    
                if(opp.StageName=='Scheduled' && tempSet.contains('Project') && opp.Type == 'New Business'){    
                    SendEmail.SendScheduledEmail(String.valueOf(opp.Id), templateId);   
                }   //end if
            }// end if      
        } //end if
    } //end for
    
    
}