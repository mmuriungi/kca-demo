table 51390 "Journal Voucher Headder"
{
    Caption = 'Journal Voucher Headder';
    DataClassification = ToBeClassified;
    DrillDownPageId = "journal voucher list";
    LookupPageId = "journal voucher list";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(5; "Posted "; Boolean)
        {
            Caption = 'Posted ';
        }
        field(6; Status; Option)
        {

            OptionMembers = Pending,Open,"Pending Approval",Approved,Cancelled,Released,Posted;
        }
        field(7; JournalLinesExist; Boolean)
        {

        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(12; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {

            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }
        field(10; "Shortcut Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }
        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = SUM("Journal Voucher Lines".Amount WHERE("Docuument No" = field("No.")));
        }
        //Reversed
        field(13; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        //"Reversed By"
        field(14; "Reversed By"; Code[20])
        {
            Caption = 'Reversed By';
        }
        //"Reversed Date"
        field(15; "Reversed Date"; Date)
        {
            Caption = 'Reversed Date';
        }
        field(16; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
        }
        field(17; "Bank Account No"; code[20])
        {

        }
        field(18; "Claimed By"; Code[20])
        {
            Caption = 'Claimed By';
        }



    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        GenLedgerSetup.Reset();
        GenLedgerSetup.SetRange("Primary Key", '1');
        if GenLedgerSetup.Find('-') then begin

            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Journal Vouchers");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Journal Vouchers", xRec."No. Series", 0D, rec."No.", rec."No. Series");
        END;
        Rec."Created By" := USERID;
        Rec."Document Date" := Today;
    end;

    procedure JournalLinesExist(): Boolean
    begin
        PvLine.RESET;
        // PvLine.SETRANGE("Payment Type", "Payment Type");
        PvLine.SETRANGE(PvLine."Docuument No", "No.");
        EXIT(PvLine.FINDFIRST);
    end;

    procedure UpdateLines()
    begin
        PvLine.RESET;
        PvLine.SETRANGE(PvLine."Docuument No", Rec."No.");
        IF PvLine.FINDFIRST THEN BEGIN
            REPEAT
                PvLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                PvLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";

                PvLine.MODIFY;
            UNTIL PvLine.NEXT = 0;
        END;
    end;

    trigger OnModify()
    begin
        UpdateLines();
    end;

    var
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit 396;
        PvLine: Record "Journal Voucher Lines";
}
