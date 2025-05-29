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
            }
        }
    }
}
