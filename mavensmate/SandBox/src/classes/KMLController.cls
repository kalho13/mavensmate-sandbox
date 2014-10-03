public class KMLController {
	
	public Opportunity[] oppList{get;set;}
	
	public KMLController(){
		String sel = '';
		
		if(null!=ApexPages.currentPage().getParameters().get('sel')){
			sel = ApexPages.currentPage().getParameters().get('sel');
			ApexPages.currentPage().getHeaders().put('content-disposition', 'attachemnt; filename=\"googleEarth.kml"');
		}
		
		String[] idList = sel.split(',', 0);
		oppList = [SELECT Id, 
							Name, 
							Amount, 
							CloseDate, 
							Account.Name, 
							Account.ShippingStreet, 
							Account.ShippingCity, 
							Account.ShippingState, 
							Account.ShippingCountry, 
							Account.ShippingPostalCode
					FROM Opportunity 
					WHERE ID 
					IN :idList];
		
	}

}