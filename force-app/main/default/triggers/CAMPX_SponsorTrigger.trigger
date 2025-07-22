trigger CAMPX_SponsorTrigger on CAMPX__Sponsor__c (before insert, before update, after insert, after update) {

// Before insert triggers
    if(trigger.isBefore && trigger.isinsert){
        
        // New Sponsors given Pending status if status is initially blank
        for(CAMPX__Sponsor__c sponsor : trigger.new){
            if(sponsor.CAMPX__Status__c == '' || sponsor.CAMPX__Status__c == null)
                sponsor.CAMPX__Status__c = 'Pending';

        // New Sponsors must have email addresses
            if(sponsor.CAMPX__Email__c  == '' || sponsor.CAMPX__Email__c == null){
                sponsor.addError('A sponsor can not be created without an email address.');
            }

        // If Event is not populated, then Status cannot be Accepted
            if(sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Event__c == null){
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
         }      
        // run tier assignment
            CAMPX_SponsorTierAssignment.assignTier(trigger.new);
        }
    
    // Before Update triggers

    // run tier assignment
    if(trigger.isBefore && trigger.isUpdate){
        CAMPX_SponsorTierAssignment.assignTier(trigger.new);

    // If a Sponsor loses it's event, change Status from Accepted to Rejected
    for(CAMPX__Sponsor__c sponsor : trigger.new){
        if(trigger.oldMap.get(sponsor.Id).CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Event__c == null){
            sponsor.CAMPX__Status__c = 'Rejected';
        }

    // If Event is not populated, then Status cannot be Accepted
    for(CAMPX__Sponsor__c sponsor2 : trigger.new){
            if(sponsor2.CAMPX__Status__c == 'Accepted' && sponsor2.CAMPX__Event__c == null){
                sponsor2.addError('A Sponsor must be associated with an event before being Accepted.');
            }
    }
    }
    }
    // After Update triggers only

        // Run Gross Revenue Calc on trigger.old for when an event is removed from a sponsor
    if(trigger.isafter && trigger.isupdate){

                    Set<Id> eventIds2 = new Set<Id>();
            for(CAMPX__Sponsor__c spon2 : trigger.old){
                eventIds2.add(spon2.CAMPX__Event__c);
            }
            List<CAMPX__Event__c> EventsListOld = new List<CAMPX__Event__c>();
            eventsListOld = [SELECT Id, Name, CAMPX__GrossRevenue__c, CAMPX__Status__c FROM CAMPX__Event__c WHERE Id IN :eventIds2];

            CAMPX_EventGrossRevenue.calculateGrossRev(eventsListOld);
    }

    // after update and after insert triggers for both
    if(trigger.isafter && (trigger.isupdate || trigger.isinsert)){
            // run Gross Revenue Calc
            Set<Id> eventIds = new Set<Id>();
            for(CAMPX__Sponsor__c spon : trigger.new){
                eventIds.add(spon.CAMPX__Event__c);
            }
            List<CAMPX__Event__c> EventsListNew = new List<CAMPX__Event__c>();
            eventsListNew = [SELECT Id, Name, CAMPX__GrossRevenue__c, CAMPX__Status__c FROM CAMPX__Event__c WHERE Id IN :EventIds];

            CAMPX_EventGrossRevenue.calculateGrossRev(eventsListNew);
}
}