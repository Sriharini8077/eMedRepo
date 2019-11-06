/**

 */
@isTest
private class VenueTrigger_Test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        Venue__c ven = new Venue__c();
        ven.Name = 'Srinvias';
        ven.city__C = 'Hyderabad';
        //ven.CurrencyIsoCode = 'USD.USDoolar';
        insert ven;
        
        ven.Email__c = 'Srinvias@gmail.com';
        update ven;
        
        delete ven;
        
        undelete ven;
    }
}