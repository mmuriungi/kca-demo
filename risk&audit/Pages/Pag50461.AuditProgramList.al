page 50461 "Audit Program List"
{
    ApplicationArea = All;
    Caption = 'Audit Program List';
    CardPageId = "Audit Program";
    PageType = List;
    SourceTable = "Audit Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Audit Plan No."; Rec."Audit Plan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Plan No. field.', Comment = '%';
                }
            }
        }
    }
}
