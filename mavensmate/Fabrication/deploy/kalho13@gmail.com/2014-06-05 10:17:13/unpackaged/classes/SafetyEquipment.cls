public with sharing class SafetyEquipment {

	private final Safety_Equipment__c mysObject;

    
    public SafetyEquipment(ApexPages.StandardController stdController) {
        this.mysObject = (Safety_Equipment__c)stdController.getRecord();
    }

    public SafetyEquipment(Integer startSerialNumber, Integer endSerialNumber, String status){
    	
    }

    public String getRecordName() {
        return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    }

    
}