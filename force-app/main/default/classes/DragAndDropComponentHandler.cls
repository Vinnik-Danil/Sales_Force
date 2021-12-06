public with sharing class DragAndDropComponentHandler {
    @AuraEnabled
    public static List<Task> getAllTask(){
        Id loggedInUserId = UserInfo.getUserId();
        return [SELECT Id, Subject, Status FROM Task];
        // return [SELECT Id, Name,Type,AccountNumber
        //         FROM Account
        //         Limit 2];
    }

    @AuraEnabled
    public static void updateTask(Id newTaskId, String newStatus){
        Task updateTask = new Task(Id = newTaskId, Status = newStatus);
        Database.update(updateTask);
    }

    @AuraEnabled
    public static void deleteTask(Id newTaskId){
        Task deleteTask = new Task(Id = newTaskId);
        Database.delete(deleteTask);
    }
}