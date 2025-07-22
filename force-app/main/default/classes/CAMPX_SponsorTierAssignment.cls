public with sharing class CAMPX_SponsorTierAssignment {
    public static void assignTier(list<CAMPX__Sponsor__c> sponsorsToAssign) {

        for(CAMPX__Sponsor__c sponsor : sponsorsToAssign) {
            if(sponsor.CAMPX__ContributionAmount__c == null) {
                sponsor.CAMPX__Tier__c = '';
            }
            else if(sponsor.CAMPX__ContributionAmount__c <= 0) {
                sponsor.CAMPX__Tier__c = '';    
            }
            else if(sponsor.CAMPX__ContributionAmount__c >= 0 && sponsor.CAMPX__ContributionAmount__c < 1000) {
                sponsor.CAMPX__Tier__c = 'Bronze';
            }
            else if(sponsor.CAMPX__ContributionAmount__c >= 1000 && sponsor.CAMPX__ContributionAmount__c < 5000) {
                sponsor.CAMPX__Tier__c = 'Silver';
            }
            else if(sponsor.CAMPX__ContributionAmount__c >= 5000){
                sponsor.CAMPX__Tier__c = 'Gold';
            }
        }
    }
}