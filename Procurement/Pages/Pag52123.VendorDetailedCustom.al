page 52123 "Vendor Detailed Custom"
{
    ApplicationArea = All;
    Caption = 'Vendor Detailed Custom';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "custom detail vend ledgers";

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(ExportToXML)
            {
                ApplicationArea = All;
                Caption = 'Export to XML Cust ledgers';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Export Vendor ledger entries to XML file with date filter.';

                trigger OnAction()
                var
                    ExportXMLPort: XMLport "Export Vendor";
                begin
                    ExportXMLPort.Run();
                end;
            }
        }
    }
}
