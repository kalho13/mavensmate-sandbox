public with sharing class SendEmail {
	
	//pass in the account Id and use it to create an email for the primary accoount contact when the opportunity stage is set to 'Scheduled'
	public static void SendScheduledEmail(String accountId){
	
		List <Contact> contacts = [SELECT Id, Name, Email FROM Contact  c WHERE  c.AccountId = :accountId AND c.Main_Contact__c = true];	
		
		for(Contact c: contacts){
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[]{c.Email};
			String[] bccAddresses = new String[]{'kal@ropescoursesinc.com'};
			mail.setToAddresses(toAddresses);
			mail.setBccAddresses(bccAddresses);			
			mail.setReplyTo('jim@ropescoursesinc.com');
			mail.setSenderDisplayName('Jim Liggett');
			mail.setTargetObjectId(c.Id);
			mail.setTemplateId('00X30000001TW63');
			//mail.setTemplateId('00Xd0000000wxDv');
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}

	}
	
}