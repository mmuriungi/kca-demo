page 50288 "Eft Batch List"
{
    ApplicationArea = All;
    Caption = 'Eft Batch List';
    PageType = List;
    CardPageId = "EFT Card";
    SourceTable = "EFT Batch Header";
    UsageCategory = Administration;

    layout
    {
        area(content)
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
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.', Comment = '%';
                }
            }
        }
    }
}
