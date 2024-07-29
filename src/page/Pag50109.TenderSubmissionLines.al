page 50109 "Tender Submission Lines"
{
    PageType = ListPart;
    SourceTable = "Tender Submission Lines";

    layout
    {
        area(content)
        {
            repeater(_______________)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Visible = true;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Visible = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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