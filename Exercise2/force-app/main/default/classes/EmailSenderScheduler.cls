public class EmailSenderScheduler implements Schedulable {
    private final String sch = '0 0 10 ? * *'; //Every Day at 10.00 AM
    //private final String sch = '0 0 13 ? * 5';  //Friday at 1.00 PM
    //private final String sch = '0 0 18 ? * 5L';  //Last Friday of the Month at 06.00 PM

    public void execute(SchedulableContext ctx) {
        EmailToPrimaryContactBatch emailSenderBatch = new EmailToPrimaryContactBatch();
        ID batchprocessid = Database.executeBatch(emailSenderBatch, 100);
    }

    public String scheduleMe() {
        EmailSenderScheduler emailScheduler = new EmailSenderScheduler(); 
        return System.schedule('EmailToPrimaryContactBatch Job', sch, emailScheduler);
    }
}