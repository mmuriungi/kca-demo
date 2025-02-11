table 50054 "ACA-2ndSuppExam Class. Units"
{
    Caption = 'ACA-2ndSuppExam Class. Units';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Programme"; Code[20])
        {
            Caption = 'Programme';
            DataClassification = CustomerContent;
        }
        field(3; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = CustomerContent;
        }
        field(4; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
            DataClassification = CustomerContent;
        }
        field(5; "Credit Hours"; Decimal)
        {
            Caption = 'Credit Hours';
            DataClassification = CustomerContent;
        }
        field(6; "CAT Score"; Code[20])
        {
            Caption = 'CAT Score';
            DataClassification = CustomerContent;
        }
        field(7; "Exam Score"; Code[20])
        {
            Caption = 'Exam Score';
            DataClassification = CustomerContent;
        }
        field(8; "Total Score"; Code[20])
        {
            Caption = 'Total Score';
            DataClassification = CustomerContent;
        }
        field(9; "Allow In Graduate"; Boolean)
        {
            Caption = 'Allow In Graduate';
            DataClassification = CustomerContent;
        }
        field(10; "Unit Type"; Code[20])
        {
            Caption = 'Unit Type';
            DataClassification = CustomerContent;
        }
        field(11; "Pass"; Boolean)
        {
            Caption = 'Pass';
            DataClassification = CustomerContent;
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
            Caption = 'Course Cat. Presidence';
            DataClassification = CustomerContent;
        }
        field(13; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = CustomerContent;
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
            Caption = 'Exam Score Decimal';
            DataClassification = CustomerContent;
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
            Caption = 'CAT Score Decimal';
            DataClassification = CustomerContent;
        }
        field(16; "Total Score Decimal"; Decimal)
        {
            Caption = 'Total Score Decimal';
            DataClassification = CustomerContent;
        }
        field(17; "Weighted Total Score"; Decimal)
        {
            Caption = 'Weighted Total Score';
            DataClassification = CustomerContent;
        }
        field(18; "Grade"; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(19; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(54; "Cohort"; Code[20])
        {
            Caption = 'Cohort';
            DataClassification = CustomerContent;
        }
        field(55; "Use In Classification"; Boolean)
        {
            Caption = 'Use In Classification';
            DataClassification = CustomerContent;
        }
        field(56; "Unit Exists"; Boolean)
        {
            Caption = 'Unit Exists';
            DataClassification = CustomerContent;
        }
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(58; "No. of Resits"; Integer)
        {
            Caption = 'No. of Resits';
            DataClassification = CustomerContent;
        }
        field(59; "No. of Repeats"; Integer)
        {
            Caption = 'No. of Repeats';
            DataClassification = CustomerContent;
        }
        field(60; "School Code"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = CustomerContent;
        }
        field(61; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(62; "Grade Comment"; Text[50])
        {
            Caption = 'Grade Comment';
            DataClassification = CustomerContent;
        }
        field(63; "Comsolidated Prefix"; Text[30])
        {
            Caption = 'Comsolidated Prefix';
            DataClassification = CustomerContent;
        }
        field(64; "Is a Resit/Repeat"; Boolean)
        {
            Caption = 'Is a Resit/Repeat';
            DataClassification = CustomerContent;
        }
        field(65; "Exam Category"; Code[20])
        {
            Caption = 'Exam Category';
            DataClassification = CustomerContent;
        }
        field(66; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
            DataClassification = CustomerContent;
        }
        field(67; "Lost"; Code[10])
        {
            Caption = 'Lost';
            DataClassification = CustomerContent;
        }
        field(68; "Is Supp. Unit"; Boolean)
        {
            Caption = 'Is Supp. Unit';
            DataClassification = CustomerContent;
        }
        field(69; "Special Unit Reason"; Code[20])
        {
            Caption = 'Special Unit Reason';
            DataClassification = CustomerContent;
        }
        field(70; "Unit Stage"; Code[20])
        {
            Caption = 'Unit Stage';
            DataClassification = CustomerContent;
        }
        field(71; "Is Special Unit"; Boolean)
        {
            Caption = 'Is Special Unit';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Student No.", Programme, "Unit Code", "Academic Year", "Year of Study")
        {
            Clustered = true;
        }
    }
} 