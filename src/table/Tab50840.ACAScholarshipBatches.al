table 50840 "ACA-Scholarship Batches"
{

    DrillDownPageId = "ACA-Scholarship Batches";
    LookupPageId = "ACA-Scholarship Batches";

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "No." = '' then begin
                    genSetUp.Get();
                    genSetUp.TestField("Scholarship Nos.");
                    noseries.TestManual(genSetUp."Scholarship Nos.");
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // genSetUp.Get();
                // genSetUp.TestField("Scholarship Nos.");
                // "No." := noseries.GetNextNo(genSetUp."Scholarship Nos.", TODAY, TRUE);
                //Rec."Batch No." := "No.";
                //Rec.Modify();
            end;
        }
        field(3; "Scholarship Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Scholarships".Code where(Status = filter(Active));

            trigger OnValidate()
            var
                scholarships: Record "ACA-Scholarships";

            begin

                scholarships.Reset();
                scholarships.SetRange(Code, "Scholarship Code");
                if scholarships.FindFirst() then begin
                    "Scholarship Name" := scholarships."Scholarship Name";
                    "Scholarship Type" := scholarships."Scholarship Category";
                    Rec."G/L Account" := scholarships."G/L Account";

                end;
                // if Rec."Scholarship Code" = 'STAFF' then
                //     enabled := false;
                "Document Date" := Today;
                Validate("Document Date");


            end;
        }
        field(4; "Scholarship Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Scholarship Type"; Option)
        {
            OptionMembers = " ","Internal","External";
        }
        field(6; "No. of Students "; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("ACA-Imp. Receipts Buffer" WHERE("Transaction Code" = field("No.")));
            Editable = false;
        }
        field(7; "Batch No."; Code[20])
        {
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(8; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Receipt Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Allocated Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("ACA-Imp. Receipts Buffer".Amount WHERE("Transaction Code" = field("No.")));
            Editable = false;

        }
        field(11; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(12; "Semester"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(13; "Semester Code"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(14; "Bank Code"; Code[20])
        {
            Caption = 'Allocating Bank Account';
            TableRelation = "Bank Account";
        }
        field(15; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(16; "Receipt No"; Code[20])
        {
            TableRelation = "FIN-Receipts Header"."No.";
            trigger OnValidate()
            var
                Receipts: record "FIN-Receipts Header";
            begin
                Receipts.Reset();
                Receipts.SetRange("No.", "Receipt No");
                if Receipts.FindFirst() then begin
                    Receipts.CalcFields("Total Batch Allocation");
                    "Receipt Amount" := Receipts."Amount Recieved";
                    "Unallocated Amount" := Receipts."Amount Recieved" - Receipts."Total Batch Allocation";
                end;
            end;
        }
        field(17; "Status"; Option)
        {
            OptionMembers = " ",Active,Inactive;
        }
        field(18; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "created by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //Unallocated Amount
        field(20; "Unallocated Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Batch No.")
        {

        }

    }

    var
        genSetUp: Record "ACA-General Set-Up";
        noseries: Codeunit NoSeriesManagement;
        pagie: Record "Purchase Header";
        enabled: Boolean;
        GenLedgerSetup: record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            GenLedgerSetup.Get();

            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Scholarship Nos.");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Scholarship Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        Rec."Document Date" := Today;
        Rec."created by" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}