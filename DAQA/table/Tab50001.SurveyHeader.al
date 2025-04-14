table 50143 "Survey Header"
{
    Caption = 'Survey Header';
    DataClassification = ToBeClassified;

    fields

    {
        field(1; "Survey Code"; Code[20])
        {
            Caption = 'Survey Code';

            trigger OnValidate()
            begin
                if "Survey Code" <> xRec."Survey Code" then begin
                    QualitySetup.Get();
                    NoSeriesMgt.TestManual(QualitySetup."Survey Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(5; Status; Enum "Survey Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(6; "Survey Type"; Enum "Survey Type")
        {
            Caption = 'Survey Type';
        }
        //Project No.
        field(7; "Semester Code"; Code[20])
        {
            Caption = 'Semester Code';
            TableRelation = "ACA-Semesters";
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        //Applies to
        field(9; "Applies To"; Option)
        {
            Caption = 'Applies To';
            OptionMembers = "All Students","Specific Students";
        }
    }

    keys
    {
        key(PK; "Survey Code", "Semester Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Survey Code" = '' then begin
            QualitySetup.Get();
            QualitySetup.TestField("Survey Nos.");
            NoSeriesMgt.InitSeries(QualitySetup."Survey Nos.", xRec."No. Series", 0D, "Survey Code", "No. Series");
        end;
    end;

    procedure AssistEdit(): Boolean
    var
        SurveyHeader: Record "Survey Header";
    begin
        SurveyHeader := Rec;
        QualitySetup.Get();
        QualitySetup.TestField("Survey Nos.");
        if NoSeriesMgt.SelectSeries(QualitySetup."Survey Nos.", xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("Survey Code");
            Rec := SurveyHeader;
            exit(true);
        end;
    end;

    var
        QualitySetup: Record "Quality Assurance Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}