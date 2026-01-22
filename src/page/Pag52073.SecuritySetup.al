page 52073 "Security Setup"
{
    ApplicationArea = All;
    Caption = 'Security Setup';
    PageType = Card;
    SourceTable = "Security Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Incident Nos"; Rec."Incident Nos")
                {
                    ToolTip = 'Specifies the value of the Incident Nos field.', Comment = '%';
                }
                field("Guest Nos"; Rec."Guest Nos")
                {
                    ToolTip = 'Specifies the value of the Guest Nos field.', Comment = '%';
                }
                field("Daily OB Nos"; Rec."Daily OB Nos")
                {
                    ToolTip = 'Specifies the value of the Daily OB Nos field.', Comment = '%';
                }
            }
        }
    }
}
