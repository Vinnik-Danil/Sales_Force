public without sharing class AnomalyViewComponentController {
	
    @AuraEnabled
    public static List<Anomaly__c> getAnomalies(){
        return [SELECT Id, Name, Type__c, Reported__c, CreatedDate, City__c, City__r.Name, Weather__c, Weather__r.Name 
                FROM Anomaly__c 
                ORDER BY CreatedDate DESC, Name DESC];
    }
    
    @AuraEnabled
    public static void getCurrentWeather(){
        (new OpenWeatherCalloutService()).getWeatherFromOpenWeather();
    }
    
    @AuraEnabled
    public static void generateAnomalyReport(){
        List<Anomaly__c> unreportedAnomalies = [SELECT Id, Reported__c FROM Anomaly__c WHERE Reported__c = false];
        for(Anomaly__c anomaly : unreportedAnomalies){
            anomaly.Reported__c = true;
        }
        Anomaly_Report__c report = new Anomaly_Report__c(Name = 'Anomaly Report ' + System.now().format('yyyy.MM.dd h:mm a'));
        insert report;
        ContentVersion cv = new ContentVersion();
        cv.Title = report.Name;
        cv.PathOnClient = cv.Title + '.pdf';
        cv.IsMajorVersion = true;
        cv.FirstPublishLocationId = report.Id;
        cv.VersionData = Page.AnomalyReportPage.getcontentAsPdf();
        insert cv;
        update unreportedAnomalies;
    }
}