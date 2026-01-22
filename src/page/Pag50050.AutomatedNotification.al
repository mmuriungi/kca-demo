page 50050 "Automated Notification"
{
    ApplicationArea = All;
    Caption = 'Automated Notification';
    PageType = Card;
    SourceTable = "Automated Notification Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ToolTip = 'Specifies the value of the Notification Type field.', Comment = '%';
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.', Comment = '%';
                }
                field("Notification Message"; Rec."Notification Message")
                {
                    ToolTip = 'Specifies the value of the Notification Message field.', Comment = '%';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.', Comment = '%';
                }
            }
        }
    }
}
