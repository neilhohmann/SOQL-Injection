public class SOQLInjectionFlow {
    public SOQLInjectionFlow() {}

    @invocableMethod (label='Return Unescaped Contacts')
    public static List<SOQLInjectionFlowResult> findUnescapedContacts(List<SOQLInjectionFlowRequest> requests){
        String searchTerm = requests[0].userInput;
        System.debug('search term: ' + searchTerm); // represents search term for Contact LastName (in WHERE clause)
        List<Contact> contacts = [SELECT Name, Phone FROM Contact WHERE LastName LIKE :searchTerm ORDER BY LastName];
        if(contacts.isEmpty()){
            System.debug('No exact matches found.');
        } else {
            System.debug('Matches found.');
        }
        SOQLInjectionFlowResult flowResult = new SOQLInjectionFlowResult();
        flowResult.results = contacts;
        return new List<SOQLInjectionFlowResult>{flowResult};
    }
    public class SOQLInjectionFlowRequest {
        @InvocableVariable(required=true)
        public String userInput;
    }
    public class SOQLInjectionFlowResult {
        @InvocableVariable(required=true)
        public List<Contact> results;
    }
}