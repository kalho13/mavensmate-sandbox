public class MyPageController {

public List<ResourceWrapper> resources{get;set;}

public MyPageController(){
    resources = new List<ResourceWrapper>();
    List<Resource__c> records = [SELECT Name from Resource__c];
    for(Resource__c record:records){
    resources.add(new ResourceWrapper(record));
    }
}

    public PageReference doSomething(){
        for(ResourceWrapper wrapper:resources){
            if(wrapper.selected){
            System.debug(wrapper.data.id);
            }
        }
        return null;
    }


    class ResourceWrapper{
        public Resource__c data{ get; private set;}
        public Boolean selected{ get; set; }
        
        public ResourceWrapper(Resource__c data){
            this.data = data;
            this.selected = false;
        }
    }
    
}