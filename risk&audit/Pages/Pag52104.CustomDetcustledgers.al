// Modify the existing page
page 52104 "Custom Det cust ledgers"
{
    ApplicationArea = All;
    Caption = 'Custom Det cust ledgers';
    PageType = List;
    SourceTable = "Detailed Cust ledger Custom";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostAllRecords)
            {
                ApplicationArea = All;
                Caption = 'Post All Records';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post all records to the general journal without any filters.';

                trigger OnAction()
                var
                    PostAllCustLedgerEntries: Codeunit "Post Custom Cust Ledger";
                begin
                    PostAllCustLedgerEntries.Run();
                end;
            }
        }
    }
}