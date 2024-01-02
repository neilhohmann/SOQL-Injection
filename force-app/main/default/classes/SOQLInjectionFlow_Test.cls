@isTest
public with sharing class SOQLInjectionFlow_Test {

    @isTest
    public static void testSOQLResults(){

        // Create 5 Contacts with similar last names 
        List<Contact> consToInsert = new List<Contact>();
        String lastName = 'arr';
        List<String> startingLetterLastName = new List<String>{'B', 'C', 'F', 'P', 'T'};
        for(Integer i=0; i<startingLetterLastName.size(); i++){
            Contact con = new Contact();
            con.FirstName = 'Jane';
            con.LastName = startingLetterLastName[i] + lastName;
            con.Email = con.LastName + '@somecompany.com';
            consToInsert.add(con);
        }
        insert consToInsert;

        List<String> userInputList = new List<String>{'Tarr'};
        List<Contacts> cons = SOQLInjectionFlow.findUnescapedContacts(userInputList);
        Assert.areEqual(1, userInputList.size());
    }
    
}