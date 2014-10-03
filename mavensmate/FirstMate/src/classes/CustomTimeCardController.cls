global with sharing class CustomTimeCardController {
	
	public String phoneGapUrl{
		get{
			String userAgent = ApexPages.currentPage().getHeaders().get('User-Agent');
			if(userAgent.contains('android')){
				return 'phonegap-1.2.0-android.js';
			}else{
				return 'phonegap-1.2.0-ios.js';
			}
			
		}
	}//end phoneGapUrl
	
	@RemoteAction
	global static List<Time_Book__c> queryTimeBooks(){
		return[SELECT Id, Name FROM Time_Book__c ORDER BY Name];
	}
	
	@RemoteAction
	global static List<Time_Sheet__c>queryTimeSheets(String bookId){
		return[SELECT Id, Name, Hours_for_Time_Period__c, Time_Sheet_Start_Date__c, Time_Sheet_End_Date__c 
			   FROM Time_Sheet__c 
			   WHERE Time_Book__c = :bookId];
		
	}
	
	@RemoteAction
	global static List<Time_Entry__c>queryTimeEntries(String sheetId){
		return[SELECT Id, Name, Time_Category__c, Entry_Date__c, TimeTotal__c
				FROM Time_Entry__c
				WHERE Time_Sheet__c = :sheetId];
	}

}