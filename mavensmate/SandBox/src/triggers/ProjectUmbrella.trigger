trigger ProjectUmbrella on Case (after insert) {
	
	List<ProjectUmbrellaItem__c> items = new List<ProjectUmbrellaItem__c>();  //creating a list of related shop items and adding them to this list for insert if the Record Type is Project Umbrella

		 for(Case c : Trigger.New){
			 if(c.RecordType__c=='Project Umbrella'){	
			 	
			 	/*
			 	When creating a Project Umbrella type case, related shop items need to be automatically added.
			 	*/
			 			 	
				 	//create the items individually
				 	ProjectUmbrellaItem__c item1 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item2 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item3 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item4 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item5 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item6 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item7 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item8 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item9 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item10 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item11 = new ProjectUmbrellaItem__c();
				 	ProjectUmbrellaItem__c item12 = new ProjectUmbrellaItem__c();
				 					 	
				 	item1.Case__c = c.Id;
				 	item1.Work_Process__c = 'Cleaning';
				 	item2.Case__c = c.Id;
				 	item2.Work_Process__c = 'Elements';
				 	item3.Case__c = c.Id;
				 	item3.Work_Process__c = 'Engineering';
				 	item4.Case__c = c.Id;
				 	item4.Work_Process__c = 'Fabrication';
				 	item5.Case__c = c.Id;
				 	item5.Work_Process__c = 'Installation';	
				 	item6.Case__c = c.Id;
				 	item6.Work_Process__c = 'Material Handling';	
				 	item7.Case__c = c.Id;
				 	item7.Work_Process__c = 'Paint';	
				 	item8.Case__c = c.Id;
				 	item8.Work_Process__c = 'Plasma';	
				 	item9.Case__c = c.Id;
				 	item9.Work_Process__c = 'Sewing';	
				 	item10.Case__c = c.Id;
				 	item10.Work_Process__c = 'Shipping';	
				 	item11.Case__c = c.Id;
				 	item11.Work_Process__c = 'Steel';	
				 	item12.Case__c = c.Id;
				 	item12.Work_Process__c = 'Theming';
				 					 			 	
				 		 	
				 	items.add(item1);
				 	items.add(item2);
				 	items.add(item3);
				 	items.add(item4);
				 	items.add(item5);
				 	items.add(item6);
				 	items.add(item7);
				 	items.add(item8);
				 	items.add(item9);
				 	items.add(item10);
				 	items.add(item11);
				 	items.add(item12);
				 	
			 	}
			 
			Integer size = items.size();	//before we try an insert lets make sure there is something in the list.
			if(size>0){
				insert items;
			}	 		 	
	 }
	 


}