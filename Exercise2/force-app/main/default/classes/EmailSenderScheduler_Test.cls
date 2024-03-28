
@isTest
public with sharing class EmailSenderScheduler_Test {
   
    @isTest
    static void emailSenderSchedulerTest() {
        String CRON_EXP = '0 0 10 ? * *'; //Every Day at 10.00 AM
        Test.startTest();
        EmailSenderScheduler scheduleObject = new EmailSenderScheduler();
        String jobId = scheduleObject.scheduleMe();
        CronTrigger ct = [
            SELECT Id, CronExpression, TimesTriggered, NextFireTime
            FROM CronTrigger
            WHERE id = :jobId
        ];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assert(Date.today() < ct.NextFireTime);
        Test.stopTest();
    }
}