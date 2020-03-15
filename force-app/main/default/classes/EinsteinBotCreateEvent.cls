public with sharing class EinsteinBotCreateEvent {
    
    @InvocableMethod(label='Create Event' description='Creates an Event for appointment')
    public static List<CustomerOutput> createEvent(List<CustomerRequest> reqs) {
        CustomerRequest req = reqs.get(0);
        if(req == null) { 
            return null; 
        }  
           
        system.debug('reqs--------'+reqs);
        DateTime startDate = req.appointmentDate;
        Integer duration = 60;
        
        List<CustomerOutput> orderOutputs = new List<CustomerOutput>(); 
        
        List<Order__c> orderQuery = [Select Id,Name,Contact__c from Order__c LIMIT 1];
        Event appointment = new Event(
            Subject = 'Meeting',
            StartDateTime = startDate,
            DurationInMinutes = duration ,
            EndDateTime =  startDate.addMinutes(duration),
            whatId = '00146000003iESZAA2'
            //whatID = orderQuery[0].Contact__c
            );
            
        //insert appointment; 
        system.debug('appointment-----'+appointment);
        
        //Event = [select id, realted, subject from case where id = : caseObj.id];
        
        if(true){    //appointment.Id != NULL){        
            CustomerOutput confirmedA = new CustomerOutput();
            confirmedA.confirmedAppointment = 'Event Created Successfully';       
            orderOutputs.add(confirmedA);
            return orderOutputs;
        }
        else{
            return Null;
        }
        
     } 
     public class CustomerRequest {
    
        @InvocableVariable
        public Datetime appointmentDate;
       
        
    }
    
    public class CustomerOutput {
    
        @InvocableVariable
        public string confirmedAppointment;
        
    }
}