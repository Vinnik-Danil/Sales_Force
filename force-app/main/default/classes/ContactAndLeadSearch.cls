public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String name){
        List<List<sObject>> searchList = [FIND :name IN ALL FIELDS 
                   RETURNING Contact(FirstName,LastName,Department),Lead(FirstName,LastName)];
        return searchList;
    }
    
}