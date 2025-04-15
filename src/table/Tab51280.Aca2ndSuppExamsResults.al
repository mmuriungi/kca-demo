table 51280 "Aca-2nd Supp. Exams Results"
{
    Caption = 'Aca-2nd Supp. Exams Results';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Programme; Code[20])
        {
            Caption = 'Programme';
        }
        field(2; Stage; Code[50])
        {
            Caption = 'Stage';
        }
        field(3; Unit; Code[50])
        {
            Caption = 'Unit';
        }
        field(4; Semester; Code[50])
        {
            Caption = 'Semester';
        }
        field(5; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(6; Exam; Code[50])
        {
            Caption = 'Exam';
        }
        field(7; "Reg. Transaction ID"; Code[50])
        {
            Caption = 'Reg. Transaction ID';
        }
        field(8; "Student No."; Code[30])
        {
            Caption = 'Student No.';
        }
        field(9; Grade; Code[50])
        {
            Caption = 'Grade';
        }
        field(10; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(11; Contributions; Decimal)
        {
            Caption = 'Contributions';
        }
        field(18; "Exam Category"; Code[50])
        {
            Caption = 'Exam Category';
        }
        field(19; ExamType; Code[50])
        {
            Caption = 'Exam Type';
        }
        field(20; "Admission No"; Code[50])
        {
            Caption = 'Admission No';
        }
        field(22; Reported; Boolean)
        {
            Caption = 'Reported';
        }
        field(23; "Lecturer Names"; Text[250])
        {
            Caption = 'Lecturer Names';
        }
        field(24; UserID; Code[50])
        {
            Caption = 'User ID';
        }
        field(50018; "Academic Year"; Code[50])
        {
            Caption = 'Academic Year';
        }
        field(50019; "Exam Session"; Code[10])
        {
            Caption = 'Exam Session';
        }
        field(50020; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " ",Special,Supplementary;
        }
        field(50021; "Current Academic Year"; Code[20])
        {
            Caption = 'Current Academic Year';
        }
        field(50022; "Capture Date"; Date)
        {
            Caption = 'Capture Date';
        }
        field(50023; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
        }
        field(50024; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
        }
        field(50025; "Modified By Name"; Text[250])
        {
            Caption = 'Modified By Name';
        }
    }

    keys
    {
        key(PK; Programme, Stage, Unit, Semester, "Student No.", "Academic Year")
        {
            Clustered = true;
        }
    }

    var
        SExams: Record "ACA-Exams Setup";
        Gradings: Record "ACA-Exam Gradding Setup";
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record "ACA-Exam Gradding Setup";
        EResults: Record "ACA-Exam Results";
        Exams: Record "ACA-Exams Setup";
        Course_Reg: Record "ACA-Course Registration";
        stud_Units: Record "ACA-Student Units";
        prog: Record "ACA-Programme";
        Course_Reg2: Record "ACA-Course Registration";
        stud_Units2: Record "ACA-Student Units";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAExamCategory: Record "ACA-Exam Category";

    procedure GetGrade(CAT1: Decimal; CAT2: Decimal; FinalM: Decimal; progz: Code[100]) xGrade: Code[20]
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastRemark: Code[20];
        GLabel: Code[20];
        i: Integer;
        GLabel2: Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        GradeCategory: Code[50];
        Marks: Decimal;
    begin
        GradeCategory := '';
        Clear(Marks);
        Gradings.Reset();
        Marks := CAT1 + CAT2 + FinalM;
        ProgrammeRec.Reset();
        if ProgrammeRec.Get(progz) then
            GradeCategory := ProgrammeRec."Exam Category";
        if GradeCategory = '' then
            GradeCategory := 'DEFAULT';
        xGrade := '';
        if Marks > 0 then begin
            if GradeCategory = '' then
                Gradings.SetRange(Gradings.Category, 'DEFAULT')
            else
                Gradings.SetRange(Gradings.Category, ProgrammeRec."Exam Category");
            Gradings.SetFilter("Lower Limit", '=%1|<%2', Marks, Marks);
            Gradings.SetFilter("Upper Limit", '=%1|>%2', Marks, Marks);
            if Gradings.FindFirst() then begin
                xGrade := Gradings.Grade;
            end;
        end else begin
            xGrade := '';
        end;
    end;
}