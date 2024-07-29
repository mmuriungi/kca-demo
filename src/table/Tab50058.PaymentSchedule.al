table 50058 "Payment Schedule"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Paying Bank No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." WHERE("Bank Type" = CONST(Normal));

            trigger OnValidate()
            begin
                IF BankRec.GET("Paying Bank No") THEN BEGIN
                    BankRec.TESTFIELD("Last Check No.");
                    "Cheque No" := INCSTR(BankRec."Last Check No.");
                    //"Cheque Format":=BankRec."Cheque Format";
                END;
            end;
        }
        field(4; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Schedule Line"."Cheque Amount" WHERE(No = FIELD(No)));
            FieldClass = FlowField;
        }
        field(5; Payee; Text[150])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Payee := UPPERCASE(Payee);
            end;
        }
        field(6; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Pending Approval,Approved';
            OptionMembers = Pending,"Pending Approval",Approved;
        }
        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Posting Dated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Cheque Format"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Kalamazoo Format,Plain Format';
            OptionMembers = "Kalamazoo Format","Plain Format";
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF No = '' THEN BEGIN
            GenLedgerSetup.GET;
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Payment Schedule No.");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Payment Schedule No.", xRec."No. Series", 0D, No, "No. Series");
        END
    end;

    var
        NoSeriesMgt: Codeunit 396;
        GenLedgerSetup: Record "Cash Office Setup";
        BankRec: Record 270;
}

