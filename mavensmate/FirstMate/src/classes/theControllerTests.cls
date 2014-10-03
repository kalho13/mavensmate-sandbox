public class theControllerTests{

    public static testMethod void testMyController(){
        PageReference pageRef = Page.success;
        Test.setCurrentPage(pageRef);
        
        thecontroller controller = new thecontroller();
        String nextPage;
        
        nextPage = controller.save().getUrl();
       // System.out.println('nextPageURL######### ' + nextPage);
       
        //verify the page fails without parameters
       // System.asertEquals('/apex/failure?error=noParam', nextPage);
        
        //add parameters to page URL
        ApexPages.currentPage().getParameters().put('qp', 'yyyy');
        
        controller = new thecontroller();
        controller.setLastName('lastname');
        controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        nextPage = controller.save().getUrl();
        
        System.assertEquals('/apex/success',nextPage);
        Lead[] leads = [select id, email from lead where Company='acme'];
        System.assertEquals('firstlast@acme.com', leads[0].email);
     
        
    }


}