public with sharing class RandomContactFactory {

    public static List<Contact> generateRandomContacts (integer nNumContacts, string sLastName) {
        List<Contact> contList = new List<Contact>();

        for (Integer i = 0; i < nNumContacts; i++) {
            Contact testCont = new Contact(LastName = sLastName+i);            
        }
        return contList;
    }

}