import { LightningElement, track, api } from 'lwc';

const ALLFIELDS = [
    {
        fieldName: "field1",
        label: "",
        type: "text"
    },
    {
        fieldName: "field2",
        label: "Details",
        type: "text"
    },
    {
        fieldName: "field3",
        label: "Notes",
        type: "text"
    }
];
const DATA = [
    { id: "1", field1: "Customer",              field2: "Brett Jones",  field3: "" },
    { id: "2", field1: "Total Vehicle Value",   field2: "",             field3: "" },
    { id: "3", field1: "Advance",               field2: "£ 25,000",     field3: "" },
    { id: "4", field1: "Balloon",               field2: "£ 13,100",     field3: "" },
    { id: "5", field1: "Term (Months)",         field2: "48",           field3: "" },
    { id: "6", field1: "Yield",                 field2: "8.5 %",        field3: "" },
    { id: "7", field1: "Net Worth (Verified)",  field2: "£ 1.0m",       field3: "Brett jonesTest" },
    { id: "8", field1: "Income",                field2: "£ 463.8k",     field3: "Brett jones Income stabiliti TEST" },
    { id: "9", field1: "Storage/Tracker",       field2: "",             field3: "" },
    { id: "10",field1: "Vehicle(s) Details",    field2: "",             field3: "" },
    { id: "11",field1: "Conditions",            field2: "",             field3: "" },
];

export default class CscSummaryTable extends LightningElement {
    dataList = DATA;
    
}