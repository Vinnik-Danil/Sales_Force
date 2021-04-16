public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        List<Contact> listContact =  [SELECT Id, Name, LastName, MailingPostalCode
        FROM Contact
        WHERE LastName = :lastName AND MailingPostalCode = :postalCode];
        return listContact;
    }
}