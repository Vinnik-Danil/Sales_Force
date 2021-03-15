public with sharing class AnomalyDetector {

    public Anomaly_Range_Configuration__c anomalyRandeSetting;

    public AnomalyDetector() {
        this.anomalyRandeSetting = Anomaly_Range_Configuration__c.getOrgDefaults();
    }

    public List<Anomaly__c> detectAnomaly(Weather__c weather){
        List<Anomaly__c> anomaliesToSave = new List<Anomaly__c>();
        //Code here 
        //Compare weather fields with custom setting fields to define if some anomaly exist and add to the List.
        return anomaliesToSave;
    }
}

