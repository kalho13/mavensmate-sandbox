public class mapController {

   public String addrStr;
   public String AddrArStr;
   public User usr;
   public String myKey;
   Account[] accts;  
  
   Course_Detail__c[] courses;
   String courseStr;
   
   public Course_Detail__c[] getOpenCourses(){
   	courses = [SELECT Id, Name, Account__r.Name, Distributor__c, Account__r.ShippingStreet, Account__r.ShippingCity, Account__r.ShippingState, Account__r.ShippingPostalCode, Account__r.ShippingCountry, Model__c, Year_Built__c, Status__c 
   				FROM Course_Detail__c 
   				WHERE Status__c='Open'];
   				/*
   				for(Course_Detail__c course:courses){
   					
   					courseStr = courseStr + course.Account__r.Name + ' : ' +
   					course.Model__c+ ':'+
   					course.Year_Built__c+ '~:~' +
   					course.Account__r.BillingStreet + '~:~' +
   					course.Account__r.BillingCity + '~:~' +
   					course.Account__r.BillingState + '~:~' +
   					course.Account__r.BillingPostalCode + '~:~' +   			
   					course.Id + '~:~' +
   					course.Distributor__c + '~::~';
   					
   					System.debug('The courseStr : ' + courseStr);
   				}
   				*/
   		return courses;
   }


   public Account[] getMyAccts() {
      					String usrId = UserInfo.getUserId();
      					accts = [Select Id, Name, Rating, Customer_Priority__c, 
                         OwnerId, BillingStreet, BillingCity, BillingState, 
                         BillingPostalCode, BillingCountry
                         From Account 
                         where Type = 'Current Customer'
                         And OwnerId =: usrId ];
                           
      			for(Account acct : accts) {   
      	     
         			addrStr = addrStr + acct.Name + ' : ' 
                   + acct.Customer_Priority__c  + ':' 
                   + acct.Id + '~:~'+ acct.BillingStreet + '~:~' 
                   + acct.BillingCity + '~:~' +  acct.BillingState + '~:~' 
                   + acct.BillingPostalCode + '~::~';                   
                    	
            
      		}

      return accts;     
   }

   public String getmyKey() {  // Set up google maps api key     
      myKey = 'http://maps.google.com/maps?file=api&v=2.55&';
      // In the following line, enter your google maps key     
      // to get an api key, visit the Google Maps API site     
      // http://code.google.com/apis/maps/signup.html     
      myKey = myKey + 'AIzaSyA1NjbhAwdfru4t1-Yyadg6967WvjCAsRo';     
      return myKey;
   }
   
   
   public String getCourseStr(){
   		courseStr='';
   		Course_Detail__c [] theCourses = getOpenCourses();
   		
   		for(Course_Detail__c course:courses){
   			courseStr = courseStr + course.Account__r.Name + ' : ' +
   			course.Model__c+ ':'+
   			course.Year_Built__c+ ':' +
   			course.Distributor__c + '~:~' +   			
   			course.Account__r.ShippingStreet + '~:~' +
   			course.Account__r.ShippingCity + '~:~' +
   			course.Account__r.ShippingState + '~:~' +
   			course.Account__r.ShippingPostalCode + '~:~' +   			
   			course.Id + '~:~' +      			
   			course.Account__r.ShippingCountry+ '~::~';
     		}
   		return courseStr;   	
   }
 /*  
   public String getAddrArStr(){
      addrStr = '';
      Account[] theRecs = getMyAccts();      
      for(Account acct : accts) {         				
      	     
         			addrStr = addrStr + acct.Name + ' : ' 
                   + acct.Customer_Priority__c  + ':' 
                   + acct.Id + '~:~'+ acct.BillingStreet + '~:~' 
                   + acct.BillingCity + '~:~' +  acct.BillingState + '~:~' 
                   + acct.BillingPostalCode + '~::~';	            
      		}
	
      return addrStr;	
   }
*/
}