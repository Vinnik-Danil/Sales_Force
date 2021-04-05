public with sharing class DataFactory {

    public static Weather__c getWeather(City__c city, Decimal temperature,
            Decimal temperatureFeelsLike, Decimal minTemperature,
            Decimal maxTemperature, Decimal pressure, Decimal humidity){

        Weather__c weather = new Weather__c(
                City__c = city.Id,
                Temperature__c = temperature,
                Temperature_Feels_Like__c = temperatureFeelsLike,
                Minimal_Temperature__c = minTemperature,
                Maximum_Temperature__c = maxTemperature,
                Pressure__c = pressure,
                Humidity__c = humidity
        );
        return weather;
    }

}