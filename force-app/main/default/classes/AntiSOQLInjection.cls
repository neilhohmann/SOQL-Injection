public with sharing class AntiSOQLInjection {

    public static List<Contact> getContacts(String userInput){
        String userInputEscaped = AntiSOQLInjection.escapeSpecialCharacters(userInput);
        // when userInput = 'Young_man', returns 'Young\_man' even though '\\' added
        // System.debug('userInputEscaped: ' + userInputEscaped);
        return [SELECT Name FROM Contact WHERE LastName LIKE :userInputEscaped];
    }
    
    public static String escapeSpecialCharacters(String userInput){   
        String specialChars = '%_\\'; // first '\' escapes the second so that result is '%_\'
        String escapedUserInput = '';
        String nextChar;
        if(userInput.containsNone(specialChars)){
            System.debug('No special chars found in userInput: ' + userInput);
            return userInput;
        } else {
            for(Integer i=0; i<userInput.length(); i++){
                nextChar = userInput.substring(i, i+1);
                System.debug(nextChar);
                if(specialChars.contains(nextChar)){
                    System.debug('Match found...');
                    escapedUserInput += '\\' + nextChar; // first '\' escapes the second '\' resulting in only ONE '\'
                } else {
                    escapedUserInput += nextChar;
                }
            }
            System.debug('escapedUserInput: ' + escapedUserInput);
            return escapedUserInput;                       
        }   
    }
}