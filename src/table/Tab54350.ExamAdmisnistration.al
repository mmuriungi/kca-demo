table 54350 "Exam Admisnistration"
{
    Caption = 'Exam Admisnistration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Semester; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year";
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(5; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
    }
    keys
    {
        key(PK; "No.", Semester, "Academic Year")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        daqaSetups: Record "DAQA Setups";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            daqaSetups.Get();
            daqaSetups.TestField("Exam Admin Nos");
            NoSeriesMgnt.InitSeries(daqaSetups."Exam Admin Nos", daqaSetups."Exam Admin Nos", Today, "No.", daqaSetups."Exam Admin Nos");
            "Date Created" := Today;
            "Created By" := UserId;
        end;
    end;
}
