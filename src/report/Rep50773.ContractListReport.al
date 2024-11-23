report 50773 "Contract List Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ContractListReport.rdl';

    dataset
    {
        dataitem(Contract; "Project Header")
        {
            column(No_; "No.")
            {
            }
            column(Contract_Name; "Contract Name")
            {
            }
            column(Project_Date; "Project Date")
            {
            }
            column(Contract_Type; "Contract Type")
            {
            }
            column(Description; Description)
            {

            }
            column(Vendor_No; "Vendor No")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Status; Status)
            {
            }
            column(Project_Budget; "Project Budget")
            {
            }
            column(picture; CompInfo.Picture)
            {
            }
            column(Company_Name; CompInfo.Name)
            {
            }
            column(Company_Address; CompInfo.Address)
            {
            }
        }
    }
    trigger OnInitReport()
    var
    begin
        CompInfo.Reset();
        if CompInfo.GET then
        CompInfo.CalcFields("Picture");
    end;
    var
    CompInfo:Record "Company Information";
}