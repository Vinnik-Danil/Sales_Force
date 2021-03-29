public with sharing class WeatherTriggerHandler {

    public static void handleBeforeInsert(List<Weather__c> newList){}

    public static void handleAfterInsert(List<Weather__c> newList){

        AnomalyDetector anomalyDetector = new AnomalyDetector();
        List<Anomaly__c> anomaliesToSave = anomalyDetector.detectAnomaly(newList);

        if (!anomaliesToSave.isEmpty()) {
            insert anomaliesToSave;
        }
    }

    public static void handleBeforeUpdate(List<Weather__c> newList, List<Weather__c> oldList){}

    public static void handleAfterUpdate(List<Weather__c> newList, List<Weather__c> oldList){}

    public static void handleBeforeDelete(List<Weather__c> oldList){}

    public static void handleAfterDelete(List<Weather__c> oldList){}
}