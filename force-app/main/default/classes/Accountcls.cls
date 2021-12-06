public class Accountcls {
    ////
    
    @AuraEnabled (cacheable=true)
    public static List<Account> getAccountList(){
        return[SELECT Id, Name,Type,AccountNumber
                FROM Account
                Limit 2];
    }

}