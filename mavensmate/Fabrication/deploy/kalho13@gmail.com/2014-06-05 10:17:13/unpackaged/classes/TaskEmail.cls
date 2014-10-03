public with sharing class TaskEmail {
	
		public static void SendScheduledEmail(String taskId){
					
			List <Task> tasks = [Select Id, Invoice_Amount__c, status, WhatId, Subject, Description, Accounting_Contact__c, What.Type, What.Name from Task where Id = :taskId];
			
			
				for(Task t: tasks){
					Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
					String[] toAddresses = new String[]{t.Accounting_Contact__c};
					String[] bccAddresses = new String[]{'kal@ropescoursesinc.com'};
					mail.setToAddresses(toAddresses);
					mail.setBccAddresses(bccAddresses);	
					String content = t.WhatId + ' is ready to invoice for ' + t.Invoice_Amount__c ;
					
					mail.setSubject(content);
					mail.setPlainTextBody(content);
		
					Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
					
					system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ' + t.What.Name);
				}

		}

}