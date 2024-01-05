public with sharing class DynamicSOQLwDoubleEscape {

    @invocableMethod (label='Return DOUBLE ESCAPED Contacts: DYNAMIC')
    public static List<List<Contact>> findUnescapedContacts(List<String> userInputs){
        // Notice that the method parameter and return variable must be bulkified even though
        // the flow is not (only a single input is passed from the flow and a single list is returned)
        String searchTerm = userInputs[0];
        String wildChars = '%_\''; // characters to escape; includes single quote
        String escapedSearchTerm = '';
        if(searchTerm.containsAny(wildChars)){ // if searchTerm contains wildcard chars, escape them
            for(Integer i=0; i<searchTerm.size(); i++){
                nextChar = searchTerm.substring(i, i+1);
                if(nextChar.containsAny(wildChars)){
                    escapedSearchTerm += '\\'; // first '\' escapes second '\'
                }
                escapedSearchTerm += nextChar;
            }
            searchTerm = escapedSearchTerm; // this updates searchTerm w/escaped wildcard chars
        }

        List<Contact> contacts = Database.query('SELECT Name, Email FROM Contact WHERE LastName LIKE \'%' + searchTerm + '%\' ORDER BY LastName');
        
        return new List<List<Contact>>{contacts};
    }
}