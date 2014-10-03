public with sharing class MyController{
	
    private final Account account;
    
    public myController(){
        account = [select id, name, site from Account where id = :ApexPages.currentPage().getParameters().get('id')];    
    }
    
    public Account getAccount(){
        return account;
    }
    
    public PageReference save(){
        update account;
        PageReference secondPage = Page.MySecondPage;
        secondPage.setRedirect(true);
        secondPage.getParameters().put('id',account.id);
        return secondPage;
      //  return null;
    }
    
    public PageReference cancel(){
        return null;
    } 
}