public with sharing class EinsteinBotUpdateOrderDetails {

    
    @InvocableMethod(label='Get Order Status')
    public static List<OrderOutput> getOrderStatus(List<OrderInput> orderInputs)
    {
        Set<String> orderNumbers = new Set<String>();
        List<OrderOutput> orderOutputs = new List<OrderOutput>();
        for (OrderInput orderInput : orderInputs) {
            orderNumbers.add(orderInput.sOrderNumber);
        }
        
        Map<String, order__c> mapNameStatus = new Map<String, order__c>();
        for(order__c ord : [Select id,Name,effective_Date__c,status__c,Shipment_Date__c from order__c where Name IN : orderNumbers]){
            mapNameStatus.put(ord.Name, ord);
        }
        
        if(mapNameStatus.isEmpty()){
            return null;
        }
        
        for (OrderInput orderInput : orderInputs)
        {
            OrderOutput orderOutput = new OrderOutput();
            orderOutput.sOrderId = mapNameStatus.get(orderInput.sOrderNumber).Id;
            orderOutput.sStatus = mapNameStatus.get(orderInput.sOrderNumber).status__c;
            orderOutput.sCreatedDate = mapNameStatus.get(orderInput.sOrderNumber).effective_Date__c;
            orderOutput.sShippingDate = mapNameStatus.get(orderInput.sOrderNumber).Shipment_Date__c;
            
            orderOutputs.add(orderOutput);
        }
        return orderOutputs;
        
    }
    
    /*@InvocableMethod(label='Bot Update Order Data' description='Update the Order details')
    public static List<OrderOutput> updateOrder(List<CustomerOrderRequest> reqs) {
        CustomerOrderRequest req = reqs.get(0);
        system.debug('CustomerOrderRequest----'+req);
        if(req == null) { 
            return null; 
        }     
        String orderNum = req.OrderNumber;
        system.debug('orderNum----'+orderNum);
        List<Order> orderCustData = [Select id,OrderNumber,ShippingStreet,createdDate,EndDate,ShippingCountry,ShippingState,ShippingCity,ShippingPostalCode,status from Order where orderNumber =:orderNum LIMIT 1];
        system.debug('orderCustData List----'+orderCustData);
        If(orderCustData != NULL){
            List<OrderOutput> orderOutputs = new List<OrderOutput>();
            
            OrderOutput orderOutput = new OrderOutput();
                orderOutput.sStatus = orderCustData[0].status;
                orderOutput.sCreatedDate = date.newinstance(orderCustData[0].createdDate.year(), orderCustData[0].createdDate.month(), orderCustData[0].createdDate.day());
                orderOutput.sShippingDate = orderCustData[0].Shipment_Date__c;
                orderOutputs.add(orderOutput);
           
            system.debug('orderOutput-->'+orderOutputs);
            return orderOutputs;  
        }
        return null;
    }*/
    
    public class OrderInput{
        @InvocableVariable(required=true)
        public String sOrderNumber;
    }
    
    public class OrderOutput{
        @InvocableVariable(required=true)
        public String sStatus;
        @InvocableVariable(required=true)
        public Date sCreatedDate;
        @InvocableVariable(required=true)
        public Date sShippingDate;
        @InvocableVariable(required=true)
        public String sOrderId;
    }

    
}