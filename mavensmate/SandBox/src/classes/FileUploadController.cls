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
   	
   	Account acct = new Account(Name='Account 1');
   	insert acct;
   	
   	Course_Detail__c course = new Course_Detail__c(Name='Course1', Account__c = acct.Id);
   	insert course;
   	
   	//Course_Inspection__c = new Course_Inspection__c(Name='Inspection1');
   	
   	//this has no coverage as is
   	FileUploadController fc = new FileUploadController();
   	
   	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
   	//do I need to create an account, course, course inspection first?
   	Attachment attachment = new Attachment( 
   							ParentId = 'a0bd0000002KNtc',
                			//Body = EncodingUtil.Base64Decode(base64BlobValue),
                			Body = bodyBlob,
                			Name = 'test.js',
                			ContentType = 'javascript');
     insert attachment;
     Attachment a = [Select Id, ParentId from Attachment ];
     System.assertEquals(a.ParentId, 'a0bd0000002KNtc');   	
   	
   }
}