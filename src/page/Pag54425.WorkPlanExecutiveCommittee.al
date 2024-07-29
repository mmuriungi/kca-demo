page 54425 "Work Plan Executive Committee"
{
    ApplicationArea = All;
    Caption = 'Work Plan Executive Committee';
    PageType = List;
    SourceTable = "DepartMent Work Plan";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Divisional PC Approval";
    SourceTableView = where(Incharge = const("Executive committee"), Status = filter(<> Released));
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Incharge; Rec.Incharge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incharge field.';
                }
            }
        }
    }
}
