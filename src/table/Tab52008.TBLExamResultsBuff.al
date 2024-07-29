table 52008 "TBL Exam Results Buff."
{
    Caption = 'TBL Exam Results Buff.';
    DataClassification = ToBeClassified;
    LookupPageId = "TBL Exam Results Buff.";
    DrillDownPageId = "TBL Exam Results Buff.";

    fields
    {
        field(1; "Semester Code"; Code[20])
        {
            Caption = 'Semester Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = ToBeClassified;
        }
        field(3; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Student Name"; Text[250])
        {
            Caption = 'Student Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Student No.")));
        }

        field(7; "Exam Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                ExamSSetup: Record "ACA-Exams Setup";
            begin
                ExamSSetup.Reset();
                Rec.CalcFields("Exam Category");
                ExamSSetup.SetRange(Category, Rec."Exam Category");
                ExamSSetup.SetFilter("Code", '%1|%2', 'EXAM', 'FINAL EXAM');
                if ExamSSetup.Find('-') then
                    if Rec."Exam Score" > ExamSSetup."Max. Score" then Error('The score MUST NOT Exceed ' + Format(ExamSSetup."Max. Score"));
                Rec."Total Score" := Rec."CAT Score" + Rec."Exam Score";
                Rec."User Code" := UserId;
            end;

        }
        field(8; "CAT Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                ExamSSetup: Record "ACA-Exams Setup";
            begin
                ExamSSetup.Reset();
                Rec.CalcFields("Exam Category");
                ExamSSetup.SetRange(Category, Rec."Exam Category");
                ExamSSetup.SetFilter("Code", '%1|%2', 'CAT', 'CATS');
                if ExamSSetup.Find('-') then
                    if Rec."CAT Score" > ExamSSetup."Max. Score" then Error('CAT Mark MUST NOT Exceed ' + Format(ExamSSetup."Max. Score"));
                Rec."Total Score" := Rec."CAT Score" + Rec."Exam Score";
                Rec."User Code" := UserId;
            end;

        }
        field(9; "Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Lecturer Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Exam Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "CAT Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(13; "User Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Exam FLow"; Decimal)
        {
            Caption = 'Exam FLow';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Aca-exam Results".Score where
            (Semester = field("Semester Code"), "Student No." = field("Student No."),
            Unit = field("Unit Code"), ExamType = filter('Final Exam' | 'Exam')));
        }
        field(15; "CAT FLow"; Decimal)
        {
            Caption = 'CAT FLow';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Aca-exam Results".Score where
            (Semester = field("Semester Code"), "Student No." = field("Student No."),
            Unit = field("Unit Code"), ExamType = filter('CAT' | 'CATS')));
        }
        field(16; "Exam Category"; Code[20])
        {
            Caption = 'Exam Category';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Aca-Programme"."Exam Category" where("Code" = field("Programme Code")));
        }
        field(17; "Overal Score Flow"; Decimal)
        {
            Caption = 'Overal Score Flow';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Aca-exam Results".Score where
            (Semester = field("Semester Code"), "Student No." = field("Student No."),
            Unit = field("Unit Code")));
        }
        field(18; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("ACA-Exam Results" where
             (Semester = field("Semester Code"),
             "Student No." = field("Student No."),
             Unit = field("Unit Code"),
             "User Code" = field("User Code")));
        }
        field(19; "Exists Same Marks"; Boolean)
        {
            Caption = 'Exists Same Marks';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("TBL Exam Results Buff." where
            ("Semester Code" = field("Semester Code"),
             "Student No." = field("Student No."),
             "Unit Code" = field("Unit Code"),
             "CAT FLow" = field("CAT Score"),
             "Exam FLow" = field("Exam Score")));
        }
        field(20; "Lecturer Posted Marks"; Boolean)
        {
            Caption = 'Lecturer Posted Marks';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("TBL Exam Results Buff." where
            ("Semester Code" = field("Semester Code"),
             "Student No." = field("Student No."),
             "Unit Code" = field("Unit Code"), "Exists Same Marks" = filter(true), Posted = filter(true),
            "User Code" = filter(<> '')));
        }





    }
    keys
    {
        key(PK; "Semester Code", "Programme Code", "Unit Code", "Student No.")
        {
            Clustered = true;
        }
    }
}
