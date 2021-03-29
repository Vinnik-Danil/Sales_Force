trigger WeatherTrigger on Weather__c (before insert, after insert, before update, after update, before delete, after delete) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            WeatherTriggerHandler.handleBeforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            WeatherTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.old);
        }
        if(Trigger.isDelete){
            WeatherTriggerHandler.handleBeforeDelete(Trigger.old);
        }
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            WeatherTriggerHandler.handleAfterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            WeatherTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.old);
        }
        if(Trigger.isDelete){
            WeatherTriggerHandler.handleAfterDelete(Trigger.old);
        }
    }
}