@IsTest
public class Attendee_Speaker_Conferences_Test {
    
    public static testmethod void testAttnedeeSpeaker(){

/*    
      //  String attendeeRecTypeId= [select Id from RecordType where (Name='Speaker/Attendee') and (SobjectType='Account')].Id;
      //  String organizerRecTypeId= [select Id from RecordType where (Name='Organizer') and (SobjectType='Account')].Id;
        
        Account acc = new Account();
      //  acc.RecordTypeID=attendeeRecTypeId;
      acc.FirstName='Test FName';
      acc.LastName='Test LName';
      acc.PersonMailingStreet='test@yahoo.com';
      acc.PersonMailingPostalCode='12345';
      acc.PersonMailingCity='SFO';
      acc.PersonEmail='test@yahoo.com';
      acc.PersonHomePhone='1234567';
      acc.PersonMobilePhone='12345678';
         acc.Email__c = 'testattendee@google.com';
      insert acc;
        
       Contact con = [select id from contact where accountid=: acc.id];
        system.debug('con id is==>'+con.id);
      Account orgAccount = new Account();
        orgAccount.Email__c = 'test@google.com';
        orgAccount.name = 'test organizer';
        orgAccount.Description= 'test';
        insert orgAccount;
  
        Opportunity opp = new Opportunity();
        opp.name = 'test conf';
        opp.accountid = orgAccount.id;
        opp.CloseDate = system.today()+30;
        opp.StageName = 'prospecting';
        opp.Email__c = 'test@google.com';
        insert opp;
        
        Attendee_Speaker_Conferences__c acss = new Attendee_Speaker_Conferences__c();
        acss.Opportunity__c =opp.id;
        acss.Contact__c  = con.id;
        insert acss;
*/        
  }

}