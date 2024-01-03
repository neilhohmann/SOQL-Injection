public class SOQLInjectionFlow {

    @invocableMethod (label='Return Unescaped Contacts' description='Takes user input and returns list of contacts')
    public static List<List<Contact>> findUnescapedContacts(List<String> userInputs){
        // Notice that the method parameter and return variable must be bulkified even though
        // the flow is not (only a single input is passed from the flow and a single list is returned)
        String searchTerm = userInputs[0];
        List<Contact> contacts = [SELECT Name, Phone FROM Contact WHERE LastName LIKE :searchTerm ORDER BY LastName];

        return new List<List<Contact>>{contacts};
    }
}