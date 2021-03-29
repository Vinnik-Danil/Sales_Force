public class AccountProcessor {
	@future
    public static void countContacts(List<Id> accountIds){
        List<Contact> contactList;
        Account currentAccount;
        for(Id accountId :accountIds){
			contactList = [SELECT Id FROM Contact WHERE AccountId = :accountId];
            currentAccount = [SELECT Id FROM Account WHERE Id = :accountId];
            currentAccount.Number_of_Contacts__c = contactList.size();
            update currentAccount;
        }
    }
}