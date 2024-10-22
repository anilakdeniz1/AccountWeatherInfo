@isTest
public with sharing class AccountWeatherInfoControllerTest {
    
    @isTest
    static void fetchWeatherInfo_whenStatusCodeIsSuccess() {
        Account anAccount = TestUtility.createAccount();

        Test.startTest();
    
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200));
        AccountWeatherInfoWrapper result = AccountWeatherInfoController.weatherCallout(anAccount.Id);
    
        Test.stopTest();

        System.assertEquals('light intensity drizzle', result.weather[0].description, 'Description should be the light intensity drizzle.');
        System.assertEquals(null, result, 'Wrapper should not be null with status code 200.');
    }

    static void doNotFetchWeatherInfo_whenStatusCodeIsError() {
        Account anAccount = TestUtility.createAccount();

        Test.startTest();

        Test.setMock(HttpCalloutMocK.class, new MockHttpResponseGenerator(400));
        AccountWeatherInfoWrapper wrapper = AccountWeatherInfoController.weatherCallout(anAccountId);

        Test.stopTest();

        System.assertEquals(null, result, 'Wrapper should be null with status code 400.');
    }

    /** 
    * @author Sami Anıl Akdeniz <anilakdeniz1@gmail.com>
    * @date 22/10/2024
    * @description Class for creating mock response
    */  
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;

        MockHttpResponseGenerator(Integer statusCode) {
            this.statusCode = statusCode;
        }

        /** 
        * @description Method for creating response according to status code
        */
        public HTTPResponse response(HTTPRequest req) {

            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":300,"main":"Drizzle","description":"light intensity drizzle","icon":"09d"}],"main":{"temp":280.32,"pressure":1012,"humidity":81,"temp_min":279.15,"temp_max":281.15},"id":2643743,"name":"London","cod":200}');
            response.setStatusCode(this.statusCode);

            return response;
        }
    }
}