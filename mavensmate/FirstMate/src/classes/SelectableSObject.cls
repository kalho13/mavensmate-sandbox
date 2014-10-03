public with sharing class SelectableSObject {
	
	private SObject record;
	public Boolean selected{get;set;}
	
	//Universal constructor for any Salesforce object type
	public SelectableSObject(SObject obj){
		record = obj;
		selected=false;		
	}
	
	//Getter for the Asset
	public Asset getAsset(){
		return (Asset)record;
	}
	
	//getter for the Contact
	public Contact getContact(){
		return (Contact)record;
	}
	
	//getter for the Lin_Item__c
	//public Course__c getCourse(){
//		return (Course__c)record;
//	}
	
	
	//getter for the Lin_Item__c
/*	public Line_Item__c getLine_Item__c(){
		return (Line_Item__c)record;
	}
	
	*/

}