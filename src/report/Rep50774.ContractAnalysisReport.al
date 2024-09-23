report 50774 "Contract Analysis Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ContractAnalysisReport.rdl';

    dataset
    {
        dataitem(Contract; "Project Header")
        {
            column(No_; "No.")
            {
            }
            column(Contract_Type; "Contract Type")
            {
            }
            column(Status; Status)
            {
            }
        }
    }
}