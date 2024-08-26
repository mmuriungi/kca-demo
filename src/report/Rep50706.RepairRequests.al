report 50706 "Repair Requests"
{
    Caption = 'Repair Requests';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/54231-Repair Requests.rdl';
    dataset
    {
        dataitem(RepairRequest; "Repair Request")
        {
            RequestFilterFields = Status, "Request Date", "User ID";
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
            column(FacilityNo; "Facility No.")
            {
            }
            column(FacilityDescription; "Facility Description")
            {
            }
            column(RequestDate; "Request Date")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(RepairDescription; "Repair Description")
            {
            }
            column(Status; Status)
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
