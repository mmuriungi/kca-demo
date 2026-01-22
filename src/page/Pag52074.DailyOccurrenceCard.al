page 52074 "Daily Occurrence Card"
{
    ApplicationArea = All;
    Caption = 'Daily Occurrence Card';
    PageType = Card;
    SourceTable = "Daily Occurrence Book";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("OB No."; Rec."OB No.")
                {
                    ToolTip = 'Specifies the value of the OB No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Recorded By"; Rec."Recorded By")
                {
                    ToolTip = 'Specifies the value of the Recorded By field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Incident")
            {
                ApplicationArea = All;
                Promoted = true;
                RunObject = page "Incident Report Card";
                RunPageLink = "OB No." = field("OB No.");
                // trigger OnAction()
                // var
                //     Incident: Record "Incident Report";
                // begin

                // end;
            }
        }
    }
}
