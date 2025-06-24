page 52129 "BC GL Ledger List"
{
    ApplicationArea = All;
    Caption = 'BC GL Ledger List';
    PageType = List;
    SourceTable = "BC GL Ledger";
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
                field("Nav Ledger Amount"; Rec."Nav Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nav Ledger Amount field.';
                }
                field("Nav Vendor Ledger Amount"; Rec."Nav Vendor Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nav Vendor Ledger Amount field.';
                }
                field("Nav GL Ledger Amount"; Rec."Nav GL Ledger Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nav GL Ledger Amount field.';
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
                    Xmlport.Run(50219, true, true);
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
                    Xmlport.Run(50219, false, true);
                end;
            }
            action("PopulateFromGLEntry")
            {
                ApplicationArea = All;
                Caption = 'Populate from G/L Entry';
                Image = TransferToGeneralJournal;
                ToolTip = 'Populate BC GL Ledger from G/L Entry table with filters';
                
                trigger OnAction()
                begin
                    Report.Run(Report::"Populate BC GL Ledger", true, false);
                end;
            }
        }
    }
}