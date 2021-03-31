public with sharing class OpenWeatherCalloutService {
    private static final String ENDPOINT_URL = 'https://api.openweathermap.org/data/2.5/weather'; 
    private static final String API_KEY = Anomaly_Range_Configuration__c.getOrgDefaults().API_Key__c;
    private Map<String, City__c> cityCodeToCityMap;

    public OpenWeatherCalloutService(){
        this.cityCodeToCityMap = new Map<String, City__c>();
        for(City__c city : [SELECT id, City_Code__c FROM City__c]){
            cityCodeToCityMap.put(city.City_Code__c, city);
        }
    }

    public void getWeatherFromOpenWeather(){
        List<Weather__c> weathersToCreate = new List<Weather__c>();
        for(City__c city : cityCodeToCityMap.values()){
            weather__c newWeather = makeCallout(city.City_Code__c);
            if (newWeather!=null) {
                weathersToCreate.add(newWeather);
            }
        }
        insert weathersToCreate;
    }

    public Weather__c makeCallout(String cityCode){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT_URL + '?id=' + cityCode + '&appid='+ API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode()==200){
            String responseBody = response.getBody();
            OpenWeatherResponse responseWrap =(OpenWeatherResponse)JSON.deserialize(response.getBody(), OpenWeatherResponse.class);
            return gerateWeather(responseWrap);
        }else {
            return null;
        }
    }
    
    public Weather__c gerateWeather(OpenWeatherResponse response){
       
        Weather__c newWeather = new Weather__c(
            Visibility__c = response.Visibility,
            Temperature__c = response.temp,
            Temperature_Feels_Like__c = response.feels_like,
            Minimal_Temperature__c = response.temp_min,
            Maximum_Temperature__c = response.temp_max,
            Pressure__c = response.pressure,
            Humidity__c = response.humidity
            );
            // if (response.clouds!=null) {
            //     newWeather.Cloudiness__c = response.clouds;
                
            // }
        
        return newWeather;
    }


    public class OpenWeatherResponse{
        public Main main;
        public Integer visibility;
        public Clouds clouds;
        public Wind wind; 
        public Decimal temp; 
        public Decimal feels_like;
        public Decimal temp_min;
        public Decimal temp_max;
        public Integer pressure;
        public Integer humidity;
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