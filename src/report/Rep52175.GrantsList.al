report 52175 "Grants List"
{
    Caption = 'Grants List';
    RDLCLayout = './DRE/Reports/SSR/grantsList.rdl';
    dataset
    {
        dataitem(ACAGrants; "ACA-Grants")
        {
            RequestFilterFields = "Financial Year", Status;
            column(No; No)
            {
            }
            column(Awadee; Awadee)
            {
            }
            column(AwadeeName; "Awadee Name")
            {
            }
            column(Awardingagency; "Awarding agency")
            {
            }
            column(Grants_Description; "Grants Description")
            {

            }
            column(FinancialYear; "Financial Year")
            {
            }
            column(GrantTimeframeInMonths; "Grant Timeframe(In Months)")
            {
            }
            column(GrantType; "Grant Type")
            {
            }
            column(GrantsDescription; "Grants Description")
            {
            }
            column(TotalAmountAwarded; "Total Amount Awarded")
            {
            }
            column(ReceivingBankAccount; "Receiving Bank Account")
            {
            }
            column(Status; Status)
            {
            }
            column(Remaining_Amount; "Remaining Amount")
            {

            }
            column(CompNames; CompanyInformation.Name)
            {
            }
            column(Pic; CompanyInformation.Picture)
            {

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}
