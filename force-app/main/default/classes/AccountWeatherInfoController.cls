/** 
* @author Sami Anıl Akdeniz <anilakdeniz1@gmail.com>
* @date 22/10/2024
* @description Account controller class for weather app
* Test Class : AccountWeatherInfoDisplayerTest 
* Test Class Coverage : %100"
*/
public with sharing class AccountWeatherInfoController {
   
    @AuraEnabled
    public static string weatherCallout(Id accountId){
       Account account = [SELECT Id, ShippingCity FROM Account 
                                                  WHERE Id = :accountId 
                                                  WITH SECURITY_ENFORCED];

        String locationCityName = acc.ShippingCity;
        String apiKey = '*******************'; // I covered my api key for security purposes
        String url = 'https://api.openweathermap.org/data/2.5/weather?q=';

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url + locationCityName + '&appid=' + apiKey + 'units=metric');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            return ((AccountWeatherWrapper)JSON.deserialize(response.getBody(), AccountWeatherWrapper.class));
        }else {
            return null;
        }
    }
}