public with sharing class EinsteinBotUpdateShippingAddress {

    @InvocableMethod(label='Bot Update Order Data' description='Update the Order details')
    public static List<Order__c> updateOrder(List<CustomerOrderRequest> reqs) {
        CustomerOrderRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        }     
        String orderNum = req.OrderNumber;
        List<Order__c> orderCustData = [Select id,Name,Effective_Date__c,OrderDate__c,Shipment_Date__c,Shipping_City__c,Shipping_Country__c,Shipping_State__c,Shipping_Street__c,Status__c,Zip_postal_Code__c from Order__c where Name =:orderNum LIMIT 1];
        If(orderCustData != NULL){
                orderCustData[0].Shipping_Street__c = req.ShippingStreet;
                orderCustData[0].Shipping_Country__c = req.ShippingCountry;
                orderCustData[0].Shipping_State__c = req.ShippingState;
                orderCustData[0].Shipping_City__c = req.ShippingCity;
                orderCustData[0].Zip_postal_Code__c = req.ShippingZipCode;
                
                
        } 
        if(orderCustData.size()>0){     
            update orderCustData; 
            return orderCustData;
        }   
        else{       
            return null;
        }
    }
    
    public class CustomerOrderRequest {
        @InvocableVariable
        public String ShippingStreet;
        @InvocableVariable
        public String ShippingCountry;
        @InvocableVariable
        public String ShippingState;
        @InvocableVariable
        public String ShippingCity;
        @InvocableVariable
        public String ShippingZipCode;
        @InvocableVariable
        public String OrderNumber;
    
    }

    
}