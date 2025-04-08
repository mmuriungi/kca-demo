table 52177880 "Assumptions_Definitions"
{
    Caption = 'Assumptions & Definitions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xrec."No." then begin
                    CreditSetup.get;
                    CreditSetup.TestField("Assumption Nos");
                    NoSeries.TestManual(CreditSetup."Assumption Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(4; "Created Date-Time"; DateTime)
        {
            Caption = 'Created Date-Time';
            DataClassification = ToBeClassified;
        }
        field(5; "No. Series"; code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
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
    var

    begin
        if "No." = '' then begin
            CreditSetup.get;
            CreditSetup.TestField("Assumption Nos");
            NoSeries.InitSeries(CreditSetup."Assumption Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By" := UserId;
        "Created Date-Time" := CurrentDateTime;
    end;

    var
        NoSeries: Codeunit NoSeriesManagement;
        CreditSetup: Record "Credit Management Setup";

}
