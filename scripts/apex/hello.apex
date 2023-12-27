
// Test escaping user input that includes escape symbols (\, _, %) in a STATIC SOQL query
// This calls AntiSOQLInjection.escapeSpecialCharacters() 
String userInput = 'Young%man';
System.debug('userInput: ' + userInput);
System.debug('STATIC query results: ' + AntiSOQLInjection.getContacts(userInput));

// System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');

// Test using a DYNAMIC query;:
// List<Contact> dynamicContacts = Database.query('SELECT Name FROM Contact WHERE Lastname LIKE :userInputEscaped');
// System.debug('DYNAMIC SOQL results: ' + dynamicContacts);
