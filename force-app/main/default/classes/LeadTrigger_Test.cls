@isTest 
private class LeadTrigger_Test {

    static testMethod void leadTriggerTest() {

        String title = 'Title';                
        String first_name = 'first_name';        
        String last_name = 'last_name';        
        String email = 'email@emailwithDomain.com';      
        String company = 'company';         

        String city = 'city';      
        String state = 'state';      
        String country = 'country';      
        String phone = 'phone';      
        String lead_source = 'lead_source';      
        

        Lead l = new Lead( firstName = first_name, lastName = last_name, title = title, email = email, phone = phone, 
                company = company, city = city, state = state, country = country, leadSource = lead_source            
            );     insert l;

        Conference__c c = new Conference__c(lead__c = l.Id);
        insert c;
        
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(l.id);
        lc.setDoNotCreateOpportunity(true);
        lc.setConvertedStatus('Qualified');
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());        

    }        

/*     

     @testSetup static void setup() {
     
        // Create common test accounts
        List<Lead> testLeads = new List<Lead>();
        for(Integer i=0;i<2;i++) {
           Lead ld = new Lead();
           ld.Company= 'Test Lead'+i;
           ld.LeadSource ='Advertisement';
           ld.Industry = 'Health Care';
           ld.Rating = 'Hot';
           ld.Sales_Rep_Email__c = 'priya@emedevents.com';
           ld.Sales_Rep_First_Name__c = 'test';
           ld.Sales_Rep_Last_Name__c = 'test';
            
           ld.Conference_Name__c = 'Test conf';
           ld.Conference_Type__c  = 'test type';
           ld.Cme_Heading__c = 'test heading';
           ld.Cme_Points__c = 232;
           ld.Conference_Fee__c = 34343;
           ld.Currency_Code__c = 'USA';
           ld.Conference_Start_Date__c = system.today()+10;
           ld.Conference_End_Date__c  = system.today()+100;
           ld.Conference_URL__c = 'www.google.com';
           ld.Conference_Street__c = 'test Street';
           ld.Conference_State__c = 'test state';
           ld.Conference_City__c = 'test city';
           ld.Conference_Country__c = 'test country';
           ld.Conference_Zip__c = '23423';
          ld.Conference_Specialties__c = 'heart';
            
          //conference details
          ld.Conference_Name__c = 'Test Conference'+i;
          ld.Conference_Type__c='Test type'+i;
          ld.FirstName = 'test';
          ld.LastName ='test'+i;
          ld.Status='Open';
          ld.phone='40490358858';
          ld.Email= generateRandomString(15)+'@gmail.com';
          ld.Is_Contact_1_Used_For_Opportunity__c = true;
            
          //conference 2 contact
          ld.Contact_2_First_Name__c ='test';
          ld.Contact_2_Last_Name__c='Conference2 Contact';
          ld.Contact_2_Email__c = generateRandomString(15)+'@gmail.com';
          ld.Contact_2_Phone__c = '47887887888';
          ld.Is_Contact_2_Used_For_Opportunity__c=true;
          
          //conference contact 3
          ld.Contact_3_First_Name__c ='test';
          ld.Contact_3_Last_Name__c='Conference3 Contact';
          ld.Contact_3_Email__c = generateRandomString(15)+'@gmail.com';
          ld.Contact_3_Phone__c = '478878878888';
          ld.IS_Contact_3_Used_in_Opportunity__c =true;
          testLeads.add(ld);
        }
        insert testLeads;        
 
    }
*/      
/*         
     @isTest static void testMethod1() {
     

        List<Lead> leadRecs = [select id,Name,firstName,LastName,IsConverted from lead];
         system.debug('leadRecs count is==>'+leadRecs.size());
         Lead myLead = leadRecs.get(0);
         
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(myLead.id);
        
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
         
         lc.setDoNotCreateOpportunity(FALSE); 
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
         
         lc.setDoNotCreateOpportunity(false);
         
        List<Account> acclist = [select id,Name from Account];
        system.assertEquals(1,acclist.size());
        List<Contact> conList = [select id,Name,email,Contact_Email_External__c from contact where AccountID =:acclist.get(0).id];
        system.debug('Cotnact list size is==>'+conList.size());
         for(Contact con: conList) {
             system.debug('contact Email =='+con.email+'===CContact External email is==>'+con.Contact_Email_External__c);
         }  
       
         
         List<OpportunityContactRole> oppConRole = [select id,ContactId,OpportunityID,IsPrimary,Role from OpportunityContactRole];
         for(OpportunityContactRole oppr:oppConRole){
             system.debug('oppr==>'+oppr);
         }
  
     }
*/       
    
/*    
    public static String generateRandomString(Integer len) {
    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
    String randStr = '';
    while (randStr.length() < len) {
       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
       randStr += chars.substring(idx, idx+1);
    }
    return randStr; 
 
}
*/   
    
}