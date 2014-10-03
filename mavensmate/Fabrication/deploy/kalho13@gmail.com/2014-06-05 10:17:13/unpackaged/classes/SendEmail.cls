public with sharing class SendEmail {
	
	//pass in the account Id and use it to create an email for the primary account contact when the opportunity stage is set to 'Scheduled'.
	public static void SendScheduledEmail(String oppId, String templateId){
		
		List <Contact> contacts = [Select c.Id, c.LastName, c.FirstName, c.Email From Contact c Where ID IN 
									(Select ContactId From OpportunityContactRole Where IsPrimary = true and OpportunityId = :oppId)									
								  ];
		
		for(Contact c: contacts){
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[]{c.Email};
			String[] bccAddresses = new String[]{'kal@ropescoursesinc.com'};
			mail.setToAddresses(toAddresses);
			mail.setBccAddresses(bccAddresses);	
			mail.setReplyTo('jim@ropescoursesinc.com');
			mail.setSenderDisplayName('Jim Liggett');
			mail.setTargetObjectId(c.Id);
			mail.setTemplateId(templateId);
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}

	}
	
}