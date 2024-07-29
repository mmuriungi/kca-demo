table 52036 "Buffer Exam Header"
{
    Caption = 'Buffer Exam Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

        }
        field(2; Programme; Code[20])
        {
            Caption = 'Programme';
            TableRelation = "ACA-Programme";
        }
        field(3; Semester; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(4; "Verified By"; Code[20])
        {
            Caption = 'Verified By';
        }
        field(5; "Date Verified"; Date)
        {
            Caption = 'Date Verified';
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Pending Verification","Verified";
        }
    }
    keys
    {
        key(PK; "No.", Semester, Programme)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        genSetups: Record "ACA-General Set-Up";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            genSetups.Get();
            genSetups.TestField("Exam Buffer Nos");
            NoSeriesMgnt.InitSeries(genSetups."Exam Buffer Nos", genSetups."Exam Buffer Nos", Today, "No.", genSetups."Exam Buffer Nos");
            "Verified By" := UserId;
            "Date Verified" := Today;
        end;
    end;
}
