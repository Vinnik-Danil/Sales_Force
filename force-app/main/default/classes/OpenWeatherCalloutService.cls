public class OpenWeatherCalloutService {

    private static final String API_KEY = Anomaly_Range_Configuration__c.getOrgDefaults().API_Key__c;
    private static final String ENDPOINT_URL = 'https://api.openweathermap.org/data/2.5/weather';
    private Map<String, City__c> cityCodeToCityMap;

    public OpenWeatherCalloutService(){
        this.cityCodeToCityMap = new Map<String, City__c> ();
        for(City__c city : [SELECT Id, City_Code__c FROM City__c]){
            cityCodeToCityMap.put(city.City_Code__c, city);
        }
    }

    public void getWeatherFromOpenWeather(){
        List<Weather__c> weathers = new List<Weather__c> ();
        for(City__c city : cityCodeToCityMap.values()){
            Weather__c weather = makeCallout(city.City_Code__c);
            if(weather != null){
                weathers.add(weather);
            }
        }
        if(!weathers.isEmpty()){
            insert weathers;
        }
    }

    public Weather__c makeCallout(String cityId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT_URL + '?id=' + cityId + '&appid=' + API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200){
            OpenWeatherResponse weatherResponse =
                    (OpenWeatherResponse) JSON.deserialize(response.getBody(), OpenWeatherResponse.class);
            return getWeatherFromResponse(weatherResponse, cityId);
        } else {
            System.debug('Status code: ' + response.getStatusCode());
            System.debug('Status code: ' + response.getStatus());
            return null;
        }
    }

    public Weather__c getWeatherFromResponse(OpenWeatherResponse response, String cityId){

        Weather__c weather = DataFactory.getWeather(
                ccityCodeToCityMap.get(cityId),
                response.main.temp,
                response.main.feels_like,
                response.main.temp_min,
                response.main.temp_max,
                response.main.pressure,
                response.main.humidity);
        return weather;
    }

    public class OpenWeatherResponse {
        public Main main;
        public Integer visibility;
        public Wind wind;
        public Clouds clouds;
    }

    public class Main {
        public Decimal temp;
        public Decimal feels_like;
        public Decimal temp_min;
        public Decimal temp_max;
        public Integer pressure;
        public Integer humidity;
    }

    public class Clouds {
        public Integer all;
    }

    public class Wind {
        public Decimal speed;
    }

}
