trigger ContactTrigger on Contact (before insert,before Update) {
    system.debug('Contact trigger is executing==>');
    if(Trigger.isBefore && (Trigger.isInsert || trigger.isUpdate)){
        for(Contact ct : trigger.new) {
            system.debug('Contact trigger is ct.email==>'+ct.email);
            if(ct.email !=null) {
              //  ct.Contact_Email_External__c = ct.email;
                system.debug('Contact trigger is ct.Contact_Email_External__c==>'+ct.Contact_Email_External__c);
            }
        }
    }

}