page 50131 "Posted Payment Schedule List"
{
    ApplicationArea = All;
    Caption = 'Posted Payment Schedule Listt';
    PageType = List;
    CardPageId = "Payment Schedule";
    SourceTable = "Payment Schedule";
    UsageCategory = Lists;
    SourceTableView = WHERE(Posted = CONST(true));

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
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No field.';
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
