trigger CAMPX_EventTrigger on CAMPX__Event__c (before insert, before update) {

    // Before insert triggers
    if(trigger.isbefore && trigger.isinsert){

        //New events placed in Planning status
        for(CAMPX__Event__c event : Trigger.new){
            event.CAMPX__Status__c = 'Planning';
            event.CAMPX__StatusChangeDate__c = System.now();
        }
        // Calculate revenue
        CAMPX_EventRevenueCalc.calculateRevenue(trigger.new);
    }
    // Before update triggers
    if(trigger.isbefore && trigger.isupdate){
    // Mapping trigger old and trigger new record values for ease of comparisons
            for(Integer i=0; i <trigger.new.size(); i++){
            CAMPX__Event__c eventNew = trigger.new[i];
            CAMPX__Event__c eventOld = trigger.old[i];
        // Capture date/time for status change
        if(eventNew.CAMPX__Status__c != eventOld.CAMPX__Status__c){
            eventNew.CAMPx__StatusChangeDate__c = System.now();
        }
    }

    // Calculate revenue
    CAMPX_EventRevenueCalc.calculateRevenue(trigger.new);
}
}