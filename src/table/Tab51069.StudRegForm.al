table 51069 "Stud Reg Form"
{
    Caption = 'Stud Reg Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            //Caption = '';
        }
        field(2; "Created By"; Code[20])
        {

        }
        field(3; "Date Created"; Date)
        {

        }
        field(4; Semester; code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(5; "Degree Program"; code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(6; "Acdemic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
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
        daqaSetups: Record "DAQA Setups";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            daqaSetups.Get();
            daqaSetups.TestField("Orientation Nos");
            NoSeriesMgnt.InitSeries(daqaSetups."Orientation Nos", daqaSetups."Orientation Nos", Today, "No.", daqaSetups."Orientation Nos");
            "Date Created" := Today;
            "Created By" := UserId;
        end;
    end;
}
