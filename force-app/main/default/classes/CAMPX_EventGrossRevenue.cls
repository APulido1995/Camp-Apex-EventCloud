public with sharing class CAMPX_EventGrossRevenue {
    public static void calculateGrossRev( List<CAMPX__Event__c> eventsNew) {
        for(CAMPX__Event__c eve : eventsNew) {
           
            Decimal grossRev = 0;

            List<CAMPX__Sponsor__c> relatedSponsors = [SELECT Id, Name, CAMPX__ContributionAmount__c, CAMPX__Status__c 
                                                        FROM CAMPX__Sponsor__c 
                                                        WHERE CAMPX__Event__c = :eve.Id];

            for(Integer i = 0; i < relatedSponsors.size(); i++) {
                if(relatedSponsors[i].CAMPX__ContributionAmount__c != null && relatedSponsors[i].CAMPX__Status__c == 'Accepted'){

                    grossRev += relatedSponsors[i].CAMPX__ContributionAmount__c;
                    system.debug(grossRev);
                }
                }
                eve.CAMPX__GrossRevenue__c = grossRev;
        }
                update eventsNew;
}

    public static void reduceGrossRev(List<CAMPX__Event__c> eventsOld) {
        
                for(CAMPX__Event__c eve2 : eventsOld) {
            Decimal grossRev2 = 0;

            List<CAMPX__Sponsor__c> relatedSponsors2 = [SELECT Id, Name, CAMPX__ContributionAmount__c, CAMPX__Status__c
                                                        FROM CAMPX__Sponsor__c 
                                                        WHERE CAMPX__Event__c = :eve2.Id];

            for(Integer i = 0; i < relatedSponsors2.size(); i++) {
                if(relatedSponsors2[i].CAMPX__ContributionAmount__c != null && relatedSponsors2[i].CAMPX__Status__c == 'Accepted'){

                    grossRev2 += relatedSponsors2[i].CAMPX__ContributionAmount__c;
                    system.debug(grossRev2);
                }
                }
                eve2.CAMPX__GrossRevenue__c = grossRev2;
            }
            update eventsOld;
    }
    }