public without sharing class EmailSenderController {

    private static final Set<String> profilesToReceiveAnomalyReportEmails = new Set<String>{
        'System Administrator', 'Weather Anomaly Expert', 'Research Anomalies Trainee'
    };
    
    @AuraEnabled(cacheable=true)
    public static List<User> getUserEmails(){
        return [SELECT Id, Name, Email FROM User WHERE Profile.Name IN: profilesToReceiveAnomalyReportEmails];
    }

    @AuraEnabled(cacheable=true)
    public static void sendEmailWithReport(Id anomalyReportId, List<Id> selectedUsers){
        System.debug('selectedUsers: ' + selectedUsers);
        
        List<EmailTemplate> templates = [SELECT Id FROM EmailTemplate 
                                            WHERE DeveloperName = 'Anomaly_Report'];
        List<ContentDocumentLink> documentLinks = [SELECT Id, ContentDocumentId, ContentDocument.LatestPublishedVersionId  
                                                    FROM ContentDocumentLink 
                                                    WHERE LinkedEntityId =: anomalyReportId LIMIT 1];
        List<Messaging.SingleEmailMessage> messagesToSend = new List<Messaging.SingleEmailMessage>();
        for(Id userId : selectedUsers){
            Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
            emailMessage.setTemplateId(templates[0].Id);
            emailMessage.setTargetObjectId(userId);
            emailMessage.setSaveAsActivity(false);
            if(!documentLinks.isEmpty()){
                emailMessage.setEntityAttachments(new List<Id> {documentLinks[0].ContentDocument.LatestPublishedVersionId});
            }
            messagesToSend.add(emailMessage);
        }
        
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(messagesToSend, false);
        for(Messaging.SendEmailResult res : results){
            if(!res.isSuccess()){
                List<Messaging.SendEmailError> errors = res.getErrors();
                for(Messaging.SendEmailError err : errors){
                    system.debug('error: ' + err.getMessage());
                }
            } else {
                system.debug('OK!');
            }
        }
        
    }
}