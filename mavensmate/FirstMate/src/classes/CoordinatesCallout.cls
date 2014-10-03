public with sharing class CoordinatesCallout {
		
	
	@future (callout=true)  // future method needed to run callouts from Triggers
	 public static void main(id accountId){
	
		Account a = getAccount(accountId);
		
		String location = getAddress(a); //get the address
		
		System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@  AND THE ACCOUNT IS : ' + a);
		
		HttpRequest req = buildWebServiceRequest(location); //build the web service request
		HttpResponse resp = invokeWebRequest(req); 	//invoke the web service request
		handWebServiceResponse(resp,a);	
		if(a <> null)update a;
	
		//handle the web service response
	}
	
	public static Account getAccount(id accountId){
		return [SELECT ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet FROM Account WHERE id =: accountId]; 
		
	}

	public static String getAddress(Account a){
    
      //  a = [SELECT ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet FROM Account WHERE id =: accountId]; 
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
        return address;        
	}
	
	
	public static HTTPRequest buildWebServiceRequest(String location){
		System.Debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Location: ' + location);
		//Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address='+location+'&sensor=false');
        req.setMethod('GET');
        req.setTimeout(60000);
        System.debug('@@@@@@@@@@@@@@@@@  HTTPREQUEST ' + req);
        return req;
	}
	
	public static HttpResponse invokeWebRequest(HttpRequest req){
		Http h = new Http();
		
		try{
            // callout
            System.debug('@@@@@@@@@@@@@@@@@  HTTPREQUEST2 ' + req);
            HttpResponse resp = h.send(req);
 
 		 return resp;
        } catch (Exception e) {
        	System.debug('@@@@@@@@@@@@@@@@@@@@@@@ CAUGHT AN EXCEPTION @@@@@@@@@@@@@@@@@@@@@@@@@');
        	return null;
        }

	}
	
	public static void handWebServiceResponse(HttpResponse resp, Account a){
		
		System.debug('@@@@@@@@@@@@@@@@@@@@@@ HttpResponse : ' + resp);
		System.debug('@@@@@@@@@@@@@@@@@@@@@@ Account : ' + a);
	
	        JSONParser parser = JSON.createParser(resp.getBody());
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
                a.Location__Latitude__s = lat;
                a.Location__Longitude__s = lon;
               
            }

	
	}

}