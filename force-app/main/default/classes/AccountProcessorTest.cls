@isTest
public class AccountProcessorTest {
    public static testMethod void asdf(){
        Account a = new Account(Name='asdf');
        insert a;
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{a.Id});
        Test.stopTest();
    }
}