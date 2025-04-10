table 51353 "Supp. Exam Units"
{
    Caption = 'Supp. Exam Units';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Semester; Code[25])
        {
            Caption = 'Semester';
            tableRelation = "ACA-Semesters";
        }
        field(2; Programme; Code[25])
        {
            Caption = 'Programme';
            tableRelation = "ACA-Programme";
        }
        field(3; "Unit Code"; Code[25])
        {
            Caption = 'Unit Code';
            tableRelation = "ACA-Units/Subjects";
        }
        field(4; "Lecturer Code"; Code[25])
        {
            Caption = 'Lecturer Code';
            tableRelation = "HRM-Employee C" where(Lecturer = const(true));
        }
        field(5; "Student Allocation"; Integer)
        {
            Caption = 'Student Allocation';
        }
        //Stage
        field(6; "Stage Code"; Code[25])
        {
            Caption = 'Stage Code';
            // tableRelation = "ACA-Programme Stages";
        }
        field(54; "Department Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Programme"."Department Code" where(Code = field(Programme)));
        }
    }
    keys
    {
        key(PK; Semester, Programme, "Unit Code", "Stage Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LEcUnits: Record "ACA-Lecturers Units";
    begin
        LEcUnits.reset;
        LEcUnits.SetRange(Programme, Programme);
        LEcUnits.SetRange("Unit", "Unit Code");
        LEcUnits.SetRange("Semester", Semester);
        LEcUnits.SetRange(Stage, "Stage Code");
        if LEcUnits.findfirst then
            "Lecturer Code" := LEcUnits."Lecturer";
        
    end;
}
