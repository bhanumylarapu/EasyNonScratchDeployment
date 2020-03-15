public with sharing class EinsteinInsuranceBotQuoteService {

    public class CustomerInsuranceRequest {
        @InvocableVariable
        public String insuranceType;
        @InvocableVariable
        public Date vehicleRegistrationDate;
        @InvocableVariable
        public Integer countOfAdultInsured;
        @InvocableVariable
        public Integer countOfChildrenInsured;
        @InvocableVariable
        public Date dobOfEldestInsured;
        @InvocableVariable
        public String sourceCountry;
        @InvocableVariable
        public String targetCountry;
        @InvocableVariable
        public String cityOfResident;
    }
    
     @InvocableMethod(label='Insurance Bot Get Quote' description='Get a quote for insurance')
    public static List<Integer> getQuote(List<CustomerInsuranceRequest> reqs) {
        CustomerInsuranceRequest req = reqs.get(0);
        Integer quoteAmount = 0;

        if(req == null){ return null; }
        Date today = date.today();
        String insuranceType = req.insuranceType;
        if(insuranceType != null) {
        
            // Quote for vehicle insurance
            if(insuranceType.contains('car') || insuranceType.contains('Two_Wheeler')) {
                Integer monthDiff = 0;
                if (req.vehicleRegistrationDate !=null) {
                    monthDiff = req.vehicleRegistrationDate.monthsBetween(today);
                }
        
                if (monthDiff <=12) {
                    quoteAmount = 95;
                } else if (monthDiff > 12 && monthDiff <36) {
                   quoteAmount = 100;
                } else {
                   quoteAmount = 125;
               }
            }
            
            //Quote for health insurance
            if(insuranceType.contains('Health')) {
                if(req.countOfAdultInsured <= 2 && req.countOfChildrenInsured <=2) {
                    quoteAmount = 280;
                    if(req.cityOfResident == 'SFO' || (req.cityOfResident == 'New York')) {
                        quoteAmount = 300;
                    }
                    // More amount if age is more than 40 years
                    if(req.dobOfEldestInsured != null && req.dobOfEldestInsured.monthsBetween(today) > 480) {
                        quoteAmount = 330;
                    }
                } else {
                    quoteAmount = 350;
                }
            }
            
            // Quote for travel insurance
            if(insuranceType.contains('Travel')) {
                quoteAmount = 90;
                if(req.countOfAdultInsured > 1 && req.countOfChildrenInsured > 1) {
                        quoteAmount = (50 * req.countOfAdultInsured) + (30* req.countOfChildrenInsured);
                }
                if((req.sourceCountry == 'USA' || req.sourceCountry == 'India') && (req.targetCountry == 'USA' || req.targetCountry == 'India')) {
                    quoteAmount = 110;
                    if(req.countOfAdultInsured > 1 && req.countOfChildrenInsured > 1) {
                        quoteAmount = (70 * req.countOfAdultInsured) + (50* req.countOfChildrenInsured);
                    }
                }
            }
        }
        
        return new List<Integer>{quoteAmount};
    }
}