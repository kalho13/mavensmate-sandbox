trigger invoiceNotificationTask on Task (after update) {
	
	User user = [SELECT Id, Name FROM User where Name = 'Ropes Courses'];
	
	

	for(Task t : trigger.new){			
		Task beforeUpdate = System.Trigger.oldMap.get(t.Id);		
		
		if(beforeUpdate.Status !='Completed' && t.Status=='Completed'  && String.valueOf(t.Invoice_Amount__c) != ''){	
			//TaskEmail.SendScheduledEmail(t.Id);
			
			Datetime aDT = t.Sorting_Date__c;
			aDT.addHours(1);
			//String myDate = aDT.format('YYYY-MM-DDThh:mm:ss+hh:mm');
			
			String subject = ' Invoice ' + t.What.Name + ' for ' +t.Invoice_Amount__c;
			   Event e = new Event();
			   e.ActivityDate = t.Sorting_Date__c;   				
   				 e.Subject =subject;
   				 e.IsReminderSet = true;
    			e.OwnerId = user.Id;
    			e.IsAllDayEvent = false;
    			e.DurationInMinutes = 60;
    			e.ActivityDateTime = aDT;
    			insert e;
		}

	}

}