@isTest
public with sharing class EmailToPrimaryContactBatch_Test {
    private static Integer numberOfDatas = 5;
  
    private static void createTestData() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        List<Contact> contacts = new List<Contact>();
        List<Opportunity> opportunities = new List<Opportunity>();
        List<String> stageNames = new List<String>{
            'Prospecting',
            'Closed Won',
            'Closed Lost'
        };
        Id accId = [SELECT Id FROM Account].Id;
        Integer counter = 0;
        for (Integer i = 0; i < numberOfDatas; i++) {
            Boolean isPrimary = false;
            if (i == 3) {
                isPrimary = true;
                counter = 0;
            }
            Contact newContact = new Contact(
                FirstName = 'Test',
                LastName = 'Contact' + i,
                Is_Primary_Contact__c = isPrimary,
                AccountId = accId,
                Phone = '444000' + i
            );
            contacts.add(newContact);

            Opportunity newOpp = new Opportunity(
                Amount = 5000,
                Name = 'Test Opp' + i,
                StageName = stageNames.get(counter),
                CloseDate = Date.today().addDays(3),
                AccountId = accId
            );
            counter++;
            opportunities.add(newOpp);
        }
        contacts.get(3).Email = 'berkekarakoccc@gmail.com';
        insert contacts;
        insert opportunities;
    }

    @IsTest
    private static void emailToPrimaryContactBatchTest() {
        createTestData();
        Test.startTest();
        EmailToPrimaryContactBatch batchObject = new EmailToPrimaryContactBatch();
        Id batchId = Database.executeBatch(batchObject);
        Test.stopTest();
    }
}