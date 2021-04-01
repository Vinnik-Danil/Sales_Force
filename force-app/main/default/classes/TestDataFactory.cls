@IsTest
public class TestDataFactory {

    public static Weather__c createweatherWithoutAnomalies(Anomaly_Range_Configuration__c anomalyRangeConfig, List<City__c> city) {
        Weather__c weather = new Weather__c(
                City__c = city.get(0).Id,
                Maximum_Temperature__c = anomalyRangeConfig.Max_Temperature__c,
                Minimal_Temperature__c = anomalyRangeConfig.Min_Temperature__c,
                Pressure__c = anomalyRangeConfig.Max_Pressure__c,
                Humidity__c = anomalyRangeConfig.Max_Humidity__c
        );
        return weather;
    }

    public static Weather__c createWeatherWithAnomaly(String anomaly, Anomaly_Range_Configuration__c anomalyRangeConfig, List<City__c> city){
        Weather__c weather = createweatherWithoutAnomalies(anomalyRangeConfig, city);

        if (anomaly == 'Temperature Anomaly') {
            weather.Maximum_Temperature__c += 10;
            return weather;
        }else if (anomaly == 'Pressure Anomaly') {
            weather.Pressure__c += 10;
            return weather;
        }else if (anomaly == 'Humidity Anomaly') {
            weather.Humidity__c += 10;
            return weather;
        }else {
            System.debug('Weather without anomalies!');
            return weather;
        }
    }

    public static City__c createCity(String name){
        City__c city = new City__c(
                Name = name,
                City_Code__c = '5128581',
                Location__Latitude__s = 40,
                Location__Longitude__s = -74,
                Country__c = 'US');
        return city;
    }

    public static Anomaly_Range_Configuration__c createAnomalyRangeConfig(String name, Decimal maxHumidity,
            Decimal maxPressure, Decimal maxTemper, Decimal minHumidity, Decimal minPressure, Decimal minTemper){
        Anomaly_Range_Configuration__c anomalyRangeSetting = new Anomaly_Range_Configuration__c(
                Name = name,
                Max_Temperature__c = maxTemper,
                Min_Temperature__c = minTemper,
                Max_Pressure__c = maxPressure,
                Min_Pressure__c = minPressure,
                Max_Humidity__c = maxHumidity,
                Min_Humidity__c = minHumidity
        );
        return anomalyRangeSetting;
    }


}