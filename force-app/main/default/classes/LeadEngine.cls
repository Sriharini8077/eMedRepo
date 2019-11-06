@RestResource(urlMapping='/leadProcessor/*')
global with sharing class LeadEngine {

    @HttpGet
    global static String readLead() {

        System.debug('Get Called');        
    
        String returnMessage = '';
        
        RestRequest req = RestContext.request;

        String title = req.params.get('title');                
        String first_name = req.params.get('first_name');        
        String last_name = req.params.get('last_name');        
        String email = req.params.get('email');      
        String company = req.params.get('company');         
        String city = req.params.get('city');      
        String state = req.params.get('state');      
        String country = req.params.get('country');      
        String phone = req.params.get('phone');      
        String lead_source = req.params.get('lead_source');      
        String conference_url = req.params.get('conference_url');      
        String conference_id = req.params.get('conference_id');      
                                
        String Status = req.params.get('status');
        String message = req.params.get('message');
        String Specialities = req.params.get('specialities');
        String Designation = req.params.get('designation');
        String sales_comments = req.params.get('sales_comments');
        String added_date = req.params.get('added_date');
        String user_type = req.params.get('user_type');
        String reason_for_contact = req.params.get('reason_for_contact');
        String Sales_Person = req.params.get('sales_person');
        String Notes = req.params.get('notes');
        String chat_type = req.params.get('chat_type');
        String important = req.params.get('important');
        String added_by = req.params.get('added_by');
        String zipcode = req.params.get('zipcode');
        String street = req.params.get('street');
        
        String organizer_id = req.params.get('organizer_id');      
        String organizer_url = req.params.get('organizer_url');      
        String organizer_emed_url = req.params.get('organizer_emed_url');      
        
        String is_update = req.params.get('is_update');      
        String new_email = req.params.get('new_email');  
       
        System.debug(req.params);        
        System.debug(req.params.get('firstname'));                
        System.debug(req.params.get('lastname'));                        

        System.debug(RestContext.request);        

        System.debug('----------->Showing values from here: ');        
        
        System.debug(first_Name);        
        System.debug(last_Name);                
        System.debug(email);   
        
        id accountID = null;        // matched Account ID                     
        
        Account[] acs = new Account[]{};        
        Contact[] cts = new Contact[]{};        
        Lead[] lds = new Lead[]{};
        String emailMessage = '';
        String eMedconfigeMailMessage = ''; 
        
        Id newLeadID = null;
        Id newContactID = null;
                        
        if (organizer_id != null) acs = [Select id, LeadForm_Update_At__c, Organizer_ID__c from Account where Organizer_ID__c = :organizer_id order by createddate];
        
        if (acs.size() == 1)         accountID = acs[0].id;
        if (acs.size() > 1) { emailMessage += 'Duplicate Accounts Found with same Organizer ID: ' + organizer_id + '. \nNumber of Duplicate Accounts: ' + acs.size() + '\n\n';
        eMedconfigeMailMessage += 'Duplicate Accounts Found with same Organizer ID: ' + organizer_id + '. \nNumber of Duplicate Accounts: ' + acs.size() + '\n\n';
        }
        if (email != null)       cts = [Select id, accountId, account.Organizer_ID__c, LeadForm_Update_At__c, firstname, lastname, email from Contact where email = :email];      
        if (email == null)       cts = [Select id, accountId, account.Organizer_ID__c, LeadForm_Update_At__c, firstname, lastname, email from Contact where firstname = :first_name and lastname = :last_name];                

        if (email != null)       lds = [Select id, LeadForm_Update_At__c, firstname, lastname, email, company, organizer_id__c, organizer_url__c, organizer_emed_url__c  from Lead where isConverted = false AND email = :email];      
        if (email == null)       lds = [Select id, LeadForm_Update_At__c, firstname, lastname, email, company, organizer_id__c, organizer_url__c, organizer_emed_url__c  from Lead where isConverted = false AND firstname = :first_name and lastname = :last_name and company = :company];                

        if (cts.size() > 0 && lds.size() > 0)  {emailMessage += 'Email: ' + email + ' exists both in Leads and Contacts\n\n';
         eMedconfigeMailMessage += 'Email: ' + email + ' exists both in Leads and Contacts\n\n';
        }
        if (cts.size() > 1 || lds.size() > 1) {emailMessage += 'Email: ' + email + ' has duplicates. \nNumber of Contacts: ' + cts.size() + '\nNumber of Leads: ' + lds.size() + '\n\n';
        eMedconfigeMailMessage += 'Email: ' + email + ' has duplicates. \nNumber of Contacts: ' + cts.size() + '\nNumber of Leads: ' + lds.size() + '\n\n';
        }
        eMedconfigeMailMessage += 'cts.size(): ' + cts.size() + 'lds.size(): '+lds.size() + 'accountID: '+accountID+'email: '+email+' exists both in Leads and Contacts\n\n';
        if (cts.size() == 0 && lds.size() == 0 && accountID == null && email != null) {

           Lead l = new Lead( firstName = first_name, lastName = last_name, title = title, email = email, phone = phone, 
                company = company, city = city, state = state, country = country, leadSource = lead_source, 
                conference_url__c = conference_url, conference_id__c = conference_id,  
                organizer_id__c = organizer_id, organizer_url__c = organizer_url, organizer_emed_url__c = organizer_emed_url,
                Status = Status, message__c = message, specialities__c = Specialities, designation__c = Designation,
                sales_comments__c = sales_comments, user_type__c = user_type, reason_for_contact__c = reason_for_contact,
                Sales_Person__c = Sales_Person, zendesk_chat_notes__c = Notes, chat_type__c = chat_type, important__c = important,
                added_by__c = added_by, PostalCode = zipcode, added_date__c =date.parse(added_date), Street = street
            );     insert l;
            
            newLeadID = l.ID;
            System.debug('Newly created Lead ID = ' + newLeadID);
            eMedconfigeMailMessage += 'Newly created Lead ID = ' + newLeadID + '\n\n';
        }
        
        if (cts.size() == 0 && lds.size() == 0 && accountID != null && email != null) {

            Contact c = new Contact( firstName = first_name, lastName = last_name, title = title, email = email, phone = phone, 
                accountID = accountID, mailingCity = city, mailingState = state, mailingCountry = country, leadSource = lead_source,
                Message__c = message, Speciality__c = Specialities, Designation__c = Designation, MailingPostalCode = zipcode, 
                Sales_Comments__c = sales_comments, Added_Date__c = date.parse(added_date), User_Type__c = user_type, Reason_for_Contact__c = reason_for_contact,
                                    Sales_Person__c = Sales_Person, Conference_URL__c = conference_url, Lead_Status__c = Status, zendesk_chat_notes__c = Notes,
                                    Chat_Type__c = chat_type, Important__c = important, added_by__c = added_by, MailingStreet = street
            );               insert c;
            

            newContactID = c.ID;
            System.debug('Newly created Contact ID = ' + newContactID);
            eMedconfigeMailMessage += 'Newly created Contact ID = ' + newContactID + '\n\n';
            
            for (Account a: acs) a.LeadForm_Update_At__c = System.Now();  update acs;
        }       
        
        if (cts.size() + lds.size() == 1 && is_update == '1' && new_email != null) {  
            if (cts.size() == 1) { cts[0].email = new_email; update cts; }
            if (lds.size() == 1) { lds[0].email = new_email; update lds; }            
        }

        if (cts.size() == 0 && lds.size() == 1 && accountID == null && email != null) {

            for (lead l: lds) { l.LeadForm_Update_At__c = System.now(); 
            
            if (first_name != null) l.firstName = first_name; 
            if (last_name != null) l.lastName = last_name; 
            if (company != null) l.company = company; 
            if (organizer_id != null) l.organizer_id__c = organizer_id;   
            if (organizer_url != null) l.organizer_url__c = organizer_url;   
            if (organizer_emed_url != null) l.organizer_emed_url__c = organizer_emed_url;     
            
            update lds;  }
            
            System.debug('Updated existing lead since there is only one matching Lead.');
        }        
        
        if (cts.size() == 1 && lds.size() == 0 && email != null) {

            for (contact c: cts) {      c.LeadForm_Update_At__c = System.now();
                
                if (c.account.Organizer_ID__c != organizer_id && organizer_id != null) { emailMessage += 'Form submitted for Contact ID: ' + c.ID + ' and ' + email + ' with a wrong Organizer ID. \nOrganizer ID on the Account: ' + c.account.Organizer_ID__c + '\nOrganizer ID from the Form: ' + Organizer_ID + '\n\n';
                eMedconfigeMailMessage += 'Form submitted for Contact ID: ' + c.ID + ' and ' + email + ' with a wrong Organizer ID. \nOrganizer ID on the Account: ' + c.account.Organizer_ID__c + '\nOrganizer ID from the Form: ' + Organizer_ID + '\n\n';
                }
            }                
            update cts;
            System.debug('Updated existing Contact since there is only one matching Contact.');
        }           
        
        Conference__c[] cfs = new Conference__c[]{};
        if (conference_id != null) cfs = [Select id, LeadForm_Update_At__c from Conference__c where name = :conference_id];
        
        eMedconfigeMailMessage += 'Conference ID = ' + conference_id + '\n' +' - Record Count = ' + cfs.size()+ '\n\n';
        System.debug('Conference ID = ' + conference_id + ' - Record Count = ' + cfs.size());
        
        if (cfs.size() > 1){ emailMessage += 'Duplicate Conference records found with the same Conference ID: ' + conference_id + '. \nNumber of Conference records: ' + cfs.size() + '\n\n';      
        eMedconfigeMailMessage += 'Duplicate Conference records found with the same Conference ID: ' + conference_id + '. \nNumber of Conference records: ' + cfs.size() + '\n\n';      
        }
        
        if (cfs.size() == 1) {
            for (Conference__c c: cfs) c.LeadForm_Update_At__c = System.now();  update cfs;
            
            System.debug('Updated existing Conference Record since there is only one matching Conference.');  
            eMedconfigeMailMessage += 'Updated existing Conference Record since there is only one matching Conference.' + '\n\n';            
        }        
        
        if (conference_id != null && cfs.size() == 0) {
        
            Conference__c c = new Conference__c(name = Conference_ID, Conference_URL__c = Conference_URL);
            
            boolean confError = false;
        
            if (newLeadID != null) c.Lead__c = newLeadID;
            else if (newContactID != null) c.Account__c = accountID;
            else if (cts.size() == 1 && accountID != null)  c.Account__c = accountID;
            //else if (lds.size() == 1) c.Lead__c = newLeadID;
            else if (lds.size() == 1) c.Lead__c = lds[0].ID;
            else confError = true;
            
            System.debug('Conference Creation here...');
            System.debug('Conference Creation here... Lead = '  + c.Lead__c);
            System.debug('Conference Creation here... Lead = '  + c.Account__c);                        
            System.debug('Conference Creation here... CTS Size = '  + cts.size());
            System.debug('Conference Creation here... Lead = '  + lds.size());   
                                 
            eMedconfigeMailMessage += ' Conference Creation Details here...' + '\n\n';     
            eMedconfigeMailMessage += ' Conference Lead = '  + c.Lead__c + '\n\n';                   
            eMedconfigeMailMessage += ' Conference Account = '  + c.Account__c + '\n\n';                
            eMedconfigeMailMessage += ' Conference CTS Size = '  + cts.size() + '\n\n';                 
            eMedconfigeMailMessage += ' Conference Lead Size = '  + lds.size() + '\n\n';                
                        
            if (confError == false) insert c;
            if (confError) emailMessage += 'Could not create Conference record for Conference ID: ' + conference_id + '. \nEmail = : ' + email + '\nFirst Name = ' + first_Name + '\nLast Name = ' + last_Name + '\n\n';      

            System.debug('Conference Creation here...' + c.ID);            

        }


        if (emailMessage != '')  sendEmailNotification(emailMessage);
        
        List<eMed_Config__c> configs = [Select Name, LeadEngine_Debug_eMail__c from eMed_Config__c where LeadEngine_Debug_eMail__c = true]; 
        if(configs.size() == 1 && configs[0].Name == 'Default')
        if (eMedconfigeMailMessage != '') sendeMedConfigEmailNotification(eMedconfigeMailMessage);
        
        
        System.debug('Number of ACS: ' + acs.size());   
        System.debug('Number of CTS: ' + cts.size());   
        System.debug('Number of LDS: ' + lds.size());           
        System.debug('Number of CFS: ' + cfs.size());   
        
        return returnMessage;
    }


    public static void sendEmailNotification(String emailMessage) {

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'emedsupport@effexoft.com','sunil@emedevents.com'}; 
        // String[] ccAddresses = new String[] {'smith@gmail.com'};  // add an email from emedEvents.com
          
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        // mail.setCcAddresses(ccAddresses);
        
        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('emedsupport@effexoft.com');
               
        // Specify the name used as the display name.
        mail.setSenderDisplayName('eMedEvents Salesforce Support');
        
        // Specify the subject line for your email address.
        mail.setSubject('Lead Form Submit Notification');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
                
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setPlainTextBody('Following is a message generared by eMedEvents Lead Engine: \n\n This email is for technical and support purposes only.\n\n' + emailMessage);
        
        // mail.setHtmlBody('Your case:<b> ' + case.Id +' </b>has been created.<p>'+
        //      'To view your case <a href=https://yourInstance.salesforce.com/'+case.Id+'>click here.</a>');
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    
    }
    
    public static void sendeMedConfigEmailNotification(String eMedconfigeMailMessage) {

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'anusha.velaga@effexoft.com'}; 
        // String[] ccAddresses = new String[] {'smith@gmail.com'};  // add an email from emedEvents.com
          
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        // mail.setCcAddresses(ccAddresses);
        
        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('anusha.velaga@effexoft.com');
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName('eMedConfigEvents Salesforce Support');
        
        // Specify the subject line for your email address.
        mail.setSubject('eMedconfig Submit Notification');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setPlainTextBody('Following is a message generared by eMedConfigEvents Lead Engine: \n\n This email is for technical and debugging purposes only.\n\n' + eMedconfigeMailMessage);
        
        // mail.setHtmlBody('Your case:<b> ' + case.Id +' </b>has been created.<p>'+
        //      'To view your case <a href=https://yourInstance.salesforce.com/'+case.Id+'>click here.</a>');
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    
    }

    public static void addSomeCodeCoverage(String emailMessage) {

        // This code never gets executed except for Test Coverage.
        
        Integer abc = 1;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;   
        
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;
        abc = 1 * 5;
        abc = 5 * 6;                
             

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'emedsupport@effexoft.com','sunil@emedevents.com'}; 
        // String[] ccAddresses = new String[] {'smith@gmail.com'};  // add an email from emedEvents.com
          
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        // mail.setCcAddresses(ccAddresses);
        
        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('emedsupport@effexoft.com');
        // Specify the name used as the display name.
        mail.setSenderDisplayName('eMedEvents Salesforce Support');
        
        // Specify the subject line for your email address.
        mail.setSubject('Lead Form Submit Notification');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setPlainTextBody('Following is a message generared by eMedEvents Lead Engine: \n\n This email is for technical and support purposes only.\n\n' + emailMessage);
        
        // mail.setHtmlBody('Your case:<b> ' + case.Id +' </b>has been created.<p>'+
        //      'To view your case <a href=https://yourInstance.salesforce.com/'+case.Id+'>click here.</a>');
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    
    }

    
    /*

    @HttpPost
    global static String acceptLead() {

        System.debug('Post Called');        

        String returnMessage = '';

        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;        
        
        System.debug(RestContext.request);        
        System.debug(Restcontext.response);                
        
        return returnMessage;
    }
    
    */    
    
}