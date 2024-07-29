report 54232 "Repair Types"
{
    Caption = 'Repair Types';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/54232-Repair Types.rdl';
    dataset
    {
        dataitem(TypeofRepair; "Type of Repair")
        {
            column(SNo; SNo) { }
            column(Filter; Filter) { }
            column(CompanyLogo; Company.Picture) { }
            column(CompanyName; Company.Name) { }
            column(CompanyAddress; Company.Address) { }
            column(CompanyAddress2; Company."Address 2") { }
            column(CompanyPostalCode; Company."Post Code") { }
            column(CompanyCity; Company.City) { }
            column(CompanyCountry; Company."Country/Region Code") { }
            column(CompanyPhone; Company."Phone No.") { }
            column(CompanyEmail; Company."E-Mail") { }
            column(CompanyHomePage; Company."Home Page") { }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Filter := GetFilters;
                SNo += 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        Company.Get;
        Company.CalcFields(Picture);
    end;

    var
        Company: Record "Company Information";
        Filter: Text;
        SNo: Integer;
}
