declare module "@salesforce/apex/EmailSenderController.getUserEmails" {
  export default function getUserEmails(): Promise<any>;
}
declare module "@salesforce/apex/EmailSenderController.sendEmailWithReport" {
  export default function sendEmailWithReport(param: {anomalyReportId: any, selectedUsers: any}): Promise<any>;
}
