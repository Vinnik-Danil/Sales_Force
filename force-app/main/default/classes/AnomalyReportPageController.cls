public without sharing class AnomalyReportPageController {

    public static final String TEMPERATURE_ANOMALY_TYPE = 'Temperature Anomaly';
    public static final String PRESSURE_ANOMALY_TYPE = 'Pressure Anomaly';
    public static final String HUMIDITY_ANOMALY_TYPE = 'Humidity Anomaly';

    public PageResultWrapper resultWrapper {get; set;}

    public AnomalyReportPageController(){
        List<AggregateResult> aggregateResList = [SELECT COUNT(Id) anomalyCount, Type__c, City__r.Name cityName
                                                  FROM Anomaly__c
                                                  WHERE Reported__c = false
                                                  GROUP BY City__r.Name, Type__c];
        if(aggregateResList.isEmpty()){
            this.resultWrapper = new PageResultWrapper();
            return;
        }
        List<AggregateResult> minMaxDates = [SELECT MIN(CreatedDate) minDate, MAX(CreatedDate) maxDate
                                             FROM Anomaly__c
                                             WHERE Reported__c = false];
        Map<String, TableResultWrapper> cityToAnomalyCountMap = new Map<String, TableResultWrapper>();
        Integer anomaliesTotal = 0;
        for(AggregateResult res : aggregateResList){
            String cityName = String.valueOf(res.get('cityName'));
            if(!cityToAnomalyCountMap.containsKey(cityName)){
                cityToAnomalyCountMap.put(cityName, new TableResultWrapper(cityName));
            }
            String anomalyType = String.valueOf(res.get('Type__c'));
            Integer anomalyCount = Integer.valueOf(res.get('anomalyCount'));
            if(anomalyType == TEMPERATURE_ANOMALY_TYPE){
                cityToAnomalyCountMap.get(cityName).temperatureAnomalyCount = anomalyCount;
            } else if(anomalyType == PRESSURE_ANOMALY_TYPE){
                cityToAnomalyCountMap.get(cityName).pressureAnomalyCount = anomalyCount;
            } else if(anomalyType == HUMIDITY_ANOMALY_TYPE){
                cityToAnomalyCountMap.get(cityName).humidityAnomalyCount = anomalyCount;
            }
            anomaliesTotal += anomalyCount;
        }
        this.resultWrapper = new PageResultWrapper(DateTime.valueOf(minMaxDates[0].get('minDate'))
                , DateTime.valueOf(minMaxDates[0].get('maxDate'))
                , cityToAnomalyCountMap.values()
                , anomaliesTotal);
    }

    public class PageResultWrapper {
        public String startPeriod {get; set;}
        public String endPeriod {get; set;}
        public List<TableResultWrapper> resultList {get; set;}
        public Integer anomaliesTotal {get; set;}
        public String createdAt {get; set;}
        public String format = 'yyyy.MM.dd h:mm a';

        public PageResultWrapper(){
            this.createdAt = System.now().format(format);
        }

        public PageResultWrapper(DateTime startPeriod, DateTime endPeriod, List<TableResultWrapper> resultList, Integer anomaliesTotal){
            this.startPeriod = startPeriod.format(format);
            this.endPeriod = endPeriod.format(format);
            this.resultList = resultList;
            this.anomaliesTotal = anomaliesTotal;
            this.createdAt = System.now().format(format);
        }
    }

    public class TableResultWrapper {
        public String city {get; set;}
        public Integer temperatureAnomalyCount {get; set;}
        public Integer pressureAnomalyCount {get; set;}
        public Integer humidityAnomalyCount {get; set;}

        public TableResultWrapper(String city){
            this.city = city;
            this.temperatureAnomalyCount = 0;
            this.pressureAnomalyCount = 0;
            this.humidityAnomalyCount = 0;
        }
    }
}