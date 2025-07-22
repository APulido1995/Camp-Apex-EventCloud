public with sharing class CAMPX_EventRevenueCalc {
    public static void calculateRevenue(List<CAMPX__Event__c> eventsToCalc) {

        Decimal totalRev;

        for(CAMPX__Event__c event : eventsToCalc) {
            if(event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null){
                totalRev = null;
            }
            else{
                totalRev = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
            }
            event.CAMPX__NetRevenue__c = totalRev;
        }
    }
}