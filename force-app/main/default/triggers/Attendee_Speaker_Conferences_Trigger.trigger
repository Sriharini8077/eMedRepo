trigger Attendee_Speaker_Conferences_Trigger on Attendee_Speaker_Conferences__c (before insert,before update) {

/*
    if(trigger.isBefore && trigger.isInsert || trigger.isBefore && trigger.isUpdate){
        Set<Id> conIdSet = new set<ID>();
         for(Attendee_Speaker_Conferences__c acs : trigger.new) {
            if(acs.Contact__c !=null) {
                system.debug('acs.Contact__c.==>'+acs.Contact__c);
                conIdSet.add(acs.Contact__c);
            }
        }
        
        if(conIdSet !=null && conIdSet.size()>0){
            Map<Id,Contact> conMap = new Map<Id,Contact>([select accountId,account.Email__c,account.Person_Account_Type__c from contact where id in : conIdSet]);
            if(conMap !=null && conMap.size()>0){
                for(Attendee_Speaker_Conferences__c acs : trigger.new) {
                    acs.Account__c = conMap.get(acs.Contact__c).accountId;
                    acs.Email__c = conMap.get(acs.Contact__c).account.Email__c;
                    acs.Role_Type__c = conMap.get(acs.Contact__c).account.Person_Account_Type__c;
                }
            }
        }
    }
*/    
}