trigger LeadTrigger on Lead (before insert, before update,after update) {
     
    
    if(trigger.isBefore && trigger.isInsert) {
        LeadTriggerHelper.assignLeadOwnerID(trigger.new);
    }
    
    if(trigger.isUpdate && trigger.isAfter &&  LeadTriggerHelper.isFirstTime){
       
        if(trigger.new.size()==1) {
             LeadTriggerHelper.isFirstTime = false;
            for(Lead leadrec:System.Trigger.new) {
                system.debug('leadrec.IsConverted ==>'+leadrec.IsConverted);
                system.debug('leadrec.ConvertedAccountId ==>'+leadrec.ConvertedAccountId);
                system.debug('leadrec.ConvertedContactId ==>'+leadrec.ConvertedContactId);
                system.debug('leadrec.ConvertedOpportunityId ==>'+leadrec.ConvertedOpportunityId);
                if (leadrec.IsConverted) {
                    LeadTriggerHelper.createChildContactsofLead(leadrec);
                    LeadTriggerHelper.changeRecordOwners(leadrec);
                    if(leadrec.ConvertedOpportunityId !=null){
                        LeadTriggerHelper.updateConferencName(leadrec);
                    }
                }
                //  system.debug('Lead record is ==>'+lead);
            }
            
        }
        
        
    }
    
    
}