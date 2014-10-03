public with sharing class newOpportunityController {

    Account account;
    Contact contact;
    Opportunity opportunity;
    OpportunityContactRole role;
    
    //the next 4 methods return one of each of the 4 member variables.  If this is the first time the method is called it creates an empty 
    //record for the variable
    
    public Account getAccount(){
        if(account==null) account = new Account();      
        return account;
    }
    
    public Contact getContact(){
        if(contact==null) contact = new Contact();
        return contact;
    }
    
    public Opportunity getOpportunity(){
        if(opportunity==null) opportunity = new Opportunity();
        return opportunity;
    }
    
    public OpportunityContactRole getRole(){
        
        if(role==null) role = new OpportunityContactRole();
        return role;
    }
    
     //the next 3 methods control navigation through the wizard.  Note that teh redirect attribute does not need to be set on the PageReference
    //because the url does not need to change when user moves from page top page.
    
   public PageReference step1(){
		return Page.opptyStep1;
	}
	
	public PageReference step2(){
		return Page.opptyStep2;
	}
	
	public PageReference step3(){
		return Page.opptyStep3;
	}
	
	//This method cancels the wizard and returns the user to the opportunities tab
	public PageReference cancel(){
		
		PageReference opportunityPage = new ApexPages.StandardController(opportunity).view();
		opportunityPage.setRedirect(true);
		return opportunityPage;
	}
	
	//This method performs the final save for all 4 objects, and then navigates the user to the detail page of the new opportunity
	public PageReference save(){
		
	//create the account.  Before inserting, copy the contact's phone number into the account phone number field.
	account.phone = contact.phone;
	insert account;
	
	//Create the contact.  Before inserting, use the id field that's created once the account has been inserted to create the relationship 
	//between the contact and the account id	
	contact.accountId = account.id;
	insert contact;
	
	//Create the opportunity. Before inserting, create another relationship with the account.
	opportunity.accountId = account.id;
	insert opportunity;
	
	//Create the junction contact role between the opportunity and the contact.
	role.opportunityId = opportunity.Id;
	role.ContactId= contact.id;
	insert role;
	
	
	//finally send the user top the detail page for the new opportunity
	PageReference opptyPage = new ApexPages.Standardcontroller(opportunity).view();
	opptyPage.setRedirect(true);
	return opptyPage;
	}	
}