// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// string tempvar = 'Enter_your_name_here';
// System.debug('Hello World!');
// System.debug('My name is ' + tempvar);

//String userInput = '%\\_man';
//userInput = '%' + userInput + '%';

String userInput = 'Young\\_man';
System.debug('userInput: ' + userInput); // logs 'Young\_man' when userInput = 'Young\\_man' — first '\' escapes second '\'

// String result = AntiSOQLInjection.escapeSpecialCharacters(userInput);
// String userInputEscaped = result;
// System.debug('userInput escaped: ' + userInputEscaped); //when userInput = 'Young_man' returns 'Young\_man' even though '\\' added
// String userInputEscapedLeadingWild = '%' + userInputEscaped;
// System.debug('userInputEscapedLeadingWild: ' + userInputEscapedLeadingWild);

List<Contact> staticContacts = [SELECT Name FROM Contact WHERE LastName LIKE :userInput];
System.debug('static SOQL results: ' + staticContacts);
// System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
// List<Contact> dynamicContacts = Database.query('SELECT Name FROM Contact WHERE Lastname LIKE \'%' + userInput + '%\'');
// System.debug('dynamic SOQL results: ' + dynamicContacts);
