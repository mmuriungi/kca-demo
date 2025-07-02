page 52126 "Nav Vendor Ledger List"
{
    ApplicationArea = All;
    Caption = 'Nav Vendor Ledger List';
    PageType = List;
    SourceTable = "Nav Vendor Ledger";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("BC Ledger Amount"; Rec."BC Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Ledger Amount field.';
                }
                field("Nav GL Ledger Amount"; Rec."Nav GL Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nav GL Ledger Amount field.';
                }
                field("BC GL Ledger Amount"; Rec."BC GL Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC GL Ledger Amount field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import")
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = ImportExcel;
                ToolTip = 'Import data from CSV file';

                trigger OnAction()
                begin
                    Xmlport.Run(50216, true, true);
                end;
            }
            action("Export")
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = ExportFile;
                ToolTip = 'Export data to CSV file';

                trigger OnAction()
                begin
                    Xmlport.Run(50216, false, true);
                end;
            }
        }
    }
}