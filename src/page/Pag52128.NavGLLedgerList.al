page 52128 "Nav GL Ledger List"
{
    ApplicationArea = All;
    Caption = 'Nav GL Ledger List';
    PageType = List;
    SourceTable = "Nav GL Ledger";
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
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
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
                field("BC Vendor Ledger Amount"; Rec."BC Vendor Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Vendor Ledger Amount field.';
                }
                field("Nav Vendor Ledger Amount"; Rec."Nav Vendor Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nav Vendor Ledger Amount field.';
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
                    Xmlport.Run(50218, true, true);
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
                    Xmlport.Run(50218, false, true);
                end;
            }
        }
    }
}