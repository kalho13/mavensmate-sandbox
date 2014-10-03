public with sharing class ShippingLoadProjectExtension {

	private final sObject mysObject;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public ShippingLoadProjectExtension(ApexPages.StandardController stdController) {
        this.mysObject = (sObject)stdController.getRecord();
    }

    public String getRecordName() {
        return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    }

    public List<Shipping_Load_Project__c> getShippingProjects(){
       return [SELECT Id, Name, Job__c  FROM Shipping_Load_Project__c 
                   WHERE Status__c = 'Open'];
    }

     public List<Shipping_Load_Project__c> getOpenProjects(){     

        return [SELECT Job__c FROM Shipping_Load_Project__c  WHERE Status__c = 'Open'];
     
    }
}