public with sharing class SafetyEquipmentController {

	public SafetyEquipmentController(){}
	public Safety_Equipment__c assign;
	public String errorMessage {get;set;}
	List<Safety_Equipment__c> safetyList = new List<Safety_Equipment__c>();
  

 public SafetyEquipmentController(ApexPages.StandardController stdController) {
        this.assign = (Safety_Equipment__c)stdController.getRecord();
  }

   public PageReference AssignInventory(){     
          PageReference p = Apexpages.Currentpage();
          List<Safety_Equipment__c> safetyList = new List<Safety_Equipment__c>();
          Safety_Equipment__c item;
        for(Integer a = Integer.valueOf(assign.Start_Serial_Number__c); a <= Integer.valueOf(assign.End_Serial_Number__c); a++){
            item = new Safety_Equipment__c();
            item.Assigned_Date__c = assign.Assigned_Date__c;
            item.Ball_Shank_Batch__c = assign.Ball_Shank_Batch__c;
            item.Ball_Shank_Die__c = assign.Ball_Shank_Die__c;
            item.Ferule_Batch__c = assign.Ferule_Batch__c;
            item.Ferule_Die__c = assign.Ferule_Die__c;
            item.Manufacture_Date__c = assign.Assigned_Date__c;
            item.Model__c = assign.Model__c;
            item.Serial_Number__c = Integer.valueOf(a);
            item.name = String.valueOf(a);
            item.Status__c = 'Inventory';
            item.Test_Date__c = assign.Test_Date__c;
            item.Test_Results__c = assign.Test_Results__c;
            item.Tested_By__c = assign.Tested_By__c;
            item.Safety_Equipment__c = assign.Safety_Equipment__c;
            
            safetyList.add(item);
        }
        //now lets get the serial numbers seperated by comma
        if(assign.Comma_Separated_Serial_Numbers__c <> null){       
           List<String> commaSeparatedList = new List<String>();
           commaSeparatedList = assign.Comma_Separated_Serial_Numbers__c.split(',');         
            for(Integer z = 0; z < commaSeparatedList.size(); z++){
             	item = new Safety_Equipment__c();
                item.Assigned_Date__c = assign.Assigned_Date__c;
                item.Ball_Shank_Batch__c = assign.Ball_Shank_Batch__c;
                item.Ball_Shank_Die__c = assign.Ball_Shank_Die__c;
                item.Ferule_Batch__c = assign.Ferule_Batch__c;
                item.Ferule_Die__c = assign.Ferule_Die__c;
                item.Manufacture_Date__c = assign.Assigned_Date__c;
                item.Model__c = assign.Model__c;
                item.Serial_Number__c = Integer.valueOf(commaSeparatedList[z]);
                item.name = commaSeparatedList[z];
                item.Status__c = 'Inventory';
                item.Test_Date__c = assign.Test_Date__c;
                item.Test_Results__c = assign.Test_Results__c;
                item.Tested_By__c = assign.Tested_By__c;
                safetyList.add(item);
            } //end for loop
        }  //end if values in the comma separated values field is null  
      
        try{
          insert safetyList;         
           Apexpages.Addmessage(new Apexpages.Message(Apexpages.Severity.Info, string.valueOf(safetyList.size()) + ' Safety Equipment Inventory Items Added '));
        }catch(Exception e){
          Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'SOQL Insert Error ' + e.getMessage()));
        }
          return p;
 }

     public PageReference AssignInventoryClose(){
            List<Safety_Equipment__c> safetyList = new List<Safety_Equipment__c>();
            Safety_Equipment__c item;
       for(Integer a = Integer.valueOf(assign.Start_Serial_Number__c); a <= Integer.valueOf(assign.End_Serial_Number__c); a++){
            item = new Safety_Equipment__c();
            item.Assigned_Date__c = assign.Assigned_Date__c;
            item.Ball_Shank_Batch__c = assign.Ball_Shank_Batch__c;
            item.Ball_Shank_Die__c = assign.Ball_Shank_Die__c;
            item.Ferule_Batch__c = assign.Ferule_Batch__c;
            item.Ferule_Die__c = assign.Ferule_Die__c;
            item.Manufacture_Date__c = assign.Assigned_Date__c;
            item.Model__c = assign.Model__c;
            item.Serial_Number__c = Integer.valueOf(a);
            item.name = String.valueOf(a);
            item.Status__c = 'Inventory';
            item.Test_Date__c = assign.Test_Date__c;
            item.Test_Results__c = assign.Test_Results__c;
            item.Tested_By__c = assign.Tested_By__c;
            safetyList.add(item);
        }
        if(assign.Comma_Separated_Serial_Numbers__c <> null){      //now lets get the serial numbers seperated by comma   
           List<String> commaSeparatedList = new List<String>();
           commaSeparatedList = assign.Comma_Separated_Serial_Numbers__c.split(',');         
            for(Integer z = 0; z < commaSeparatedList.size(); z++){
             item = new Safety_Equipment__c();
                item.Assigned_Date__c = assign.Assigned_Date__c;
                item.Ball_Shank_Batch__c = assign.Ball_Shank_Batch__c;
                item.Ball_Shank_Die__c = assign.Ball_Shank_Die__c;
                item.Ferule_Batch__c = assign.Ferule_Batch__c;
                item.Ferule_Die__c = assign.Ferule_Die__c;
                item.Manufacture_Date__c = assign.Assigned_Date__c;
                item.Model__c = assign.Model__c;
                item.Serial_Number__c = Integer.valueOf(commaSeparatedList[z]);
                item.name = commaSeparatedList[z];
                item.Status__c = 'Inventory';
                item.Test_Date__c = assign.Test_Date__c;
                item.Test_Results__c = assign.Test_Results__c;
                item.Tested_By__c = assign.Tested_By__c;
                safetyList.add(item);
            } //end for loop
        }  //end if values in the comma separated values field is null    
        
       try{ 
        	insert safetyList;
	    }catch(Exception e){
        PageReference p = Apexpages.Currentpage();
        Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'SOQL Insert Error ' + e.getMessage()));
        return p; 
	    }
      
        Schema.DescribeSObjectResult anySObjectSchema = Safety_Equipment__c.SObjectType.getDescribe();
        String objectIdPrefix = anySObjectSchema.getKeyPrefix();
        PageReference pageReference = new PageReference('/'+objectIdPrefix+'/o');
        pageReference.setRedirect(true);
        return pageReference;
    }

     public PageReference AssignAccount(){
        PageReference p = Apexpages.Currentpage(); //we are always returning to the current page with a variety of messages.
        //there is no account name yet as the relationship does not exist?
         try{
             safetyList=[SELECT Id, Status__c, Assigned_Date__c, Account__c, Serial_Number__c 
                        FROM Safety_Equipment__c  
                        WHERE Serial_Number__c >=:Integer.valueOf(assign.Start_Serial_Number__c) 
                        AND Serial_Number__c <=:Integer.valueOf(assign.End_Serial_Number__c)
                        AND Status__c <> 'Assigned'];
         }catch(Exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Malformed SOQL query.  Error: '+e));
             return p;
        }

          //now work with the comma separated values and add them to the existing safetyList to be updated
          List<Safety_Equipment__c> commaSeparatedList = new List<Safety_Equipment__c>();          
          List<String> aa = new List<String>();
          List<Integer> n = new List<Integer>();

          if(assign.Comma_Separated_Serial_Numbers__c <> null){
            aa = assign.Comma_Separated_Serial_Numbers__c.split(',');
            for (Integer i = 0; i<aa.size();i++){n.add(Integer.valueOf(aa[i]));}

            try{              
              commaSeparatedList = [SELECT Id, Status__c, Assigned_Date__c, Account__c, Serial_Number__c 
                                    FROM Safety_Equipment__c   
                                    WHERE Serial_Number__c IN :n 
                                    AND Status__c <> 'Assigned'];
            }catch(Exception e){
              Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'Malformed SOQL query ' + e.getMessage()));
              return p;            
         }

         safetyList.addAll(commaSeparatedList);

       }
         if(safetyList.size()<>0){
          String aName;
          List<Account> a = [Select id, Name from Account WHERE id =: assign.Account__c];
          if (!a.isEmpty()) {
           aName = a[0].Name;
          }
              
             for(Safety_Equipment__c c: safetyList){
                 c.Status__c = 'Assigned';
                 c.Assigned_Date__c  = assign.Assigned_Date__c;
                 c.Account__c = assign.Account__c;
                 c.Opportunity__c = assign.Opportunity__c;
                 c.Safety_Equipment__c = assign.Safety_Equipment__c;
                 c.Reviewed_By__c  = assign.Reviewed_By__c;                
             }
             try{              
              Apexpages.Addmessage( new Apexpages.Message(Apexpages.Severity.Info, string.valueOf(safetyList.size()) + ' Safety Equipment Items Assigned to ' + aName));
              update safetyList;
            }catch(Exception e){
              Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'Malformed SOQL query ' + e.getMessage()));
              return p;
            }

         }               
            return p;      
    }
     public PageReference AssignAccountClose(){
        PageReference p = Apexpages.Currentpage();
        //query the records in the serial number range to be assigned
        try{
          safetyList=[SELECT Id, Status__c, Assigned_Date__c, Account__c, Serial_Number__c 
                      FROM Safety_Equipment__c  
                      WHERE Serial_Number__c >=: Integer.valueOf(assign.Start_Serial_Number__c) 
                      AND Serial_Number__c <=:Integer.valueOf(assign.End_Serial_Number__c)
                      AND Status__c <> 'Assigned'];

        }catch(Exception e){ //in cases there is an error querying the records            
            Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'SOQL Select - Start and End Serial Numbers Failed - ' + e.getMessage()));
            return p; 
       }
       
       //next collect the records in the Comma Separated List
       if(assign.Comma_Separated_Serial_Numbers__c <> null){
          List<Safety_Equipment__c> commaSeparatedList = new List<Safety_Equipment__c>();          
          List<String> aa = new List<String>();
          List<Integer> n = new List<Integer>();
      
           aa = assign.Comma_Separated_Serial_Numbers__c.split(',');

           //create a list from the comma separated numbers
          for (Integer i = 0; i<aa.size();i++){n.add(Integer.valueOf(aa[i]));}
          
          //perform a query with the list of Comma Separated Numbers
            try{              
              commaSeparatedList = [SELECT Id, Status__c, Assigned_Date__c, Account__c, Serial_Number__c 
                                    FROM Safety_Equipment__c   
                                    WHERE Serial_Number__c 
                                    IN :n
                                    AND Status__c <> 'Assigned'];

            }catch(Exception e){ //in case there is an error with the query
                Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'SOQL Select - Comma Separated Serials Numbers Failed - ' + e.getMessage()));
                return p; 
            }
         //add the comma separated query to the existing safety list   
         safetyList.addAll(commaSeparatedList);
        } //end if comma separated serial numbers

       //if there were any records found in the query, update them
        if(safetyList.size()<>0){
            for(Safety_Equipment__c c: safetyList){
                c.Status__c = 'Assigned';
                c.Assigned_Date__c  = assign.Assigned_Date__c;
                c.Account__c = assign.Account__c;
                c.Opportunity__c = assign.Opportunity__c;
                c.Safety_Equipment__c = assign.Safety_Equipment__c;
                c.Reviewed_By__c  = assign.Reviewed_By__c;    
            } //end for loop updating each item in the safetyList

           try{  
             update safetyList;
           }catch(Exception e){ //if the update fails
             Apexpages.Addmessage( new Apexpages.Message(ApexPages.Severity.Info,'SOQL Update - Safety Equipment Assignment to Account Failed -' + e.getMessage()));
             return p; 
           }
            Schema.DescribeSObjectResult anySObjectSchema = Safety_Equipment__c.SObjectType.getDescribe();
            String objectIdPrefix = anySObjectSchema.getKeyPrefix();
            PageReference pageReference = new PageReference('/'+objectIdPrefix+'/o');
            pageReference.setRedirect(true);
            return pageReference;
               
      
      }else{ //if there is nothing in the list
          Apexpages.Addmessage(new Apexpages.Message(ApexPages.Severity.Info,'No Safety Equipment Iventory Found with Matching Serial Numbers '));
          return p; 
      }        
    }//end AssignAccountClose	

}