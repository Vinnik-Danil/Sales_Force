@IsTest
private class TestWeatherTriggerHandler {

    @TestSetup
    static void makeData(){
        Anomaly_Range_Configuration__c anomalyRangeConfig = TestDataFactory.createAnomalyRangeConfig(
                        'Test Custom Settings',
                        60,
                        760,
                        95,
                        20,
                        700,
                        5);

        insert anomalyRangeConfig;

        City__c city = TestDataFactory.createCity('Test city');
        insert city;
    }

    public static Anomaly_Range_Configuration__c anomalyRangeConfig = Anomaly_Range_Configuration__c.getOrgDefaults();
    public static List <City__c> testCity = [SELECT Name FROM City__c WHERE Name = 'Test city'];

    @IsTest static void checkHumidityAnomaly(){
        Weather__c weatherHumidityAnom = TestDataFactory.createWeatherWithAnomaly('Humidity Anomaly', anomalyRangeConfig, testCity);

        Test.startTest();
        Database.SaveResult result = Database.insert(weatherHumidityAnom, true);
        Test.stopTest();

        List<Anomaly__c> anomaliesList = [SELECT Type__c FROM Anomaly__c];
        System.assert(result.isSuccess());
        System.assertEquals('Humidity Anomaly', anomaliesList.get(0).Type__c);
    }

    @IsTest static void checkPressureAnomaly(){
        Weather__c weatherPressureAnom = TestDataFactory.createWeatherWithAnomaly('Pressure Anomaly', anomalyRangeConfig, testCity);

        Test.startTest();
        Database.SaveResult result = Database.insert(weatherPressureAnom, true);
        Test.stopTest();

        List<Anomaly__c> anomaliesList = [SELECT Type__c FROM Anomaly__c];

        System.assert(result.isSuccess());
        System.assertEquals('Pressure Anomaly', anomaliesList.get(0).Type__c);
    }

    @IsTest static void checkTemperatureAnomaly(){
        Weather__c weatherTemperAnom = TestDataFactory.createWeatherWithAnomaly('Temperature Anomaly', anomalyRangeConfig, testCity);

        Test.startTest();
        Database.SaveResult result = Database.insert(weatherTemperAnom, true);
        Test.stopTest();

        List<Anomaly__c> anomaliesList = [SELECT Type__c FROM Anomaly__c];

        System.assert(result.isSuccess());
        System.assertEquals('Temperature Anomaly', anomaliesList.get(0).Type__c);
    }

    @IsTest static void checkWithoutAnomalies(){
        Weather__c weatherWithoutAnomalies = TestDataFactory.createWeatherWithoutAnomalies(anomalyRangeConfig, testCity);

        Test.startTest();
        Database.SaveResult result = Database.insert(weatherWithoutAnomalies, true);
        Test.stopTest();

        List<Anomaly__c> anomaliesList = [SELECT Type__c FROM Anomaly__c];

        System.assert(result.isSuccess());
        System.assert(anomaliesList.size() == 0);
    }


}
