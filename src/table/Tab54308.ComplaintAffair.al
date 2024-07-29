table 54308 "Complaint Affair"
{
    Caption = 'Complaint Affair';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CASetup.Get();
                    NoSeriesMgt.TestManual(CASetup."CA Affair No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[20])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Text[20])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }

        field(5; "Complaint Date"; Date)
        {
            Caption = 'Complaint Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Complaint Origin"; Text[250])
        {
            Caption = 'Complaint Origin';
            DataClassification = ToBeClassified;
        }
        field(7; "Complaint Status"; Option)
        {
            Caption = 'Complaint Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,Delegated,Resolved;
        }
        field(8; "Chairman Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Divison Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Committiee Analysis Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Incharge"; Option)
        {
            Caption = 'Incharge';
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = Recording,Division,Chairman,"Complaint Committiee",Complainat,Director,BOD,Resolved;
        }
        field(12; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; Email; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Complainant Channel"; Text[100])
        {
        }
        field(15; "Complainant Contact"; Text[100])
        {
        }
        field(16; "Action Taken"; Text[2048])
        {
        }
        field(17; "Root Cause"; Text[2048])
        {
        }
        field(18; "Corrective Action"; Text[2048])
        {
        }
        field(19; "Process Owner"; Text[50])
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
    trigger OnInsert()
    begin
        if "No." = '' then begin
            CASetup.Get();
            CASetup.TestField("CA Affair No.");
            NoSeriesMgt.InitSeries(CASetup."CA Affair No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        CASetup: Record "Corporate Affairs Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
