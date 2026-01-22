page 50273 "Purchase Quote Req. Line"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "PROC-Purchase Quote Line";

    layout
    {
        area(content)
        {
            repeater(_______________)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // OnAfterGetCurrRecord;
    end;

    var
        PurchQHeader: Record "PROC-Purchase Quote Header";
        PParams: Record "PROC-Purchase Quote Params";

    procedure getLineNo(): Integer
    begin
        EXIT(Rec."Line No.");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF Rec."Document No." <> '' THEN BEGIN
            PurchQHeader.RESET;
            PurchQHeader.SETRANGE(PurchQHeader."Document Type", Rec."Document Type");
            PurchQHeader.SETRANGE(PurchQHeader."No.", Rec."No.");
            IF PurchQHeader.Status = PurchQHeader.Status::Open THEN BEGIN
                CurrPage.EDITABLE := TRUE;
            END
            ELSE BEGIN
                CurrPage.EDITABLE := FALSE;
            END;
        END;
    end;
}