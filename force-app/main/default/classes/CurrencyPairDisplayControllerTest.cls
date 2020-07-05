@IsTest
private class CurrencyPairDisplayControllerTest {
    private static final String successResponse = '{"base":"EUR",'+
                                                '"rates":{"GBP":0.9012,"HKD":8.6987},' +
                                                '"date":"2020-07-03"}';
    @isTest
    private static void testGetCalloutCurrencyPair() {
        Test.setMock(HttpCalloutMock.class, new CurrencyPairCalloutMock());
        Map<String, Double> responseMap = CurrencyPairDisplayController.getCalloutCurrencyPair();

        System.assert(responseMap.containsKey('EUR/GBP'));
        System.assert(responseMap.containsKey('EUR/HKD'));

        System.assertEquals(0.9012, responseMap.get('EUR/GBP'));
        System.assertEquals(8.6987, responseMap.get('EUR/HKD'));
    }
}
