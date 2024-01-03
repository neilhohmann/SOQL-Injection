@isTest
private class SOQLInjectionFlow_Test {

    @testSetup 
    static void setupData() {
        // Create 5 Contacts with similar last names (eg, Barr, Carr, Farr, etc.)
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
    }

    // The following tests are performed on this SOQL query:
    // [SELECT Name, Phone FROM Contact WHERE LastName LIKE :searchTerm ORDER BY LastName]

    @isTest
    static void testExpectedUserInput(){
        // Test for expected search of LastName (eg, 'Tarr')
        // Expected to return one contact
        List<Contact> cons = SOQLInjectionFlow.findUnescapedContacts(new List<String>{'Tarr'})[0]; // the index on the end returns the first (and only) list
        
        Assert.areEqual(1, cons.size());
        Assert.areEqual('Jane Tarr', cons[0].Name);
    }

    @isTest 
    static void testSOQLInjectionWildcard(){
        // Tests if % wildcard will return results
        // Expected to return ALL contacts since LIKE keyword used
        List<Contact> cons = SOQLInjectionFlow.findUnescapedContacts(new List<String>{'%'})[0];
        
        Assert.areEqual(5, cons.size());
        Assert.areEqual('Jane Barr', cons[0].Name);
    }

    @isTest 
    static void testSOQLInjectionSingleQuote(){
        // Tests if SOQL phrase with single quotes will return results
        // Expected to return NO contacts since a bind variable escapes single quotes
        List<Contact> cons = SOQLInjectionFlow.findUnescapedContacts(new List<String>{'test\' OR LastName LIKE \'%'})[0];
        
        Assert.areEqual(0, cons.size());
    }
}