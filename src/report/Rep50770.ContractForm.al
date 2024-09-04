report 50770 "Contract Form"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ContractForm.rdl';

    dataset
    {
        dataitem("Tender Evaluation Header"; "Project Header")
        {
            RequestFilterFields = "No.";
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(ISOCert; CompanyInfo."Registration No.")
            {
            }

            column(Contract_Date; "Estimated Start Date")
            {

            }
            column(Date_of_Award; "Estimated Start Date")
            {

            }
            column(Creation_Date; "Estimated Start Date")
            {

            }
            column(Ref_No_; "No.")
            {
            }
            column(Quote_No; "No.")
            {

            }
            // column(Requisition_No; "Requisition No")
            // {

            // }
            // dataitem("Tender Evaluation Line"; "Tender Evaluation Line")
            // {
            //     DataItemLink = "Quote No" = field("Quote No");
            column(Description; Description)
            {

            }
            column(Vendor_Name; Name)
            {

            }
            column(Vendor_No; "Vendor No")
            {

            }
            column(Amount; "Project Budget")
            {

            }
            // column(Awarded; Awarded)
            // {

            // }
            //}
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
                    //field(Name; SourceExpression)
                    // {
                    //ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}