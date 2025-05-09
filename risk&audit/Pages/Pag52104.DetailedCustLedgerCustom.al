page 52104 "Detailed Cust Ledger Custom"
{
    ApplicationArea = All;
    Caption = 'Detailed Cust Ledger Custom';
    PageType = List;
    SourceTable = "Detailed Cust ledger Custom";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Source Code Description"; Rec."Source Code Description")
                {
                    ToolTip = 'Specifies the value of the Source Code Description field.', Comment = '%';
                }
                field("Cust. Ledger Entry No."; Rec."Cust. Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Cust. Ledger Entry No. field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PostToGL)
            {
                ApplicationArea = All;
                Caption = 'Post to G/L';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post unposted entries to General Ledger';

                trigger OnAction()
                var
                    PostCustLedgerReport: Report "Post Customer Ledger Entries";
                begin
                    PostCustLedgerReport.RunModal();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
