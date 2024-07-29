page 50139 "Tax Payment Ledgers"
{
    ApplicationArea = All;
    Caption = 'Tax Payment Ledgers';
    PageType = List;
    SourceTable = "FIN-Tax Payment Ledgers";
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
                field("Vendor  Pv No"; Rec."Vendor  Pv No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor  Pv No field.';
                }
                field("Vendo No"; Rec."Vendo No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendo No field.';
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                }
                field("Tax Type"; Rec."Tax Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Type field.';
                }
            }
        }
    }
}
