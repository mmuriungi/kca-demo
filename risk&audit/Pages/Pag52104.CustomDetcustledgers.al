// Modify the existing page
page 52104 "Custom Det cust ledgers"
{

    ApplicationArea = All;
    Caption = 'Custom Det cust ledgers';
    PageType = List;
    SourceTable = "Detailed Cust ledger Custom";
    UsageCategory = Administration;
    // SourceTableView = sorting("Posting Date") where("Entry Type" = const("Initial Entry"));

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
                field("Normalized Document No."; Rec."Normalized Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Normalized Document No. field.', Comment = '%';
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
                field("Entry Amount"; Rec."Entry Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Entry Amount field.', Comment = '%';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            // Add this action to your existing actions area in page 52104 "Custom Det cust ledgers"

            action(ExportToXML)
            {
                ApplicationArea = All;
                Caption = 'Export to XML';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Export customer ledger entries to XML file with date filter.';

                trigger OnAction()
                var
                    ExportXMLPort: XMLport "Export Custom Cust Ledger";
                begin
                    ExportXMLPort.Run();
                end;
            }
            action(PostWithDateFilter)
            {
                ApplicationArea = All;
                Caption = 'Post Initial Entries with Date Filter';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post Initial Entry records within a date range to the general journal.';

                trigger OnAction()
                var
                    PostCustomCustLedger: Codeunit "Post Custom Cust Ledger";
                begin
                    PostCustomCustLedger.Run();
                end;
            }
        }
    }
}