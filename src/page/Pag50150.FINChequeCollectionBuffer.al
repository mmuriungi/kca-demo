page 50150 "FIN-Cheque Collection Buffer "
{
    Caption = 'FIN-Cheque Collection Buffer ';
    PageType = ListPart;
    SourceTable = "FIN-Collection  Header Buffer";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No field.';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee Name field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("TIME"; Rec."TIME")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TIME field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
