@IsTest
private class TestGetWeatherFromOpenWeather {
    public static final String CRON_EXP = '0 0 8 1/1 * ? *';

    @IsTest
    static void testScheduledJob() {
        Test.startTest();
        String scheduledJobID = System.schedule('Run Get Weather Callout Service', CRON_EXP, new GetWeatherFromOpenWeather());
        Test.stopTest();

        City__c city = [SELECT Name FROM City__c WHERE Name = 'Test OpenWeatherCalloutService'];
        CronTrigger job =  [SELECT Id FROM CronTrigger WHERE Id = :scheduledJobID];
        System.assertEquals('Test OpenWeatherCalloutService', city.Name, 'Tasks were not created');
        System.assertEquals(scheduledJobID, job.Id, 'Tasks were not created');
    }
}