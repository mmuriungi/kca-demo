report 50764 "Complaints report"
{
    ApplicationArea = All;
    Caption = 'Complaints report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Complaints Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CAComplaints; "CA-Complaints")
        {
            column(Code; "Code")
            {
            }
            column(ComplainType; "Complain Type")
            {
            }
            column(ComplaintDescription; "Complaint Description")
            {
            }
            column(CostCenterCode; "Cost Center Code")
            {
            }
            column(DepartmentName; "Department Name")
            {
            }
            column(RegionCode; "Region Code")
            {
            }
            column(RegionName; "Region Name")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(Status; Status)
            {
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            dataitem(DataItem1001; "Feedback Response")
            {
                column(Response; "Response")
                {
                }

            }
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
    trigger OnPreReport()
    begin
        CI.RESET;
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HrEmp: Record "HRM-Employee (D)";
}
