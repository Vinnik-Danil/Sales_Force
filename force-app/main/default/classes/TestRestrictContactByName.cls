@isTest
private with sharing class TestRestrictContactByName {
    @isTest
    static void TestRestrict() {    
        List<Contact> cont= new List<Contact>();
        Contact con1 = new Contact(FirstName = 'test', LastName = 'Test', Email = 'Test@test.test');
        Contact con2 = new Contact(FirstName = 'test', LastName = 'INVALIDNAME', Email = 'Test@test.test');
        cont.add(con1);
        cont.add(con2);
    
    Test.startTest();
    try{
        insert cont;
        update cont;
    }
    catch(Exception ee){
    }

    Test.stopTest(); 
}
}