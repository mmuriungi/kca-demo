report 54235 "Lines Delest"
{
    ApplicationArea = All;
    Caption = 'Lines Delete';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'test.rdl';

    dataset
    {
        // dataitem(EmployeePerfTargetsLine; "Employee Perf Targets Line")
        // {
        //     trigger OnAfterGetRecord()
        //     begin
        //         EmployeePerfTargetsLine.DeleteAll();
        //     end;
        // }
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
}
