public with sharing class AnomalyDetector {

    private Anomaly_Range_Configuration__c anomalyRangeSetting;

    public AnomalyDetector() {
        this.anomalyRangeSetting = Anomaly_Range_Configuration__c.getOrgDefaults();
    }

    public List<Anomaly__c> detectAnomaly(List<Weather__c> weatherList){
        List<Anomaly__c> anomaliesToSave = new List<Anomaly__c>();
        Set<Id> weatherIdSet = new Set<Id>();

        for(Weather__c weather : weatherList){
            weatherIdSet.add(weather.Id);
        }
        weatherList = [SELECT Id, City__c, City__r.Name, Minimal_Temperature__c, Maximum_Temperature__c, Pressure__c, Humidity__c 
                       FROM Weather__c 
                       WHERE Id IN: weatherIdSet];

        for(Weather__c weather : weatherList) {
            if (weather.Minimal_Temperature__c < anomalyRangeSetting.Min_Temperature__c ||
            weather.Maximum_Temperature__c > anomalyRangeSetting.Max_Temperature__c){
                anomaliesToSave.add(createAnomaly(weather, 'Temperature Anomaly'));
            }if (weather.Pressure__c < anomalyRangeSetting.Min_Pressure__c ||
                weather.Pressure__c > anomalyRangeSetting.Max_Pressure__c){
                    anomaliesToSave.add(createAnomaly(weather, 'Pressure Anomaly'));
            }if (weather.Humidity__c < anomalyRangeSetting.Min_Humidity__c ||
                weather.Humidity__c > anomalyRangeSetting.Max_Humidity__c){
                    anomaliesToSave.add(createAnomaly(weather, 'Humidity Anomaly'));
        }
    }
        return anomaliesToSave;
    }

    private Anomaly__c createAnomaly(Weather__c weather, String typeAnomaly){
        Anomaly__c anomality = new Anomaly__c( 
            City__c=weather.City__c,
            City_Name__c=weather.City__r.Name,
            Reported__c=false, 
            Type__c=typeAnomaly,
            Weather__c=weather.Id);

        return anomality;
    }
}