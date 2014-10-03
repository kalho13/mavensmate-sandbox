@isTest
private class TestSafetyEquipment {

    static Safety_Equipment__c equipment;
    
    //set everything up here for each test Method
     @IsTest static void init(){

     	List<Account> accounts = TestConfiguration.createAccounts('Account', 1);
     	insert accounts;

     	//reference the Safety_Equipment__c items through the controller
     	equipment = new Safety_Equipment__c(Start_Serial_Number__c = 1, End_Serial_Number__c = 10, Comma_Separated_Serial_Numbers__c = '1000,1003,1007', Status__c = 'Inventory');
		ApexPages.StandardController sc = new ApexPages.StandardController(equipment); //ok
		SafetyEquipmentController cont = new SafetyEquipmentController(sc); //ok

	   PageReference pref = new PageReference('/apex/SafetyEqupment?action=Inventory');
       pref = Page.SafetyEquipment;
       Test.setCurrentPage(pref);

       PageReference pref2 = cont.AssignInventory();
       System.assertNotEquals(pref2, null);

       System.assert(ApexPages.getMessages().get(0).getSeverity() == ApexPages.Severity.INFO); 

       PageReference pref3 = cont.AssignInventoryClose();
       System.assertNotEquals(pref3, null);
  
       PageReference pref4 = cont.AssignAccount();
       System.assertNotEquals(pref4, null);

       PageReference pref5 = cont.AssignAccountClose();
       System.assertNotEquals(pref5, null);

	}
}