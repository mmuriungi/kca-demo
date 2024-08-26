table 51062 "Teaching Practice Header"
{
    Caption = 'Teaching Practice Header';
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
        field(6; Programme; code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(7; "Year of Study"; code[20])
        {
            TableRelation = "ACA-Programme Stages".Code where("Programme Code" = field(Programme));
        }
        field(8; "School"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FACULTY'));
        }
        field(9; "Perriod of TP"; Integer)
        {

        }
        field(10; "Category of School"; text[200])
        {

        }
        field(11; "Subjects Taught"; text[200])
        {

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
            daqaSetups.TestField("Teaching Practice Nos");
            NoSeriesMgnt.InitSeries(daqaSetups."Teaching Practice Nos", daqaSetups."Teaching Practice Nos", Today, "No.", daqaSetups."Teaching Practice Nos");
            "Date Created" := Today;
            "Created By" := UserId;
        end;
    end;
}
