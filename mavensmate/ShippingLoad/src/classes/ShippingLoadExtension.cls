public with sharing class ShippingLoadExtension {

	private final sObject mysObject;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public ShippingLoadExtension(ApexPages.StandardController stdController) {
        this.mysObject = (sObject)stdController.getRecord();
    }

    public String getRecordName() {
        return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    }

    public List<Shipping_Load__c> getJobShippingParts(){
       return [SELECT Id, Name, Part_Number__c, Pieces_Loaded__c, Number_Of_Pieces__c, Job__c, Desc__c FROM Shipping_Load__c 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('job')];
    }
}