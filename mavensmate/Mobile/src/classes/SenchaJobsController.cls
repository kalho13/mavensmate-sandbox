public with sharing class SenchaJobsController {
	public SenchaJobsController() {}
 // One of the parameters supplied by the DirectProxy read method.
	    public class QueryRequest {
	        Integer start;
	        Integer recordCount;
	        List < Map < String, String >> sortParams;

	        Public QueryRequest() {
	            start = 1;
	            recordCount = 1;
	        }

	        Public QueryRequest(Integer pStart, Integer pRecordCount) {
	            start = pStart;
	            recordCount = pRecordCount;
	        }
	    }//close inner class QueryRequest

	    // The server response expected by the ExtJS DirectProxy API methods.
	    public class Response {
	        public Boolean success;
	        public String errorMessage;
	        public List < SObject > records;
	        public Integer total;
	        Response() {
	            records = new List < SObject > ();
	            success = true;
	        }
	    }//close inner class Response		
	

	//Query Parts
	@RemoteAction
    public static Response Query(QueryRequest qr) {
        Response resp = new Response();
        List< Job_Part__c > partList;
        try {
            partList = getAllJobParts();
        } catch (Exception e) {
            resp.success = false;
            resp.errorMessage = 'Query failed: ' + e.getMessage();
            return resp;
        }
        //Supply only the requested records
        for (Integer recno = qr.start;
        recno < (qr.start + qr.recordCount) && recno < partList.size(); ++recno) {
            resp.records.add(partList[recno]);
        }
        resp.total = partList.size();
        resp.success = true;
        return resp;
    }

    //Query Open Jobs
    @RemoteAction
    public static Response QueryOpenJobs(QueryRequest qr) {
        Response resp = new Response();
        List < Job__c > openJobList;
        try {
            openJobList = getOpenJobs();

            System.debug('############## How many OPEN Jobs ####### : ' + openJobList.size());
        } catch (Exception e) {
             System.debug('############## Error in the query ####### : ' + e.getMessage());
            resp.success = false;
            resp.errorMessage = 'Query failed: ' + e.getMessage();
            return resp;
        }

        System.debug('################# QueryRequest Start no. : ' + qr.start);
        //Supply only the requested records
        for (Integer recno = qr.start;
        recno < (qr.start + qr.recordCount) && recno < openJobList.size(); ++recno) {
            resp.records.add(openJobList[recno]);
        }
        resp.total = openJobList.size();
        resp.success = true;
        return resp;
    }

	private static List<Job_Part__c> getAllJobParts(){
		return  [SELECT Id, Name FROM Job_Part__C WHERE Job__r.Name = '2249'];
	}

	private static List<Job__c> getOpenJobs(){
		return [SELECT Id, Name from Job__c WHERE Status__c = 'Open'];		
	}
}