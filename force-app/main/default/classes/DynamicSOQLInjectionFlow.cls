public with sharing class DynamicSOQLInjectionFlow {

    @invocableMethod (label='Return Unescaped Contacts: DYNAMIC')
    public static List<List<Contact>> findUnescapedContacts(List<String> userInputs){
        // Notice that the method parameter and return variable must be bulkified even though
        // the flow is not (only a single input is passed from the flow and a single list is returned)
        String searchTerm = userInputs[0];
        List<Contact> contacts = Database.query('SELECT Name, Email FROM Contact WHERE LastName LIKE \'%' + searchTerm + '%\' ORDER BY LastName');
        
        return new List<List<Contact>>{contacts};
    }
}