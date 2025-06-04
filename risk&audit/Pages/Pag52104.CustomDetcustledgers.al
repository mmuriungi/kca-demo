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
            // Add this action to your existing actions area in page 52104 "Custom Det cust ledgers"

            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Export detailed customer ledger entries to Excel file';

                trigger OnAction()
                var
                    DetailedCustLedgerCustom: Record "Detailed Cust ledger Custom";
                    ExportXMLPort: XMLport "Export Custom Cust Ledger";
                    FilterText: Text;
                begin
                    // Apply individual filters from the current page
                    DetailedCustLedgerCustom.Reset();

                    // Apply the same default filter as the page
                    DetailedCustLedgerCustom.SetRange("Entry Type", DetailedCustLedgerCustom."Entry Type"::"Initial Entry");

                    // Copy posting date filter if exists
                    FilterText := Rec.GetFilter("Posting Date");
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter("Posting Date", FilterText);

                    // Copy customer number filter if exists
                    FilterText := Rec.GetFilter("Customer No.");
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter("Customer No.", FilterText);

                    // Copy document number filter if exists
                    FilterText := Rec.GetFilter("Document No.");
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter("Document No.", FilterText);

                    // Copy entry type filter if exists (though page defaults to Initial Entry)
                    FilterText := Rec.GetFilter("Entry Type");
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter("Entry Type", FilterText);

                    // Copy posted filter if exists
                    FilterText := Rec.GetFilter(Posted);
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter(Posted, FilterText);

                    // Copy amount filter if exists
                    FilterText := Rec.GetFilter(Amount);
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter(Amount, FilterText);

                    // Copy entry amount filter if exists
                    FilterText := Rec.GetFilter("Entry Amount");
                    if FilterText <> '' then
                        DetailedCustLedgerCustom.SetFilter("Entry Amount", FilterText);

                    // Set the table view for the XMLport
                    ExportXMLPort.SetTableView(DetailedCustLedgerCustom);

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