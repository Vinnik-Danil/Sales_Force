/**
 * Created by daniilvinnik on 24.11.2021.
 */

public with sharing class CaseService {
    public static void closeCases (Set<Id>caseIds , String closeReason){
        List<Case> caseList = [Select Id ,Status, Reason FROM Case where Id IN :caseIds ];
        if(caseList.size()>0){
            for(Case caseRecord : caseList){
                caseRecord.Reason = closeReason;
                caseRecord.Status = 'Closed';
            }
            Database.update(caseList, false);
        }
    }

    public static void openCases (Set<Id>caseIds , String openReason){
        List<Case> caseList = [Select Id ,Status, Reason FROM Case where Id IN :caseIds ];
        if(caseList.size()>0){
            for(Case caseRecord : caseList){
                caseRecord.Reason = openReason;
                caseRecord.Status = 'Opened';
            }
            Database.update(caseList, false);
        }
    }
}