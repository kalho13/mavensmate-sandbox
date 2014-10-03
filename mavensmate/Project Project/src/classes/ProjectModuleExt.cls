public with sharing class ProjectModuleExt {

    
    Apexpages.StandardController stdController;

    public ProjectModuleExt(ApexPages.StandardController stdController) {
        this.stdController = stdController;
     
    }

    public PageReference doCancel(){
        Project_Module__c m = (Project_Module__c)stdController.getRecord();
        PageReference pageRef = new PageReference('/' + m.Opportunity__c);
         return pageRef;
        //return stdController.cancel();
    }


    public PageReference doSave(){
        Project_Module__c m = (Project_Module__c)stdController.getRecord();
        PageReference pageRef = new PageReference('/' + m.Opportunity__c);
        m.Name = m.Module_Type__c;
        stdController.save();
        return pageRef;
        //return stdController.cancel();
    }
 
    /*
    ApexPages.standardController m_sc = null;

    public ProjectModuleExt(ApexPages.standardController sc){
         m_sc = sc;
    }

     public PageReference doCancel() {
        PageReference pageRef = new PageReference('/' + m_sc[0].Opportunity__c);
        return pageRef;
        //return m_sc.cancel();
     }
*/
     /*
PageReference pageRef = new PageReference('/' + oppMetrics[0].Opportunity__c);
return pageRef;
     */

     /*
    public PageReference save() {
         Project_Module__c m = (Project_Module__c)stdController.getRecord();
         m.Name = m.Module_Type__c;

         //set default values here if they are null?
         if(m.Small__c==null){m.Small__c=0;}
         if(m.Medium__c==null){m.Medium__c=0;}
         if(m.Large__c==null){m.Large__c=0;}
         if(m.Capacity__c==null){m.Capacity__c=0;}

        return stdController.save();     
    }   
 */
}