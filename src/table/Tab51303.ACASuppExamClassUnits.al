table 51303 "ACA-SuppExam Class. Units"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Programme"; Code[20])
        {
            Caption = 'Programme';
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Credit Hours"; Decimal)
        {
            Caption = 'Credit Hours';
            DataClassification = ToBeClassified;
        }
        field(6; "CAT Score"; Code[20])
        {
            Caption = 'CAT Score';
            DataClassification = ToBeClassified;
        }
        field(7; "Exam Score"; Code[20])
        {
            Caption = 'Exam Score';
            DataClassification = ToBeClassified;
        }
        field(8; "Total Score"; Code[20])
        {
            Caption = 'Total Score';
            DataClassification = ToBeClassified;
        }
        field(9; "Allow In Graduate"; Boolean)
        {
            Caption = 'Allow In Graduate';
            DataClassification = ToBeClassified;
        }
        field(10; "Unit Type"; Code[20])
        {
            Caption = 'Unit Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Pass"; Boolean)
        {
            Caption = 'Pass';
            DataClassification = ToBeClassified;
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
            Caption = 'Course Cat. Presidence';
            DataClassification = ToBeClassified;
        }
        field(13; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = ToBeClassified;
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
            Caption = 'Exam Score Decimal';
            DataClassification = ToBeClassified;
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
            Caption = 'CAT Score Decimal';
            DataClassification = ToBeClassified;
        }
        field(16; "Total Score Decimal"; Decimal)
        {
            Caption = 'Total Score Decimal';
            DataClassification = ToBeClassified;
        }
        field(17; "Weighted Total Score"; Decimal)
        {
            Caption = 'Weighted Total Score';
            DataClassification = ToBeClassified;
        }
        field(18; "Grade"; Code[20])
        {
            Caption = 'Grade';
            DataClassification = ToBeClassified;
        }
        field(19; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = ToBeClassified;
        }
        field(54; "Cohort"; Code[20])
        {
            Caption = 'Cohort';
            DataClassification = ToBeClassified;
        }
        field(55; "Use In Classification"; Boolean)
        {
            Caption = 'Use In Classification';
            DataClassification = ToBeClassified;
        }
        field(56; "Unit Exists"; Boolean)
        {
            Caption = 'Unit Exists';
            DataClassification = ToBeClassified;
        }
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Exists,"Does Not Exist";
        }
        field(58; "No. of Resits"; Integer)
        {
            Caption = 'No. of Resits';
            DataClassification = ToBeClassified;
        }
        field(59; "No. of Repeats"; Integer)
        {
            Caption = 'No. of Repeats';
            DataClassification = ToBeClassified;
        }
        field(60; "School Code"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = ToBeClassified;
        }
        field(61; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
        }
        field(62; "Grade Comment"; Text[50])
        {
            Caption = 'Grade Comment';
            // FieldClass = FlowField;
            // CalcFormula = Lookup("ACA-Exam Grading Source".Remarks WHERE(Academic Year=FIELD(Academic Year),Exam Catregory=FIELD(Exam Category),Total Score=FIELD(Total Score Decimal),Results Exists Status=FIELD(Results Exists Status)));
        }
        field(63; "Comsolidated Prefix"; Text[30])
        {
            Caption = 'Comsolidated Prefix';
            // FieldClass = FlowField;
            // CalcFormula=Lookup("ACA-Exam Grading Source"."Consolidated Prefix" WHERE (Academic Year=FIELD(Academic Year),Exam Catregory=FIELD(Exam Category),Total Score=FIELD(Total Score Decimal),Results Exists Status=FIELD(Results Exists Status)));
        }
        field(64; "Is a Resit/Repeat"; Boolean)
        {
            Caption = 'Is a Resit/Repeat';
            // FieldClass = FlowField;
            // CalcFormula=Exist("Aca-Special Exams Details" WHERE (Student No.=FIELD(Student No.),Programme=FIELD(Programme),Unit Code=FIELD(Unit Code)));
        }
        field(65; "Exam Category"; Code[20])
        {
            Caption = 'Exam Category';
            // FieldClass=FlowField;
            // CalcFormula=Lookup(ACA-Units/Subjects."Exam Category" WHERE (Programme Code=FIELD(Programme),Code=FIELD(Unit Code)));
        }
        field(66; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
            DataClassification = ToBeClassified;
        }
        field(67; "Lost"; Code[10])
        {
            Caption = 'Lost';
            DataClassification = ToBeClassified;
        }
        field(68; "Is Supp. Unit"; Boolean)
        {
            Caption = 'Is Supp. Unit';
            // FieldClass = FlowField;
            // CalcFormula=Exist("Aca-Special Exams Details" WHERE (Student No.=FIELD(Student No.),Unit Code=FIELD(Unit Code),Category=FILTER(Supplementary)));
        }
        field(69; "Special Unit Reason"; Code[20])
        {
            Caption = 'Special Unit Reason';
            DataClassification = ToBeClassified;
        }
        field(70; "Unit Stage"; Code[20])
        {
            Caption = 'Unit Stage';
            // FieldClass = FlowField;
            // CalcFormula=Lookup(ACA-Units/Subjects."Stage Code" WHERE (Programme Code=FIELD(Programme),Code=FIELD(Unit Code)));
        }
        field(71; "Is Special Unit"; Boolean)
        {
            Caption = 'Is Special Unit';
            // FieldClass = FlowField;
            // CalcFormula=Exist("Aca-Special Exams Details" WHERE (Student No.=FIELD(Student No.),Unit Code=FIELD(Unit Code),Category=FILTER(Special)));

        }
        field(72; "Is Supp/Special"; Boolean)
        {
            Caption = 'Is Supp/Special';
            // FieldClass = FlowField;
            // CalcFormula=Exist("Aca-Special Exams Details" WHERE (Student No.=FIELD(Student No.),Unit Code=FIELD(Unit Code),Academic Year=FIELD(Academic Year)));
        }
    }

    keys
    {
        key(PK; "Student No.", "Programme", "Unit Code")
        {
            Clustered = true;
        }
    }
}
