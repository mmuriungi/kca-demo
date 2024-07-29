page 54412 "Employee Perf Target List"
{
    ApplicationArea = All;
    Caption = 'Employee Perf Target List';
    CardPageId = "Employee Perf Target Card";
    PageType = List;
    SourceTable = "Employee Perfomance Target";
    SourceTableView = where(Status = filter(Open));
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Target Year"; Rec."Target Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Year field.';
                }
            }
        }
    }
}
