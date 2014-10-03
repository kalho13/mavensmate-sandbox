public class AppConfigSupport {
	
	//this is a keyword configuration
	
	private static AppConfig__c testconfig = null;
	
	public static AppConfig__c GetAppConfig(){
		
		//isRunningTest is a static method
		//how would the testconfig be anything but null here
		if(Test.isRunningTest() && testconfig!=null) return testconfig;
		
		
		AppConfig__c theobject = AppConfig__c.getInstance('default');
			if(theobject==null || Test.isRunningTest()){
				theobject = new AppConfig__c();  //am I creating a 2nd object here?
				theobject.name = 'default';
				theobject.EnableDiagnostics__c = (Test.isRunningTest())? true: false;
				
				//If the test is not running then insert the object so anoter test will find it
				if(!Test.isRunningTest()){
					 Database.Insert(theobject);
				}else{
					 testconfig = theobject;
				}//close !Test.isRunningTest
			}
		return theobject;
		}//close getAppConfig()
	
	public static Boolean DiagnosticsEnabled
	{ 
		get
		{
			return GetAppConfig().EnableDiagnostics__c;
		}
	}
	
}