public with sharing class WeatherTriggerHandler {

    public static void handleBeforeInsert(List<Weather__c> newList){}

    public static void handleAfterInsert(List<Weather__c> newList){
        //Code here 
        //Use AnomalyDetector to detect an anomaly
        //Use SOQL to get City record information
        //insert Anomalies
        //update City
        AnomalyDetector anomalyDetector = new AnomalyDetector();
        List<Anomaly__c> anomaliesToSave = new List<Anomaly__c>();

        if (!anomaliesToSave.isEmpty()) {
            insert anomaliesToSave;
        }

        List<City__c> cityResponsesList = [SELECT Id, Name FROM City__C];

        
        if (!anomaliesToSave.isEmpty()) {
            insert anomaliesToSave;
        }

        if (!cityResponsesList.isEmpty()) {
            update cityResponsesList;
        }

    }

    public static void handleBeforeUpdate(List<Weather__c> newList, List<Weather__c> oldList){}

    public static void handleAfterUpdate(List<Weather__c> newList, List<Weather__c> oldList){}

    public static void handleBeforeDelete(List<Weather__c> oldList){}

    public static void handleAfterDelete(List<Weather__c> oldList){}
}
