public without sharing class OpenWeatherCalloutService{

    private static final String API_KEY = Anomaly_Range_Configuration__c.getOrgDefaults().API_Key__c;
    private static final String ENDPOINT_URL = 'https://api.openweathermap.org/data/2.5/weather';
    private Map<String, City__c> cityCodeToCityMap;

    public OpenWeatherCalloutService(){
        this.cityCodeToCityMap = new Map<String, City__c>();
        for (City__c city : [SELECT id, City_Code__c FROM City__c ]) {
            this.cityCodeToCityMap.put(city.City_Code__c, city);
        }
    }
    @future(callout=true)
    public void getWeatherFromOpenWeather(){
        List<Weather__c> weathersToCreate = new List<Weather__c>();
        for (City__c city : cityCodeToCityMap.values()) {
            Weather__c currentWeather = makeCallout(city.City_Code__c);
            if(currentWeather!=null){
                weathersToCreate.add(currentWeather);
            }            
        }
        system.debug('weathersToCreate size:' + weathersToCreate.size());
        if(!weathersToCreate.isEmpty()){
            insert weathersToCreate;
        }
    }

    public Weather__c makeCallout(String cityId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT_URL + '?id=' + cityId + '&appid='+ API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode()==200){
            // String responseBody = response.getBody();
            OpenWeatherResponse weatherResponse =(OpenWeatherResponse)JSON.deserialize(response.getBody(), OpenWeatherResponse.class);
            return popularWeatherRecord(weatherResponse, cityId);
        }else {
            system.debug('Status code: ' + response.getStatusCode());
            system.debug('Status: ' + response.getStatus());
            return null;
        }
    }

    public Weather__c popularWeatherRecord(OpenWeatherResponse responseWrap, String cityId){
        Weather__c newWeather = new Weather__c(City__c = cityCodeToCityMap.get(cityid).id
                                                , Visibility__c = responseWrap.visibility
                                                , Temperature__c = responseWrap.main.temp
                                                , Temperature_Feels_Like__c = responseWrap.main.feels_like
                                                , Minimal_Temperature__c = responseWrap.main.temp_min
                                                , Maximum_Temperature__c = responseWrap.main.temp_max
                                                , Pressure__c = responseWrap.main.pressure
                                                , Humidity__c = responseWrap.main.humidity);
        if(responseWrap.wind!=null){
            newWeather.Wind_speed__c = responseWrap.wind.speed;
        }
        if(responseWrap.clouds!=null){
            newWeather.Cloudiness__c = responseWrap.clouds.all;
        }
        return newWeather;
    }

        public class OpenWeatherResponse{
        public Main main;
        public Integer visibility;
        public Clouds clouds;
        public Wind wind; 
    }
    public class Main{
        public Decimal temp; 
        public Decimal feels_like;
        public Decimal temp_min;
        public Decimal temp_max;
        public Integer pressure;
        public Integer humidity;
    }

    public class Clouds{
        public Integer all;
    }
    public class Wind{
        public Decimal speed;
    }
}