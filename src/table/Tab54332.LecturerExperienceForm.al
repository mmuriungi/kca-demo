table 54332 "Lecturer Experience Form"
{
    Caption = 'Lecturer Experience Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "PF No."; Code[20])
        {
            Caption = 'PF No.';
            TableRelation = "HRM-Employee C" where(Lecturer = const(true));
            trigger OnValidate()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", "PF No.");
                if hrEmp.Find('-') then begin
                    Rec.Name := hrEmp."First Name" + ' ' + hrEmp."Middle Name" + ' ' + hrEmp."Last Name";
                    Rec.Departmement := hrEmp."Department Code";
                    Rec.School := hrEmp."Faculty Code";
                end
            end;
        }
        field(3; Name; text[200])
        {
            Caption = 'Name';
        }
        field(4; Departmement; Code[20])
        {
            Caption = 'Departmement';
            TableRelation = "Dimension Value".code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(5; School; Code[20])
        {
            Caption = 'School';
            TableRelation = "Dimension Value".code where("Dimension Code" = const('FACULTY'));
        }
        field(6; Semester; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year";
        }
        field(8; "Date Created"; Date)
        {

        }

    }
    keys
    {
        key(PK; "No.", "PF No.", Semester)
        {
            Clustered = true;
        }
    }
    var
        hrEmp: Record "HRM-Employee C";

    trigger OnInsert()
    var
        daqaSetups: Record "DAQA Setups";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            daqaSetups.Get();
            daqaSetups.TestField("Lecturer Experience Nos");
            NoSeriesMgnt.InitSeries(daqaSetups."Lecturer Experience Nos", daqaSetups."Lecturer Experience Nos", Today, "No.", daqaSetups."Lecturer Experience Nos");
            "Date Created" := Today;
        end;
    end;
}
