page 50049 "Automated Notification Setup"
{
    ApplicationArea = All;
    CardPageId = "Automated Notification";
    Caption = 'Automated Notification Setup';
    PageType = List;
    SourceTable = "Automated Notification Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.', Comment = '%';
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ToolTip = 'Specifies the value of the Notification Type field.', Comment = '%';
                }
            }
        }
    }
}
