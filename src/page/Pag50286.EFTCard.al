page 50286 "EFT Card"
{
    Caption = 'EFT Card';
    PageType = Card;
    SourceTable = "EFT Batch Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            part(batchLine; "Eft Batch Line")
            {
                SubPageLink = "Doc No" = field("No.");
                ApplicationArea = all;


            }

        }
    }
}
