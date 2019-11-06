trigger VenueTrigger_2 on Venue__c(after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {

 system.debug('VenueTrigger is firing==>');

	if(trigger.isBefore && trigger.isInsert) {
		for(Venue__c v : trigger.new) {
			
		}
		system.debug('Before insert');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	if(trigger.IsAfter && trigger.isInsert) {
		for(Venue__c v : trigger.new) {
			
		}
		system.debug('After insert');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	
	if(trigger.isBefore && trigger.IsUpdate) {
		for(Venue__c v : trigger.new) {
			
		}
		system.debug('Before update');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	
	if(trigger.IsAfter && trigger.IsUpdate) {
		for(Venue__c v : trigger.new) {
			
		}
		system.debug('After update');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	
	if(trigger.isBefore && trigger.isDelete) {
		for(Venue__c v : trigger.old) {
			
		}
		system.debug('Before Delete');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	
	if(trigger.isAfter && trigger.ISDelete) {
		for(Venue__c v : trigger.old) {
			
		}
		system.debug('After Delete');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	
	if(trigger.IsAfter && trigger.isUndelete) {
		for(Venue__c v : trigger.new) {
			
		}
		system.debug('After Undelete');
		system.debug('Trigger.new==>'+trigger.new);
		system.debug('Trigger.old==>'+trigger.old);
		system.debug('Trigger.newMap==>'+trigger.newMap);
		system.debug('Trigger.oldMap==>'+trigger.OldMap);
		
	}
	
	
}