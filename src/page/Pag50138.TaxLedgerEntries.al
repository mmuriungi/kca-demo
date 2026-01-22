page 50138 "Tax  Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Tax  Ledger Entries';
    PageType = List;
    SourceTable = "Fin-Witholding Tax Ledges";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tax Pv No"; Rec."Tax Pv No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Pv No field.';
                }
                field("Entry No"; rEC."Entry No")
                {
                    ApplicationArea = ALL;
                    Visible = false;
                }

                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = all;
                    Caption = 'Paye No';

                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                    Caption = 'Paye Name';
                }
                field("Tax Type"; Rec."Tax Type")
                {
                    ApplicationArea = all;

                }
                field("Vendor Pv No"; Rec."Vendor Pv No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Pv No field.';
                    Caption = 'Paye Pv No';
                }

                field("Gl No"; Rec."Gl No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gl No field.';
                    Caption = 'VoteHead';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field("Net  Amount"; Rec."Net  Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net  Amount field.';
                }
                field("Vat Amount"; Rec."Vat Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vat Amount field.';
                }
                field("Vat Withold"; Rec."Vat Withold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vat Withold field.';
                    Caption = 'Vat Witheld';
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                }
                field("Pin No"; Rec."Pin No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pin No field.';
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                }
            }
        }
    }
}
