global with sharing class FileUploadController {
    
    @RemoteAction
    global static String attachBlob(String parentId, String attachmentId, String fileName, String contentType, String base64BlobValue){
        /*
        parentId: The sfdc object Id this file will be attached to
        attachmentId: The record of the current Attachment file being processed
        fileName: Name of the attachment
        contentTye: Content Type of the file being attached
        base64BlobValue: Base64 encoded string of the file piece currently processing
        */
               
        //If recordId is blank this is the first part of a multi piece upload
        if(attachmentId == '' || attachmentId == null){
            Attachment att = new Attachment(
                ParentId = parentId,
                Body = EncodingUtil.Base64Decode(base64BlobValue),
                Name = fileName,
                ContentType = contentType
            );
            insert att;            
            //Return the new attachment Id
            return att.Id;
            
        }else{
            for(Attachment atm : [select Id, Body from Attachment where Id = :attachmentId]){
                //Take the body of the current attachment, convert to base64 string, append base64 value sent from page, then convert back to binary for the body
                update new Attachment(Id = attachmentId, Body = EncodingUtil.Base64Decode(EncodingUtil.Base64Encode(atm.Body) + base64BlobValue));
            }            
            //Return the Id of the attachment we are currently processing
            return attachmentId;
        }
    }

    
   @isTest
   private static void testFileUploads(){
   	   
   
   //to add additional information to the account record iterate through the returned list before inserting   	
   List<Account> accts = TestConfiguration.createAccounts('Account', 1);
   insert accts;
 
   //to add additional information to the course record iterate through the returned list before inserting 
   List<Course_Detail__c> courses = TestConfiguration.createCourses('Course', 1, accts);
   insert courses; 
    
   List<Course_Inspection__c> inspections = TestConfiguration.createInspections('Inspection', 1, courses);
   insert inspections;     	   	
   
  	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
   	FileUploadController fc = new FileUploadController();
   	String result = FileUploadController.attachBlob(inspections.get(0).Id, '', 'test.js', 'javascript', bodyBlob.toString());
  
     List<Attachment> a = [Select Id, ContentType, Body, ParentId from Attachment where Id =: result];
     System.assertNotEquals(a.get(0), null);
     Blob newBody = EncodingUtil.Base64Decode(EncodingUtil.Base64Encode(a.get(0).Body) + bodyBlob.toString());
     String result2 = FileUploadController.attachBlob(inspections.get(0).Id, a.get(0).Id,'','',bodyBlob.toString());
     System.assertNotEquals(result2, null);   
   
   }
   
}