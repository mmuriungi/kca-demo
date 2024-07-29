page 54407 "Department WorkPlan  List"
{
    Editable = false;
    ApplicationArea = All;
    CardPageId = "Department Workplan Card";
    Caption = 'Department WorkPlan  List';
    PageType = List;
    SourceTable = "DepartMent Work Plan";
    UsageCategory = Lists;
    SourceTableView = where(Incharge = const(HOD));

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
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
            }
        }
    }
}
