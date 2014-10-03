global with sharing class GoogleChartController {
	
	@RemoteAction 
    global static Opportunity[] loadOpps() {
        return [select Id, Name, ExpectedRevenue, Amount from Opportunity order by CreatedDate DESC limit 10];
    }  

}