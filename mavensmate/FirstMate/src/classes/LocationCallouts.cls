public class LocationCallouts {
	
  @future (callout=true)  // future method needed to run callouts from Triggers
      static public void getLocation(id accountId){
        // gather account info
        Account a = [SELECT ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet FROM Account WHERE id =: accountId];
 
        // create an address string
        String address = '';
        if (a.ShippingStreet != null)
            address += a.ShippingStreet +', ';
        if (a.ShippingCity != null)
            address += a.ShippingCity +', ';
        if (a.ShippingState != null)
            address += a.ShippingState +' ';
        if (a.ShippingPostalCode != null)
            address += a.ShippingPostalCode +', ';
        if (a.ShippingCountry != null)
            address += a.ShippingCountry;
 
        address = EncodingUtil.urlEncode(address, 'UTF-8');
 
        // build callout
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address='+address+'&sensor=false');
        req.setMethod('GET');
        req.setTimeout(60000);
 
        try{
            // callout
            HttpResponse res = h.send(req);
 
            // parse coordinates from response
            JSONParser parser = JSON.createParser(res.getBody());
            
            System.debug('@@@@@@@@@@@@@@@@@ the parser value ' + parser);
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
 
            // update coordinates if we get back
            if (lat != null){
            	
            	System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ The new lat is ' + lat);
                a.Location__Latitude__s = lat;
                a.Location__Longitude__s = lon;
               update a;
               // upsert a;
            }
 
        } catch (Exception e) {
        	
        	System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ CAUGHT THE EXCEPTION @@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        }
    }
    
   // This is 55%
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
		
	 */ 	
    }
  
}