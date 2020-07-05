public with sharing class CurrencyPairDisplayController {
    private final static String calloutUrl = 'https://api.ratesapi.io/api/latest';
    //Returns map: pair_name -> pair_value in case of success callout. Otherwise returns
    //empty map.
    @AuraEnabled
    public static Map<String, Double> getCalloutCurrencyPair(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(calloutUrl);
        req.setMethod('GET');
        
        Map<String, Double> currencyPairMap = new Map<String, Double>();
        try {
            HttpResponse resp = new Http().send(req);
            //deserialize response
            Map<String, Object> respMap = (Map<String, Object>) JSON.deserializeUntyped(resp.getBody());
            String base = (String) respMap.get('base');
            if (base == null) {
                return new Map<String, Double>();
            }
            
            Map<String, Object> ratesMap = (Map<String, Object>) respMap.get('rates');
            //building map
            for (String curr : ratesMap.keySet()) {
                currencyPairMap.put(base + '/' + curr, Double.valueOf(ratesMap.get(curr)));
            }
        }
        catch (Exception ex) {
            System.debug('Line: ' + ex.getLineNumber());
            System.debug('Message: ' + ex.getMessage());
            return new Map<String, Double>();
        }

        return currencyPairMap;
    }

}
