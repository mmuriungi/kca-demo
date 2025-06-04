// Modify the existing page
page 52104 "Custom Det cust ledgers"
{

    ApplicationArea = All;
    Caption = 'Custom Det cust ledgers';
    PageType = List;
    SourceTable = "Detailed Cust ledger Custom";
    UsageCategory = Administration;
    SourceTableView = sorting("Posting Date") where("Entry Type" = const("Initial Entry"));

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
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Export customer ledger entries to Excel file';

                trigger OnAction()
                var
                    CustLedgerEntriesCustom: Record "Cust Ledger Entries Custom";
                    ExportXMLPort: XMLport "Export Custom Cust Ledger";
                begin
                    // Apply current page filters to the export
                    CustLedgerEntriesCustom.CopyFilters(Rec);

                    // Set the table view for the XMLport
                    ExportXMLPort.SetTableView(CustLedgerEntriesCustom);

                    // Run the XMLport
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