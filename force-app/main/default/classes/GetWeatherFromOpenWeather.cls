global class GetWeatherFromOpenWeather implements Schedulable{

    public static final String CRON_EXP = '0 0 8 1/1 * ? *';

    global void execute(SchedulableContext ctx){
        OpenWeatherCalloutService openWeatherCalloutService = new OpenWeatherCalloutService();
        openWeatherCalloutService.getWeatherFromOpenWeather();
    }

    public static void runGetWeatherFromOpenWeather(){
        String jobID = System.schedule('Run Get Weather Callout Service', CRON_EXP, new GetWeatherFromOpenWeather());
    }


}