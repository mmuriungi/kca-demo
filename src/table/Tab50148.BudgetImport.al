table 50148 "Budget Import"
{
    Caption = 'Budget Import';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Budget Buffer List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "G/L Account"."No.";
        }
        field(2; "Budget Name"; Code[20])
        {
            Caption = 'Budget Name';


            TableRelation = "G/L Budget Name";
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(4; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';

        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {

            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "No. Series"; code[20])
        {

        }
        field(10; posted; Boolean)
        {

        }
        field(11; "Budget Amount"; Decimal)
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
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        //IF "Payment Type" = "Payment Type"::Imprest THEN BEGIN
        GenLedgerSetup.get;
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."Budget Nos");
        NoSeriesMgt.InitSeries(GenLedgerSetup."Budget Nos", xRec."No. Series", 0D, "No.", "No. Series");
        "Document Date" := Today;
        "Created By" := UserId;
        // "Global Dimension 1 Code" := 'MAIN';
        // "Global Dimension 2 Code" := 'CENTRAL VOTE';
        //END
    END;

}
