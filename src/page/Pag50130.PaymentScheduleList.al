page 50130 "Payment Schedule  List"
{
    ApplicationArea = All;
    Caption = 'Payment Schedule  List';
    PageType = List;
    CardPageId = "Payment Schedule";
    SourceTable = "Payment Schedule";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field("Paying Bank No"; Rec."Paying Bank No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Bank No field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }
}
