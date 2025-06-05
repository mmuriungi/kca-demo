page 52114 "General Ledgers Custom"
{
    ApplicationArea = All;
    Caption = 'General Ledgers Custom';
    PageType = List;
    SourceTable = "G/L Entry custom";
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of the G/L Account No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount (LCY) field.', Comment = '%';
                }
                field(Totalamount; Rec.Totalamount)
                {
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies whether the entry is reversed.', Comment = '%';
                }
                field("Ledger Amount"; Rec."Ledger Amount")
                {
                    ToolTip = 'Specifies the value of the Ledger Amount field.', Comment = '%';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.', Comment = '%';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.', Comment = '%';
                }
                field(EntryCount; Rec.EntryCount)
                {
                    ToolTip = 'Specifies the value of the Entry Count field.', Comment = '%';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ToolTip = 'Specifies whether the entry was created by the system.', Comment = '%';
                }
                // field("System Created Entry"; Rec."System Created Entry")
                // {
                //  Caption = 'System Created Entry Bc';
                //  ToolTip = 'Specifies whether the entry was created by the system.', Comment = '%';
                //}


            }
        }
    }
}
