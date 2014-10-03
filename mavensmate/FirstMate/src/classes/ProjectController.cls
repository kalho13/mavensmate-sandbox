public with sharing class ProjectController {
	
	private Customer_Project__c project;
	private ApexPages.StandardController extendedController {get;set;}
	private Boolean bUpdate = true;
	public string accountId{    get;set;    }
    public string accountName{    get;set;    }
    public string oppId{    get;set;    }
    public string oppName{    get;set;    }
    public List<Opportunity> opp;
    public List<Account> account;
    public double revenue{    get;set;    }
   
	public ProjectController(ApexPages.StandardController stdController){			
		  extendedController = stdController;
          this.project= (Customer_Project__c)extendedController.getRecord();
  
  		//if the project id is null then we are creating a new record and want to pass a view values along
           accountId = System.currentPageReference().getParameters().get('accountId'); 
          if(project.id==null){
          	   accountId = System.currentPageReference().getParameters().get('accountId'); 	                  
	           account = [select Name from Account where Id =: accountId];
	           oppId = System.currentPageReference().getParameters().get('oppId');
	           opp = [select Id, Name from Opportunity where Id =: oppId];
	           revenue = [select ExpectedRevenue from Opportunity where Id =: oppId].ExpectedRevenue;
	           project.Revenue__c=revenue;
	           project.Opportunity__c = opp[0].Id;
	           project.Account__c = account[0].Id;          
          }else{
          		accountId = project.Account__c;
          }
	}
	
	public  List<Course_Detail__c> getCourses(){
		return [select Account__c, Year_Built__c, Model__c, Serial_Number__c from Course_Detail__c where Account__r.Id=:accountId];
	}
	
	public Customer_Project__c getCustomerProject() { return project;} 
	
	
	public PageReference mySave() {	
		PageReference displayProject = Page.project;
		displayProject.setRedirect(true);
		displayProject.getParameters().put('id', project.id);	
		
		if(bUpdate){
			update project;
			return displayProject;
		}else{
			insert project;
			extendedController = new ApexPages.StandardController(project);
		}
		return displayProject;
	}
	

}