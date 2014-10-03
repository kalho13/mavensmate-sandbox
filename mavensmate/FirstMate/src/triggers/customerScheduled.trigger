trigger customerScheduled on Opportunity (after update) {

    //always assume bulk even if intended for single
    //if the stage is Scheduled then fire off an email to the primary contact
    
    for(Opportunity opp : trigger.new){ 
        
        List<String> values = opp.Type_of_Work__c.split(';');
        Set<String> tempSet = new Set<String>();
        tempSet.addAll(values); 
        
        
        if(opp.StageName=='Scheduled' && tempSet.contains('Project')){  
            SendEmail.SendScheduledEmail(String.valueOf(opp.AccountId));    
        }       
    }

}