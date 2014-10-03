global class inspectionMapController {

    

	@RemoteAction
    global  static List<Course_Inspection__c> getCourseInspections(){
        List<String> statuses = new String[]{'Next Annual', 'Scheduled'};
        /*
            1. return a list of all course inspections that are not complete. (Scheduled and Next Annual)
            2. the returned values are for courses that are not managed by distributors and are active courses
            3.  This information is used to display different colored icons on the map depending on their relationship to the inspection expiration date
        */

        /** Note: 2 __ underscores are required between the Location and Latitude/Longitude values for the gps coordinates */

        return [SELECT 
                    Id,  
                    Name, 
                    Inspection_Expiration__c, 
                    Course_Inspection__c.Course__r.Model__c, 
                    Course_Inspection__c.Course__r.Year_Built__c, 
                    Course_Inspection__c.Course__r.Account__r.Name,
                    Course_Inspection__c.Course__r.Account__r.ShippingCity, 
                    Course_Inspection__c.Course__r.Account__r.ShippingState,
                    Course_Inspection__c.Course__r.Account__r.ShippingCountry, 
                    Course_Inspection__c.Course__r.Account__r.Location__Longitude__s, 
                    Course_Inspection__c.Course__r.Account__r.Location__Latitude__s 
                FROM Course_Inspection__c 
                WHERE Status__c IN :statuses 
                AND Course_Inspection__c.Course__r.Status__c = 'Active'
                AND Course_Inspection__c.Course__r.Distributor__c = false
                AND Course_Inspection__c.Course__r.Account__r.Location__Latitude__s != null];
    }
}