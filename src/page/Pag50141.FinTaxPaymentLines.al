page 50141 "Fin-Tax Payment Lines "
{
    Caption = 'Fin-Tax Payment Lines ';
    PageType = ListPart;
    SourceTable = "FIN-Payment Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;

                }
                field("Tax Type"; Rec."Tax Type")
                {
                    ApplicationArea = all;

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Tax Account No"; Rec."Tax Account No")
                {
                    ApplicationArea = all;
                }
                field("Vendor pv"; Rec."Vendor pv")
                {
                    ApplicationArea = all;

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                    Editable = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
    }
    procedure GetDocNo(): Code[20]
    begin
        //EXIT("Inv Doc No");
    end;
}
