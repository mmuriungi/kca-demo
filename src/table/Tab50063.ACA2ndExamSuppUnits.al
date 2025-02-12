table 66689 "ACA-2ndExam Supp. Units"
{
    fields
    {
        field(1; "Student No."; Code[20])
        {
        }
        field(2; "Programme"; Code[20])
        {
        }
        field(3; "Unit Code"; Code[20])
        {
        }
        field(4; "Unit Description"; Text[150])
        {
        }
        field(5; "Credit Hours"; Decimal)
        {
        }
        field(6; "CAT Score"; Code[20])
        {
        }
        field(7; "Exam Score"; Code[20])
        {
        }
        field(8; "Total Score"; Code[20])
        {
        }
        field(9; "Allow In Graduate"; Boolean)
        {
        }
        field(10; "Unit Type"; Code[20])
        {
        }
        field(11; "Pass"; Boolean)
        {
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
        }
        field(13; "Year of Study"; Integer)
        {
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
        }
        field(16; "Total Score Decimal"; Decimal)
        {
        }
        field(17; "Weighted Total Score"; Decimal)
        {
        }
        field(18; "Grade"; Code[20])
        {
        }
        field(19; "Academic Year"; Code[20])
        {
        }
        field(54; "Cohort"; Code[20])
        {
        }
        field(55; "Use In Classification"; Boolean)
        {
        }
        field(56; "Unit Exists"; Boolean)
        {
        }
        field(57; "Results Exists Status"; Option)
        {
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";  // Add appropriate option members as needed
        }
        field(58; "No. of Resits"; Integer)
        {
        }
        field(59; "No. of Repeats"; Integer)
        {
        }
        field(60; "School Code"; Code[20])
        {
        }
        field(61; "Department Code"; Code[10])
        {
        }
        field(62; "Grade Comment"; Text[50])
        {
        }
        field(63; "Comsolidated Prefix"; Text[30])
        {
        }
        field(64; "Is a Resit/Repeat"; Boolean)
        {
        }
        field(65; "Exam Category"; Code[20])
        {
        }
        field(66; "Reporting Academic Year"; Code[20])
        {
        }
        field(67; "Lost"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.", "Unit Code", "Programme", "Academic Year")
        {
            SumIndexFields = "Total Score Decimal";
        }
        key(Key2; "Total Score")
        {
        }
        key(Key3; "Course Cat. Presidence")
        {
        }
    }
}