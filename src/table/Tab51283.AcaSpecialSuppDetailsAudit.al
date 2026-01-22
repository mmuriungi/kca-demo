table 51283 "Aca-Special/Supp Details Audit"
{
    Caption = 'Aca-Special/Supp Details Audit';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(2; Semester; Code[20])
        {
            Caption = 'Semester';
        }
        field(3; "Exam Session"; Code[20])
        {
            Caption = 'Exam Session';
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(5; Stage; Code[20])
        {
            Caption = 'Stage';
        }
        field(6; Programme; Code[20])
        {
            Caption = 'Programme';
        }
        field(7; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
        }
        field(8; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " "; // Add your option members here
        }
        field(11; "CAT Marks"; Decimal)
        {
            Caption = 'CAT Marks';
        }
        field(12; "Exam Marks"; Decimal)
        {
            Caption = 'Exam Marks';
        }
        field(13; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
        }
        field(15; "Cost Per Exam"; Decimal)
        {
            Caption = 'Cost Per Exam';
        }
        field(16; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " "; // Add your option members here
        }
        field(17; "Current Academic Year"; Code[20])
        {
            Caption = 'Current Academic Year';
        }
        field(18; "Marks Exists"; Boolean)
        {
            Caption = 'Marks Exists';
        }
        field(19; Sequence; Integer)
        {
            Caption = 'Sequence';
        }
        field(20; "Special Exam Reason"; Code[20])
        {
            Caption = 'Special Exam Reason';
        }
        field(21; "Current Semester"; Code[20])
        {
            Caption = 'Current Semester';
        }
        field(22; "Charge Posted"; Boolean)
        {
            Caption = 'Charge Posted';
        }
        field(23; "Flow Marks"; Decimal)
        {
            Caption = 'Flow Marks';
        }
        field(24; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(25; "Created Date/Time"; DateTime)
        {
            Caption = 'Created Date/Time';
        }
        field(26; "Last Edited By"; Code[20])
        {
            Caption = 'Last Edited By';
        }
        field(27; "Last Edited Date/Time"; DateTime)
        {
            Caption = 'Last Edited Date/Time';
        }
        field(28; "Original Marks"; Decimal)
        {
            Caption = 'Original Marks';
        }
        field(29; "New Mark"; Decimal)
        {
            Caption = 'New Mark';
        }
        field(30; Occurances; Integer)
        {
            Caption = 'Occurances';
        }
        field(31; "Corect Semester Year"; Code[20])
        {
            Caption = 'Corect Semester Year';
        }
        field(32; "Academic Year Matches"; Boolean)
        {
            Caption = 'Academic Year Matches';
        }
        field(33; "Combined Score"; Decimal)
        {
            Caption = 'Combined Score';
        }
        field(34; "Exact Score Exists"; Boolean)
        {
            Caption = 'Exact Score Exists';
        }
        field(35; Cat_Score_Flow; Decimal)
        {
            Caption = 'Cat_Score_Flow';
        }
        field(36; "Results Released"; Boolean)
        {
            Caption = 'Results Released';
        }
        field(37; Billed; Boolean)
        {
            Caption = 'Billed';
        }
        field(38; "Total Score"; Decimal)
        {
            Caption = 'Total Score';
        }
        field(39; "CATs Marks"; Decimal)
        {
            Caption = 'CATs Marks';
        }
        field(40; "EXAMs Marks"; Decimal)
        {
            Caption = 'EXAMs Marks';
        }
        field(41; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(42; "Update Type"; Text[50])
        {
            Caption = 'Update Type';
        }
    }

    keys
    {
        key(PK; "Student No.", "Unit Code", "Academic Year", Semester, Sequence, Programme, Stage, Category, "Entry No.")
        {
            Clustered = true;
        }
        key(key1; Sequence)
        {
        }
    }
}