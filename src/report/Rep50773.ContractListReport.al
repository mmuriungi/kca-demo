report 50773 "Contract List Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ContractListReport.rdl';

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