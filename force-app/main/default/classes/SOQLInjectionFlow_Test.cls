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

    @isTest
    static void testExpectedUserInput(){
        // Test for expected search of LastName (eg, 'Tarr')
        SOQLInjectionFlow.SOQLInjectionFlowRequest request = new SOQLInjectionFlow.SOQLInjectionFlowRequest();
        request.userInput = 'Tarr';
        List<Contact> cons = SOQLInjectionFlow.findUnescapedContacts(new List<SOQLInjectionFlow.SOQLInjectionFlowRequest>{request})[0].results;
        
        Assert.areEqual(1, cons.size());
        Assert.areEqual(cons[0].Name, 'Jane Tarr');
    }

    @isTest 
    static void testSOQLInjectionWildcard(){
        // Tests if % wildcard will return results
        SOQLInjectionFlow.SOQLInjectionFlowRequest request = new SOQLInjectionFlow.SOQLInjectionFlowRequest();
        request.userInput = '%';
        List<Contact> cons = SOQLInjectionFlow.findUnescapedContacts(new List<SOQLInjectionFlow.SOQLInjectionFlowRequest>{request})[0].results;
        
        Assert.areEqual(5, cons.size());
    }

    @isTest 
    static void testSOQLInjectionSingleQuote(){
        // Tests if SOQL phrase with single quotes will return results
        SOQLInjectionFlow.SOQLInjectionFlowRequest request = new SOQLInjectionFlow.SOQLInjectionFlowRequest();
        request.userInput = 'test\' OR LastName LIKE \'%\'';
        List<Contact> cons = SOQLInjectionFlow.findUnescapedContacts(new List<SOQLInjectionFlow.SOQLInjectionFlowRequest>{request})[0].results;
        
        Assert.areEqual(0, cons.size());
    }
}