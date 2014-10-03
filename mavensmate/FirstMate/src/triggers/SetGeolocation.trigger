trigger SetGeolocation on Account (after insert, after update) {
    for (Account a : trigger.new){
    /*  
        
        if(trigger.old[0] <> null){
            Account newAccount = trigger.new[0];
            Account oldAccount = trigger.old[0];
            
            String oldShippingZipCode = oldAccount.ShippingPostalCode;
            String newShippingZipCode = newAccount.ShippingPostalCode;
            String newShippingStreet = newAccount.ShippingStreet;
            String oldShippingStreet = oldAccount.ShippingStreet;
            String newShippingCity = newAccount.ShippingCity;
            String oldShippingCity = oldAccount.ShippingCity;
            String oldShippingState = oldAccount.ShippingState;
            String newShippingState = newAccount.ShippingState;
        
            if (oldShippingZipCode <> newShippingZipCode  || newShippingStreet <> oldShippingStreet || oldShippingCity<>newShippingCity || oldShippingState<>newShippingState){
                System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Callong LocationCallouts ' );
                //LocationCallouts.getLocation(a.id);
                CoordinatesCallout.main(a.id);
            }
            
        }else{
            //LocationCallouts.getLocation(a.id);
            CoordinatesCallout.main(a.id);
        }   
        */
        
        //LocationCallouts.getLocation(a.id);
        //CoordinatesCallout.main(a.id);
        
        //CoordinatesCallout c = new CoordinatesCallout();
        //c.main(a.id); 
        
      }    
    
}