page 54422 "Appraisal List1"
{
    ApplicationArea = All;
    Caption = 'Appraisal List';
    CardPageId = "Appraisal Level";
    PageType = List;
    SourceTable = "Employee Perfomance Target";
    UsageCategory = Lists;
    Editable = false;
    SourceTableView = where(Level = const(Report));

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
