page 50128 "Payment Schedule Line"
{
    Caption = 'Payment Line';
    PageType = ListPart;
    SourceTable = "Payment Schedule Line";

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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field("Payment No"; Rec."Payment No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment No field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Amount field.';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                }
            }
        }
    }
}
