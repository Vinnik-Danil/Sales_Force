// public class OpenWeatherCalloutService {

//     private static final String API_KEY = Anomaly_Range_Configuration__c.getOrgDefaults().API_Key__c;
//     private static final String ENDPOINT_URL = 'https://api.openweathermap.org/data/2.5/weather';
//     private Map<String, City__c> cityCodeCity;

//     public OpenWeatherCalloutService(){
//         this.cityCodeCity = new Map<String, City__c> ();
//         for(City__c city : [SELECT Id, City_Code__c FROM City__c]){
//             cityCodeCity.put(city.City_Code__c, city);
//         }
//     }

//     public void getWeatherFromOpenWeather(){
//         List<Weather__c> weathers = new List<Weather__c> ();
//         for(City__c city : cityCodeCity.values()){
//             Weather__c weather = makeCallout(city.City_Code__c);
//             if(weather != null){
//                 weathers.add(weather);
//             }
//         }
//         if(!weathers.isEmpty()){
//             insert weathers;
//         }
//     }

//     public Weather__c makeCallout(String cityId){
//         Http http = new Http();
//         HttpRequest request = new HttpRequest();
//         request.setEndpoint(ENDPOINT_URL + '?id=' + cityId + '&appid=' + API_KEY);
//         request.setMethod('GET');
//         HttpResponse response = http.send(request);

//         if(response.getStatusCode() == 200){
//             OpenWeatherResponse weatherResponse =
//                     (OpenWeatherResponse) JSON.deserialize(response.getBody(), OpenWeatherResponse.class);
//             return getWeatherFromResponse(weatherResponse, cityId);
//         } else {
//             System.debug('Status code: ' + response.getStatusCode());
//             System.debug('Status code: ' + response.getStatus());
//             return null;
//         }
//     }

//     public Weather__c getWeatherFromResponse(OpenWeatherResponse response, String cityId){

//         Weather__c weather = DataFactory.getWeather(
//                 cityCodeCity.get(cityId),
//                 response.main.temp,
//                 response.main.feels_like,
//                 response.main.temp_min,
//                 response.main.temp_max,
//                 response.main.pressure,
//                 response.main.humidity);
//         return weather;
//     }

//     public class OpenWeatherResponse {
//         public Main main;
//         public Integer visibility;
//         public Wind wind;
//         public Clouds clouds;
//     }

//     public class Main {
//         public Decimal temp;
//         public Decimal feels_like;
//         public Decimal temp_min;
//         public Decimal temp_max;
//         public Integer pressure;
//         public Integer humidity;
//     }

//     public class Clouds {
//         public Integer all;
//     }

//     public class Wind {
//         public Decimal speed;
//     }

// }

public with sharing class OpenWeatherCalloutService {
    private static final String ENDPOINT_URL = 'https://api.openweathermap.org/data/2.5/weather'; 
    private static final String API_KEY = Anomaly_Range_Configuration__c.getOrgDefaults().API_Key__c;
    private Map<String, City__c> cityCodeToCityMap;

    public OpenWeatherCalloutService(){
        this.cityCodeToCityMap = new Map<String, City__c>();
        for(City__c city : [SELECT id, City_Code__c FROM City__c]){
            this.cityCodeToCityMap.put(city.City_Code__c, city);
        }
    }
    @future(callout=true)
    public void getWeatherFromOpenWeather(){
        List<Weather__c> weathersToCreate = new List<Weather__c>();
        for(City__c city : cityCodeToCityMap.values()){
            Weather__c newWeather = makeCallout(city.City_Code__c);
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