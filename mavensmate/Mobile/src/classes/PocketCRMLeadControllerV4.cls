public with sharing class PocketCRMLeadControllerV4 {
	private string leads;

    //Constructor.
    public PocketCRMLeadControllerV4() {}

    //One of the parameters supplied by the DirectProxy read method
    //inner class
      public class QueryRequest{
        Integer start;
        Integer recordCount;
        List<Map<String, String>> sortParams;

        //inner class constructor 1
        Public QueryRequest(){
          start = 1;
          recordCount = 1;
        }

        //inner constructor 2
        Public QueryRequest(Integer pStart, Integer pRecordCount){
          start = pStart;
          recordCount = pRecordCount;
        }
      }


      public class Response{
        public Boolean success;
        public String errorMessage;
        public List<SObject> records;
        public Integer total;
        Response(){
          records = new List<SObject> ();
          success = true;
        }
      }



       //=========================================================================
       //PUBLIC CRUD REMOTE ACTION METHODS CALLED BY SENCH PROXY
        //=========================================================================

        @RemoteAction
        public static Response Query(QueryRequest qr){
          Response resp = new Response();
          List<Lead> leadList;
          try{
            leadList = getAllLeads();
          }catch(Exception e){
            resp.success = false;
            resp.errorMessage = 'Query Failed: ' + e.getMessage();
            return resp;
          }

          //supply only the requested records/  How is the request defined?
          for(Integer recno = qr.start;recno<(qr.start+qr.recordCount)&& recno<leadList.size(); ++recno){
            System.debug('The lead id from the query ' + leadList[recno].Id);
            resp.records.add(leadList[recno]);
         }
         resp.total = leadList.size();
         resp.success = true;
         return resp;
        }

        @RemoteAction
        public static Response Edit(List<Lead> LeadData){
          return updatedLeadList(LeadData);
        }

        @RemoteAction
        public static Response Add(List<Lead> LeadData){
          return insertLeadList(LeadData);
        }

        @RemoteAction
        public static Response Destroy(List<Lead> LeadData){
          return deleteLeadList(LeadData);
        }


        private static List<Lead> getAllLeads(){
          return [SELECT FirstName, LastName, Company, Title, Phone, MobilePhone, Email, Status FROM Lead LIMIT 25];
        }

        private static Response updatedLeadList(List<Lead> LeadData){
          Response resp = new Response();
          resp.success = true;

          try{
            UPSERT LeadData;
          }catch(Exception e){
            resp.success = false;
            resp.errorMessage = 'Update Failed: ' + e.getMessage();
          }
          //what does the repsonse contain?
          return resp;

        }

        //what is the source of the LeadData being passed in?
        private static Response insertLeadList(List<Lead> LeadData){
           Response resp = new Response();
          resp.success = true;
          System.debug('Remote Lead Id that is malformed ' + LeadData[0].Id);
          try{
            INSERT LeadData;
            }catch(Exception e){
              resp.success = false;
              resp.errorMessage = 'Insert Failed: ' + e.getMessage();
            }
          return resp;
        }

        private static Response deleteLeadList(List<Lead> LeadData){
           Response resp = new Response();
          resp.success = true;
          try{
            DELETE LeadData;
            }catch(Exception e){
              resp.success = false;
              resp.errorMessage = 'Deletion Failed: ' + e.getMessage();
            }
          return resp;
        }

    
}