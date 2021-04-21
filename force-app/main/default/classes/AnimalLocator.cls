public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer inpVal) {
        Http http = new Http();
        String result = '';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+inpVal);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<string,object> animals = (map<string,object>) results.get('animal');
        System.debug('Received the following animals:' + animals );
        result = string.valueof(animals.get('name'));
        System.debug('strResp >>>>>>' + result);
        return result;
   } 
}