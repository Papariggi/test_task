//test mock
@IsTest
global class CurrencyPairCalloutMock implements HttpCalloutMock{
    private static final String successResponse = '{"base":"EUR",'+
                                                '"rates":{"GBP":0.9012,"HKD":8.6987},' +
                                                '"date":"2020-07-03"}';
    private static final String serviceUrl = 'https://api.ratesapi.io/api/latest';

    global HttpResponse respond(HttpRequest req) {
        System.assertEquals('GET', req.getMethod());
        System.assertEquals(serviceUrl, req.getEndpoint());

        HttpResponse resp = new HttpResponse();
        resp.setHeader('Content-Type', 'application/json');
        resp.setBody(successResponse);
        resp.setStatusCode(200);
        return resp;
    }
}
