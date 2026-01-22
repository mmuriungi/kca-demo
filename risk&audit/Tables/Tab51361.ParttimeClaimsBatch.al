table 51361 "Parttime Claims Batch"
{
    Caption = 'Parttime Claims Batch';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[25])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSeriesManagement.TestManual(GetNoSeriesCode());
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Parttime Claim Header"."Amount to Batch" WHERE("Batch No." = FIELD("No.")));
        }
        field(4; "Claims Count"; Integer)
        {
            Caption = 'Claims Count';
            FieldClass = FlowField;
            CalcFormula = Count("Parttime Claim Header" WHERE("Batch No." = FIELD("No.")));
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(6; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(7; "Pv Generated"; Boolean)
        {
            Caption = 'Pv Generated';
        }
        field(8; Semester; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Global Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Global Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(12; "Shortcut Dimension 3 Code"; Code[30])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the second Shortcut dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(13; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(14; "Invoice Batch Generated"; Boolean)
        {
            Caption = 'Invoice Batch Generated';
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
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesManagement.InitSeries(GetNoSeriesCode(), xRec."No. Series", "Date Created", "No.", "No. Series");
        end;

        if "Date Created" = 0D then
            "Date Created" := Today;

        if "Created By" = '' then
            "Created By" := UserId;
    end;

    var
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        PartClaimSetup: Record "Cash Office Setup";

    procedure AssistEdit(OldClaimBatch: Record "Parttime Claims Batch"): Boolean
    var
        ClaimBatch: Record "Parttime Claims Batch";
    begin
        ClaimBatch := Rec;
        TestNoSeries();
        if NoSeriesManagement.SelectSeries(GetNoSeriesCode(), OldClaimBatch."No. Series", ClaimBatch."No. Series") then begin
            NoSeriesManagement.SetSeries(ClaimBatch."No.");
            Rec := ClaimBatch;
            exit(true);
        end;
    end;

    local procedure TestNoSeries()
    begin
        GetPartTimeClaimSetup();
        PartClaimSetup.TestField("Claim Batch Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        GetPartTimeClaimSetup();
        exit(PartClaimSetup."Claim Batch Nos.");
    end;

    local procedure GetPartTimeClaimSetup()
    begin
        if not PartClaimSetup.Get() then
            PartClaimSetup.Insert();
    end;
}
