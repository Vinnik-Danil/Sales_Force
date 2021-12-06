/**
 * Created by daniilvinnik on 24.11.2021.
 */
@RestResource(urlMapping='/case/*/open')
global with sharing class CaseOpenResource {
    @HttpPost
    global static void openCase (String reason) {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substringBetween('case/','/open');
        system.debug('caseId**'+caseId);
        Set<Id> caseIds = new Set<Id>();
        caseIds.add(Id.valueOf(caseId));
        CaseService.openCases(caseIds,reason);
    }
}