public class InspectionCalendarSync {
	
	private final ApexPages.StandardController theController;
	public InspectionCalendarSync(ApexPages.StandardController stdController) {
		theController = stdController;
		
			List<googSession__c> tokens = [Select AuthSubSessionToken__c from googSession__c where Name = 'Token 1'];
	   		string ast = tokens[0].AuthSubSessionToken__c;
			CalendarService s = new CalendarService(); 
			s.setAuthSubToken(ast);
			List<Event> events = new List<Event>();
			GoogleData.Calendar cal = s.getCalendarByTitle('Detroit Tigers');
		
		List<Course_Inspection__c> inspections = [SELECT Previous_Inspection_Date__c FROM Course_Inspection__c];
		
		for (Course_Inspection__c c : inspections) {
			if(c.Previous_Inspection_Date__c!=null){
				Datetime startTime = Datetime.newInstance(c.Previous_Inspection_Date__c.year(),c.Previous_Inspection_Date__c.month(), c.Previous_Inspection_Date__c.day());
				startTime = startTime.addMonths(12);
				startTime = startTime.addHours(8); 
				
				Event ee = new Event(
					subject = 'Last Inspection Report Was On ' +  c.Previous_Inspection_Date__c,
					description = 'Time for a new inspection',
					ActivityDateTime = startTime,
					DurationInMinutes=360
				);
			}
		}
						
	}
    
   
   public List<Event> getTigersSchedule(){
  // public GoogleData getCalendar() {
	   List<googSession__c> tokens = [Select AuthSubSessionToken__c from googSession__c where Name = 'Token 1'];
	   string ast = tokens[0].AuthSubSessionToken__c;
		CalendarService s = new CalendarService(); 
		s.setAuthSubToken(ast);
		//GoogleData.Calendar cal = s.getCalendarByTitle('Detroit Tigers');
		//GoogleData evs_Range = s.getFeed(cal.alternate +'?max-results=4&orderby=starttime&sortorder=ascending');
		List<Event> events = new List<Event>();
		return events;
   }
   
   //what is the best way to trigger this method?  Or should I say where?
   @RemoteAction
   public static void addEvents(){
   	 	List<googSession__c> tokens = [Select AuthSubSessionToken__c from googSession__c where Name = 'Token 1'];
	   string ast = tokens[0].AuthSubSessionToken__c;
		CalendarService s = new CalendarService(); 
		s.setAuthSubToken(ast);
		List<Event> events = new List<Event>();
		GoogleData.Calendar cal = s.getCalendarByTitle('Detroit Tigers');
		
		List<Course_Inspection__c> inspections = [SELECT Previous_Inspection_Date__c FROM Course_Inspection__c];
		
		for (Course_Inspection__c c : inspections) {
			if(c.Previous_Inspection_Date__c!=null){
				Datetime startTime = Datetime.newInstance(c.Previous_Inspection_Date__c.year(),c.Previous_Inspection_Date__c.month(), c.Previous_Inspection_Date__c.day());
				startTime = startTime.addMonths(12);
				startTime = startTime.addHours(8); 
				
				Event ee = new Event(
					subject = 'Last Inspection Report Was On ' +  c.Previous_Inspection_Date__c,
					description = 'Time for a new inspection',
					ActivityDateTime = startTime,
					DurationInMinutes=360
				);
			}
		}
		
		
   }

}