public with sharing class AnomalyDetector {

    public Anomaly_Range_Configuration__c anomalyRandeSetting;

    public AnomalyDetector() {
        this.anomalyRandeSetting = Anomaly_Range_Configuration__c.getOrgDefaults();
    }

    public List<Anomaly__c> detectAnomaly(Weather__c weather){
        List<Anomaly__c> anomaliesToSave = new List<Anomaly__c>();
        // for (weather a : [SELECT Temperature FROM weather
        //              WHERE Te AND
        //              Id IN :Trigger.old]) {
        //     [SELECT Temperature, Pressure, Wind Speed,City,(SELECT City Name FROM City) FROM weather WHERE Temperature IN ];
        // }
        // MaxTemp =   [SELECT Maximum_Temperature
        //             FROM weather];
        // MinTemp =   [SELECT Maximum_Temperature
        //             FROM weather];
        // Weather [] weath = [SELECT Temperature, Pressure, Maximum_Temperature,Minimal_Temperature
        //                     FROM weather 
        //                     WHERE Temperature > Maximum_Temperature OR Pressure>25];
        // System.debug(weath);
        if (weather.Minimal_Temperature__c < anomalyRangeSetting.Min_Temperature__c ||
            weather.Maximum_Temperature__c > anomalyRangeSetting.Max_Temperature__c)
            {
                anomaliesToSave.add(createAnomaly(weather, 'Temperature Anomaly'));
            }
        if (weather.Pressure__c < anomalyRangeSetting.Min_Pressure__c ||
            weather.Pressure__c > anomalyRangeSetting.Max_Pressure__c)
            {
                anomaliesToSave.add(createAnomaly(weather, 'Pressure Anomaly'));
            }
        if (weather.Humidity__c < anomalyRangeSetting.Min_Humidity__c ||
            weather.Humidity__c > anomalyRangeSetting.Max_Humidity__c)
            {
                anomaliesToSave.add(createAnomaly(weather, 'Humidity Anomaly'));
            }

        return anomaliesToSave;
    }
    private Anomaly__c createAnomaly(Weather__c weather, String typeAnomaly){
        return new Anomaly__c( 
            City__c=weather.City__c,
            City_Name__c=weather.City__c, 
            Reported__c=false, 
            Type__c=typeAnomaly,
            Weather__c=weather.Id);
    }

}

