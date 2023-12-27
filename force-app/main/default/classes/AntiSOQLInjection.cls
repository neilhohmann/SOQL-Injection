public with sharing class AntiSOQLInjection {
    
    public static String escapeSpecialCharacters(String userInput){   
        String specialChars = '%_\\';
        String escapedUserInput = '';
        String nextChar;
        if(userInput.containsNone(specialChars)){
            System.debug('No special chars found in userInput');
            return userInput;
        } else {
            for(Integer i=0;i<userInput.length();i++){
                nextChar = userInput.substring(i, i+1);
                System.debug(nextChar);
                if(specialChars.contains(nextChar)){
                    System.debug('Match found...');
                    escapedUserInput += '\\' + nextChar; // first '\' escapes the second '\' resulting in only ONE '\'
                } else {
                    escapedUserInput += nextChar;
                }
            }
        return escapedUserInput;                       
        }   
    }
}