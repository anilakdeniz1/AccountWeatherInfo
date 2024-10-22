@isTest
public with sharing class TestUtility {
    
    public static Account createAccount() {
        Account anAccount = new Account(
            Name = 'Test Account',
            Type = 'Customer',
            Industry = 'Technology',
            Phone = '123-456-7890',
            Email = 'test_account@test.com'
        );

        insert anAccount;
        
        return anAccount;
    }

    public static Account prepareAccount() {
        return new Account(
            Name = 'Test Account',
            Type = 'Customer',
            Industry = 'Technology',
            Phone = '123-456-7890',
            Email = 'test_account@test.com'
        );
    }
}