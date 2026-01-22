table 50108 "FIN-Cheaque Collection Header"
{
    Caption = 'FIN-Cheaque Collection Header';
    DataClassification = ToBeClassified;
    LookupPageId = "FIN-Cheaque Collection List";

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
        field(3; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(4; "Closed"; Boolean)
        {

        }
        field(6; "No. Series"; Code[20])
        {

        }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        GenLedgerSetup: Record 50000;

        NoSeriesMgt: Codeunit 396;

    trigger OnInsert()

    begin
        IF "No." = '' THEN BEGIN
            GenLedgerSetup.GET;

            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Cheque Buffer No");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Cheque Buffer No", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Created By" := UserId;
    END;
}
