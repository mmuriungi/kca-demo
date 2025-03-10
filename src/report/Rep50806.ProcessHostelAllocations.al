report 50806 "Process Hostel Allocations"
{
    ApplicationArea = All;
    Caption = 'Process Hostel Allocations';
    UsageCategory = Tasks;
    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(Name; Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                HostelHandler.ProcessSemesterAllocations(OldSemesterCode, NewSemesterCode);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Controls)
                {
                    field(OldSemesterCode; OldSemesterCode)
                    {
                        TableRelation="ACA-Semesters";
                    }
                    field(NewSemesterCode; NewSemesterCode)
                    {
                        TableRelation="ACA-Semesters";
                    }
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
    var
        OldSemesterCode: Code[50];
        NewSemesterCode: Code[50];
        HostelHandler: Codeunit "Hostel Handler";
}
