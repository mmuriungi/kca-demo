table 50070 "ACA-Exam Supp. Units"
{
    Caption = 'ACA-Exam Supp. Units';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(2; Programme; Code[20])
        {
            Caption = 'Programme';
        }
        field(3; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
        }
        field(4; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
        }
        field(5; "Credit Hours"; Decimal)
        {
            Caption = 'Credit Hours';
        }
        field(6; "CAT Score"; Code[20])
        {
            Caption = 'CAT Score';
        }
        field(7; "Exam Score"; Code[20])
        {
            Caption = 'Exam Score';
        }
        field(8; "Total Score"; Code[20])
        {
            Caption = 'Total Score';
        }
        field(9; "Allow In Graduate"; Boolean)
        {
            Caption = 'Allow In Graduate';
        }
        field(10; "Unit Type"; Code[20])
        {
            Caption = 'Unit Type';
        }
        field(11; Pass; Boolean)
        {
            Caption = 'Pass';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source".Pass WHERE("Academic Year" = FIELD("Academic Year"), "Exam Catregory" = FIELD("Exam Category"), "Total Score" = FIELD("Total Score Decimal"), "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
            Caption = 'Course Cat. Presidence';
        }
        field(13; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
            Caption = 'Exam Score Decimal';
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
            Caption = 'CAT Score Decimal';
        }
        field(16; "Total Score Decimal"; Decimal)
        {
            Caption = 'Total Score Decimal';
        }
        field(17; "Weighted Total Score"; Decimal)
        {
            Caption = 'Weighted Total Score';
        }
        field(18; Grade; Code[20])
        {
            Caption = 'Grade';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source".Grade WHERE("Academic Year" = FIELD("Academic Year"), "Exam Catregory" = FIELD("Exam Category"), "Total Score" = FIELD("Total Score Decimal"), "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(19; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(54; Cohort; Code[20])
        {
            Caption = 'Cohort';
        }
        field(55; "Use In Classification"; Boolean)
        {
            Caption = 'Use In Classification';
        }
        field(56; "Unit Exists"; Boolean)
        {
            Caption = 'Unit Exists';
            FieldClass = FlowField;
            CalcFormula = Exist("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme), Code = FIELD("Unit Code")));
        }
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(58; "No. of Resits"; Integer)
        {
            Caption = 'No. of Resits';
        }
        field(59; "No. of Repeats"; Integer)
        {
            Caption = 'No. of Repeats';
        }
        field(60; "School Code"; Code[20])
        {
            Caption = 'School Code';
        }
        field(61; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
        }
        field(62; "Grade Comment"; Text[50])
        {
            Caption = 'Grade Comment';
            FieldClass = FlowField;
            calcformula = Lookup("ACA-Exam Grading Source".Remarks WHERE("Academic Year" = FIELD("Academic Year"), "Exam Catregory" = FIELD("Exam Category"), "Total Score" = FIELD("Total Score Decimal"), "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(63; "Comsolidated Prefix"; Text[30])
        {
            Caption = 'Comsolidated Prefix';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source"."Consolidated Prefix" WHERE("Academic Year" = FIELD("Academic Year"), "Exam Catregory" = FIELD("Exam Category"), "Total Score" = FIELD("Total Score Decimal"), "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(64; "Is a Resit/Repeat"; Boolean)
        {
            Caption = 'Is a Resit/Repeat';
        }
        field(65; "Exam Category"; Code[20])
        {
            Caption = 'Exam Category';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Units/Subjects"."Exam Category" WHERE ("Programme Code"=FIELD(Programme),Code=FIELD("Unit Code")));
        }
        field(66; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
        }
        field(67; Lost; Code[10])
        {
            Caption = 'Lost';
        }
    }
    keys
    {
        key(PK; "Student No.", "Unit Code", Programme, "Academic Year")
        {
            Clustered = true;
        }
        key(TotalScore; "Total Score")
        {
        }
        key(CourseCatPresidence; "Course Cat. Presidence")
        {
        }
    }
}
