public with sharing class ContactController{
    @AuraEnabled(cacheable = true)
	public static List<Contact> getContacts(){
        // return [SELECT FirstName, LastName, Email
        // FROM Contact
        // ORDER BY Name];
        throw new AuraHandledException('Forced error');
	}
    
}