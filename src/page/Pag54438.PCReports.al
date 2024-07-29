page 54438 "PC Reports"
{
    Caption = 'PC Reports';
    CardPageId = "PC Report Card";
    PageType = List;
    SourceTable = "PC Reports";
    UsageCategory = Lists;
    InsertAllowed = true;

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
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Plan Year"; Rec."Plan Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Year field.';
                }
                field(Quarter; Rec.Quarter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quarter field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }

            }
        }
    }
}

