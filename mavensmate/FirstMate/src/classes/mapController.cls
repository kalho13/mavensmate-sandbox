public class mapController {

   public String addrStr;
   public String AddrArStr;
   public User usr;
   public String myKey;
   public String help = 'HELP';
   Account[] accts;
  

   public Account[] getMyAccts() {
      					String usrId = UserInfo.getUserId();
      					accts = [Select Id, Name, Rating, CustomerPriority__c, 
                         OwnerId, BillingStreet, BillingCity, BillingState, 
                         BillingPostalCode
                         From Account 
                         where Rating = 'Hot'
                         And OwnerId =: usrId ];
                           
      			for(Account acct : accts) {   
      				System.debug(' ^^^^^^^^^^^^^^^^^^^^@@@@@@@@@@@@@@@@@@@@ building addrStr ' + acct.Name);  
      	     
         			addrStr = addrStr + acct.Name + ' : ' 
                   + acct.CustomerPriority__c  + ':' 
                   + acct.Id + '~:~'+ acct.BillingStreet + '~:~' 
                   + acct.BillingCity + '~:~' +  acct.BillingState + '~:~' 
                   + acct.BillingPostalCode + '~::~';	
            
      		}
	System.debug(' ^^^^^^^^^^^^^^^^^^^^@@@@@@@@@@@@@@@@@@@@ building addrStr ' + addrStr);  
      return accts;     
   }
    
   public String getmyKey() {  // Set up google maps api key 
    
      myKey = 'http://maps.google.com/maps?file=api&v=2&';

      // In the following line, enter your google maps key 
    
      // to get an api key, visit the Google Maps API site 
    
      // http://code.google.com/apis/maps/signup.html 
    
      myKey = myKey + 'AIzaSyA1NjbhAwdfru4t1-Yyadg6967WvjCAsRo';
     
      return myKey;
   }
    public String gethelp(){
    	System.debug('****************** gethelp()  ***********************');   
    	return 'HELP'; 
    		
    }
    
   public String getAddrArStr(){
      addrStr = '';
      Account[] theRecs = getMyAccts();
      
      for(Account acct : accts) {   
      				System.debug(' ^^^^^^^^^^^^^^^^^^^^@@@@@@@@@@@@@@@@@@@@ building addrStr ' + acct.Name);  
      	     
         			addrStr = addrStr + acct.Name + ' : ' 
                   + acct.CustomerPriority__c  + ':' 
                   + acct.Id + '~:~'+ acct.BillingStreet + '~:~' 
                   + acct.BillingCity + '~:~' +  acct.BillingState + '~:~' 
                   + acct.BillingPostalCode + '~::~';	
            
      		}
	System.debug(' ^^^^^^^^^^^^^^^^^^^^@@@@@@@@@@@@@@@@@@@@ building addrStr ' + addrStr);  
      return addrStr;	
   }

}