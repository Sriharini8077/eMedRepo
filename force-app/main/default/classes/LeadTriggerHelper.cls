public class LeadTriggerHelper {

/*    
    public static Boolean isFirstTime = true;
    
    public static void createChildContactsofLead(Lead leadRec) {
        system.debug('createChildContactsofLead is calling==>');
        if( leadRec !=null && leadRec.IsConverted ==true){
            Map<String,Contact>  existingContactMap = new MAp<String,Contact>();
            Map<String,Contact> contactlistNew = new Map<String,Contact>();
            List<Contact> contactlistNew2 = new List<Contact>();
            Map<String,Boolean> emailids = new Map<String, Boolean>();
            Map<String,OpportunityContactRole> oppConRole = new Map<String,OpportunityContactRole>();
           
            
            if(leadRec.Is_Contact_1_Used_For_Opportunity__c && leadRec.Email !=null )
                emailids.put(leadRec.Email,leadRec.Is_Contact_1_Used_For_Opportunity__c);
            if(leadRec.Is_Contact_2_Used_For_Opportunity__c && leadRec.Contact_2_Email__c !=null )
                emailids.put(leadRec.Contact_2_Email__c,leadRec.Is_Contact_2_Used_For_Opportunity__c);
            if(leadRec.IS_Contact_3_Used_in_Opportunity__c && leadRec.Contact_2_Email__c !=null )
                emailids.put(leadRec.Contact_3_Email__c,leadRec.IS_Contact_3_Used_in_Opportunity__c);
            system.debug('emailids==>'+emailids);
            
            //checking for existing contacts
            existingContactMap = checkForAccountRelatedContacts (emailids.keySet(),leadRec.ConvertedAccountId);
           
        //    if(leadRec.ConvertedContactId !=null) {
        //       updateConvertedContact(leadRec.ConvertedAccountId,leadRec.Conference_Contact_Designation__c,leadRec.FirstName,leadRec.LastName,leadRec.Email,leadRec.Phone,leadRec.Conference_Contact_Facebook__c,leadRec.Conference_Contact_Liinked_In__c,leadRec.Conference_Contact_Twitter__c,leadRec.Conference_Contact_Google_Plus__c,leadRec.ConvertedContactId);
        //    }else{
        //        contactlistNew.put(leadRec.Email, prepareContact(leadRec.ConvertedAccountId,leadRec.Conference_Contact_Designation__c, leadRec.FirstName,leadRec.LastName,leadRec.Email,leadRec.Phone,leadRec.Conference_Contact_Facebook__c,leadRec.Conference_Contact_Liinked_In__c,leadRec.Conference_Contact_Twitter__c,leadRec.Conference_Contact_Google_Plus__c));
        //    }
            
            if(leadRec.Contact_2_Email__c !=null && leadRec.Is_Contact_2_Used_For_Opportunity__c && existingContactMap.containsKey(leadRec.Contact_2_Email__c)) {
                contactlistNew.put(leadRec.Contact_2_Email__c,existingContactMap.get(leadRec.Contact_2_Email__c));
            }else if(leadRec.Contact_2_Email__c !=null && leadRec.Is_Contact_2_Used_For_Opportunity__c && !existingContactMap.containsKey(leadRec.Contact_2_Email__c)){
                contactlistNew.put(leadRec.Contact_2_Email__c, prepareContact(leadRec.ConvertedAccountId,leadRec.Contact_2_Designation__c, leadRec.Contact_2_First_Name__c,leadRec.Contact_2_Last_Name__c,leadRec.Contact_2_Email__c,leadRec.Contact_2_Phone__c,leadRec.Contact_2_Facebook__c,leadRec.Contact_2_Linked_In__c,leadRec.Contact_2_Twitter__c,leadRec.Contact_2_Google_Plus__c));
            }
            
            //3rd contact checking..
             if(leadRec.Contact_3_Email__c !=null && leadRec.IS_Contact_3_Used_in_Opportunity__c && existingContactMap.containsKey(leadRec.Contact_3_Email__c)) {
                contactlistNew.put(leadRec.Contact_3_Email__c, existingContactMap.get(leadRec.Contact_3_Email__c) ); 
             }else if(leadRec.Contact_3_Email__c !=null && leadRec.IS_Contact_3_Used_in_Opportunity__c && !existingContactMap.containsKey(leadRec.Contact_3_Email__c)){
                 contactlistNew.put(leadRec.Contact_3_Email__c, prepareContact(leadRec.ConvertedAccountId,leadRec.Contact_3_Designation__c,leadRec.Contact_3_First_Name__c,leadRec.Contact_3_Last_Name__c,leadRec.Contact_3_Email__c,leadRec.Contact_3_Phone__c,leadRec.Contact_3_Facebook__c,leadRec.Contact_3_Liinked_In__c,leadRec.Contact_3_Twitter__c,leadRec.Contact_3_Google_Plus__c));
             }
            
            //contactlistNew.put(leadRec.Email, prepareContact(leadRec.ConvertedAccountId, leadRec.FirstName,leadRec.LastName,leadRec.Email,leadRec.Phone,leadRec.Conference_Contact_Facebook__c,leadRec.Conference_Contact_Liinked_In__c,leadRec.Conference_Contact_Twitter__c,leadRec.Conference_Contact_Google_Plus__c,leadRec.ConvertedContactId));
            
            
            if(contactlistNew.containsKey(null)){
                contactlistNew.remove(null);
            }
            
            system.debug('before inserting Contact list details ==>'+contactlistNew);
            if(contactlistNew !=null && contactlistNew.size()>0){
                contactlistNew2 = contactlistNew.values(); 
                upsert contactlistNew2; 
                
                 system.debug('after inserting Contact list details ==>'+contactlistNew2.size());
                 system.debug('leadRec.ConvertedOpportunityId==>'+leadRec.ConvertedOpportunityId);
                
                if(leadRec.ConvertedOpportunityId !=null){
                  for(Contact contactR : contactlistNew2) {
                      if(emailids.containsKey(contactR.Email)){
                          if(emailids.get(contactR.Email) ==true && contactR.Email !=leadRec.Email){
                                    OpportunityContactRole oppr2 = new OpportunityContactRole();
                                    oppr2.ContactId = contactR.id;
                                    oppr2.OpportunityId = leadRec.ConvertedOpportunityId;
                                    oppr2.Role = 'Business User';
                                    oppConRole.put(oppr2.ContactId,oppr2);
                                }
                          
                      }
                      
                  }
                    
                }
                
                system.debug('Before inserting oppconrole size is==>'+oppConRole.size());
                if(oppConRole !=null && oppConRole.size()>0){
                    insert oppConRole.values();
                   
                }
            }
            
        }
        
    }
    
    
    
    
    
    public static contact prepareContact(String AccountID,String designation, String firstName, String lastName, String email,String phone,String facebookURL,String linkedInURL,String twitterURL,String googlePlusURL) {
        Contact cont = new Contact();
        cont.AccountID = AccountID;
        cont.Email = Email;
        cont.Designation__c = designation;
        cont.FirstName = firstName;
        cont.LastName = lastName;
        cont.Phone = phone;
      //  cont.Contact_Email_External__c = cont.Email;
        cont.Facebook_Page__c = facebookURL;
        cont.Linkedin_Page__c = linkedInURL;
        cont.Twitter_Page__c = twitterURL;
        cont.Google_Plus_Page__c = googlePlusURL;
        cont.Designation__c = designation;
        return cont;
        
    }
   
    public static void changeRecordOwners(Lead leadRec) {
        
        List<Group> QueueID = [select Id,Name,developerName from  Group where developerName='Leads_After_Converted_Queue' and Type = 'Queue' Limit 1];
        system.debug('size==>'+QueueID.size());
        Lead leadNew = new Lead();
        leadNew.id=leadRec.id;
        leadNew.Before_Converting_Owner__c= leadRec.ownerID;
        leadNew.ownerID = QueueID.get(0).id;
        update leadNew;
        system.debug('leadNew is==>'+leadNew);
        
        
    } 
    
    public static map<String,Contact> checkForAccountRelatedContacts(Set<String> emailIdSet,String AccountId){
        Map<String,Contact>  existingContactMap = new MAp<String,Contact>();        
        List<Contact> conlist = [select id,AccountID,Designation__c,Email,FirstName,LastName,Phone,
                             Contact_Email_External__c,Facebook_Page__c,Linkedin_Page__c,Twitter_Page__c,Google_Plus_Page__c from Contact where email IN :emailIdSet and accountId=:AccountId];
  
        
        if(conlist !=null && conlist.size()>0){
            for(Contact con: conlist){
                existingContactMap.put(con.email,con);
            }
        }
        return existingContactMap;
    }
    
    
    public static void updateConferencName(lead leadRec){
        if(leadRec.ConvertedOpportunityId !=null ){
            Opportunity oppRec = [select id,Opportunity_Sales_Rep__c,Name from opportunity where id=:leadRec.ConvertedOpportunityId limit 1];
            oppRec.Name = leadRec.Conference_Name__c;
            opprec.Opportunity_Sales_Rep__c = leadRec.ownerID;
            update oppRec;
        }
    }
    
    
    public static void assignLeadOwnerID(list <lead> triggerNew) {
        Map<String,String> userMap = new Map<String,String>();
        List<User> userList = [select id,FirstName,LastName,email from user where isActive=:true];
        if(userList !=null && userList.size()>0) {
            for(User u: userList) {
                userMap.put(u.email, u.id);
            }
        }
        
        for(Lead leadRec:triggerNew){
            if(userMap.containsKey(leadRec.Sales_Rep_Email__c)){
                leadRec.OwnerId = userMap.get(leadRec.Sales_Rep_Email__c);
            }
            if(leadRec.LastName ==null || leadRec.LastName == ''){
                leadRec.LastName = leadRec.Company;
            }
        }
    }
*/    

    /*
    public static void updateConvertedContact(String AccountID, String designattion,String firstName, String lastName, String email,String phone,String facebookURL,String linkedInURL,String twitterURL,String googlePlusURL,String contactID) {
       List<Contact> contList = [select id,AccountID,Designation__c,Email,FirstName,LastName,Phone,
                             Contact_Email_External__c,Facebook_Page__c,Linkedin_Page__c,Twitter_Page__c,Google_Plus_Page__c from Contact where id=:contactID limit 1];
        contact cont = contList.get(0); 
        cont.AccountID = AccountID;
        cont.Designation__c = designattion;
        cont.Email = Email;
        cont.FirstName = firstName;
        cont.LastName = lastName;
        cont.Phone = phone;
        cont.Contact_Email_External__c = cont.Email;
        cont.Facebook_Page__c = facebookURL;
        cont.Linkedin_Page__c = linkedInURL;
        cont.Twitter_Page__c = twitterURL;
        cont.Google_Plus_Page__c = googlePlusURL;
        
        update cont;
        
    }
    */


}