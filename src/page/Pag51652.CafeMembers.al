page 51652 "Cafe Members"
{
    Caption = 'Cafe Members';
    PageType = List;
    SourceTable = "Cafe Members";
    CardPageId = "Members Registration Card";

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
                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Names field.', Comment = '%';
                }
                field("Card Serial"; Rec."Card Serial")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Card Serial field.', Comment = '%';
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Type field.', Comment = '%';
                }
                field("Cafe Balance"; Rec."Cafe Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cafe Balance field.', Comment = '%';
                }
            }
        }
    }
}
