table 51072 "Lec Take Off"
{
    Caption = 'Lec Take Off';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {

        }
        field(2; "Semester"; code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(3; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(4; "Date Created"; Date)
        {

        }
        field(5; "Created By"; code[20])
        {

        }
    }
    keys
    {
        key(PK; "No.", Semester, "Date Created")
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
            daqaSetups.TestField("Lec TakeOff Nos");
            NoSeriesMgnt.InitSeries(daqaSetups."Lec TakeOff Nos", daqaSetups."Lec TakeOff Nos", Today, "No.", daqaSetups."Lec TakeOff Nos");
            "Date Created" := Today;
            "Created By" := UserId;
        end;
    end;
}
