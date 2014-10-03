@IsTest
private class HelloWorldTestClass{
    static testMethod void validateHelloWorld(){
        Book__c b = new Book__c(Name='Behind the Cloud', Price__c=100);
        System.debug('Price before inserting the book' + b.Price__c);
        
        insert b;        
        
        //retrieve the book        
        b = [SELECT Price__c FROM Book__c where Id =:b.id];
        
        System.debug('Price after the trigger fired: ' + b.Price__c);
        
        //test the trigger updated the price of the book correctly
        System.assertEquals(90, b.Price__c);
    }

}