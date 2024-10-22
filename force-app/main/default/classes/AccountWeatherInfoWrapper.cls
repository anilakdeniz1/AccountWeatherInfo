/** 
* @author Sami Anıl Akdeniz <anilakdeniz1@gmail.com>
* @date 13/03/2024
* @description Wrapper class for openweathermap.org data
*/
public with sharing class AccountWeatherInfoWrapper {
    @AuraEnabled
    public List<AccountWeatherInfoWrapper.SpecsOfWeather> weather{ get; set; }
    @AuraEnabled
    public AccountWeatherInfoWrapper.TemperatureOfWeather main { get; set; }

        public class SpecsOfWeather{
            @AuraEnabled
            public String description{ get; set; }
            @AuraEnabled 
            public String icon { get; set; }
        }

        public class TemperatureOfWeather{
            @AuraEnabled
            public Double temp{ get; set; }
        }
}