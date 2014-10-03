trigger opportunityScheduled on Opportunity (after update) {
    
    for(Opportunity opp : trigger.new){ 
        if(opp.StageName=='Scheduled' && opp.Type_of_Work__c.contains('Project')){          
            SendEmail.SendScheduledEmail(String.valueOf(opp.AccountId));    
        }       
    }

}