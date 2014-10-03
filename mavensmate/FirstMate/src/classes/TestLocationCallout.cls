/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestLocationCallout {
	
	static{
		
	}

    static testMethod void myUnitTest() {
    	/*
    	//add code here to create data
		Account account = new Account();
		account.ShippingStreet = '3015 N. Maple St.';
		account.ShippingCity = 'Spokane';
		account.ShippingState='WA';
		account.ShippingPostalCode = '99205';
		account.ShippingCountry = 'US';
		account.Name = 'Test Company';
		insert account;
		
		String accountId = account.Id;
		
		Account queryAccount = [select id,name from Account where Id =: accountId ];
		System.assertEquals(queryAccount.Name, 'Test Company');
		*/
    	
     //add code here to create data
		Account account = new Account();
		account.ShippingStreet = '3015 N. Maple St.';
		account.ShippingCity = 'Spokane';
		account.ShippingState='WA';
		account.ShippingPostalCode = '99205';
		account.ShippingCountry = 'US';
		account.Name = 'Test Company';
		insert account;
		
		String accountId = account.Id;		
		Account queryAccount = [select id,name, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry from Account where Id =: accountId ];	
		
		 // create an address string
        String address = '';
        if (queryAccount.ShippingStreet != null)
            address += queryAccount.ShippingStreet +', ';
        if (queryAccount.ShippingCity != null)
            address += queryAccount.ShippingCity +', ';
        if (queryAccount.ShippingState != null)
            address += queryAccount.ShippingState +' ';
        if (queryAccount.ShippingPostalCode != null)
            address += queryAccount.ShippingPostalCode +', ';
        if (queryAccount.ShippingCountry != null)
            address += queryAccount.ShippingCountry;
		
			
		System.assertEquals(queryAccount.Name, 'Test Company');
		System.assertNotEquals(queryAccount.Name, '');
		System.assertEquals(queryAccount.ShippingCity, 'Spokane');
		
		//counted as 0%
		Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?' + address + '&sensor=false');
        req.setMethod('GET');
        req.setTimeout(60000);
        //System.assertEquals( req.getEndpoint(), 'http://maps.googleapis.com/maps/api/geocode/json?address=&sensor=false');
		
		// callout
            HttpResponse res = h.send(req);
 
            // parse coordinates from response
            JSONParser parser = JSON.createParser(res.getBody());
            double lat = null;
            double lon = null;
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                    (parser.getText() == 'location')){
                       parser.nextToken(); // object start
                       while (parser.nextToken() != JSONToken.END_OBJECT){
                           String txt = parser.getText();
                           parser.nextToken();
                           if (txt == 'lat')
                               lat = parser.getDoubleValue();
                           else if (txt == 'lng')
                               lon = parser.getDoubleValue();
                       }
 
                }
            }
		//System.assertNotEquals(lat, null);
		//System.assertNotEquals(lon, null);
		
		
    }

}