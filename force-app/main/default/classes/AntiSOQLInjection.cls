public with sharing class AntiSOQLInjection {

    public static void findUnescapedContacts(String userInput){
        System.debug('User input: ' + userInput); // represents search term for Contact LastName (in WHERE clause)
        List<Contact> results = [SELECT Name FROM Contact WHERE LastName LIKE :userInput];
        if(results.isEmpty()){
            System.debug('No exact matches found with original, unescaped input.');
        } else {
            System.debug('Unescaped matches found: ' + results);
        }
        findEscapedContacts(userInput);
    }

    public static void findEscapedContacts(String userInput){
        String userInputEscaped = escapeSpecialCharacters(userInput);
        // when userInput = 'Young_man', returns 'Young\_man' (even though '\\' added)
        List<Contact> results = [SELECT Name FROM Contact WHERE LastName LIKE :userInputEscaped];
        if(userInputEscaped != userInput){
            if(results.isEmpty()){
                System.debug('No exact matches found on escaped input.');
                findCloseMatches(userInput);
            } else {
                System.debug('Escaped matches found: ' + results);
            }
        } if(results.isEmpty() || userInput == userInputEscaped){
            System.debug('Searching for close matches...');
            findCloseMatches(userInputEscaped);
        }
    }

    public static void findCloseMatches(String term){
        String closeMatch = term.left(3) + '%';
        //System.debug('closeMatch string: >>>' + closeMatch + '<<<');
        List<Contact> results = [SELECT Name FROM Contact WHERE LastName LIKE :closeMatch];
        if(!results.isEmpty()){
            System.debug('Here are the closest matches: ' + results);
        } else {
            closeMatch = '_' + closeMatch.right(closeMatch.length()-1);
            results = [SELECT Name FROM Contact WHERE LastName LIKE :closeMatch];
            if(!results.isEmpty()){
                System.debug('Here are the closest matches: ' + results);
            } else {
                System.debug('No close matches found.');
            }   
        }
    }

    public static String escapeSpecialCharacters(String userInput){   
        String specialChars = '%_\\'; // first '\' escapes the second so that result is '%_\'
        String escapedUserInput = '';
        String nextChar;
        if(userInput.containsNone(specialChars)){
            System.debug('No special characters found to escape.');
            return userInput;
        } else {
            System.debug('Iterating over each character in string...');
            for(Integer i=0; i<userInput.length(); i++){
                nextChar = userInput.substring(i, i+1);
                System.debug(nextChar);
                if(specialChars.contains(nextChar)){
                    System.debug('Special character match found...');
                    escapedUserInput += '\\' + nextChar; // first '\' escapes the second '\' resulting in only ONE '\'
                } else {
                    escapedUserInput += nextChar;
                }
            }
            System.debug('User input with wildcard/special characters escaped: ' + escapedUserInput);
            System.debug('Will be interpreted as: ' + escapedUserInput.remove('\\') + ' (with no wildcard or special characters)');
            return escapedUserInput;                       
        }   
    }
}