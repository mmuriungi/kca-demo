table 51282 "ACA-Exam Results Audit"
{
    Caption = 'ACA-Exam Results Audit';
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
        field(11; Contribution; Decimal)
        {
            Caption = 'Contribution';
        }
        field(12; "No Registration"; Boolean)
        {
            Caption = 'No Registration';
        }
        field(13; "System Created"; Boolean)
        {
            Caption = 'System Created';
        }
        field(15; "Re-Sit"; Boolean)
        {
            Caption = 'Re-Sit';
            // FieldClass = FlowField;
            // CalcFormula = Lookup("ACA-Student Units"."Re-Sit" WHERE("Student No." = FIELD("Student No."), "Unit Code" = FIELD(Unit)));
        }
        field(16; "Re-Sited"; Boolean)
        {
            Caption = 'Re-Sited';
        }
        field(17; "Repeated Score"; Decimal)
        {
            Caption = 'Repeated Score';
        }
        field(18; "Exam Category"; Code[50])
        {
            Caption = 'Exam Category';
        }
        field(19; ExamType; Code[50])
        {
            Caption = 'ExamType';
        }
        field(20; "Admission No"; Code[50])
        {
            Caption = 'Admission No';
        }
        field(21; SN; Boolean)
        {
            Caption = 'SN';
        }
        field(22; Reported; Boolean)
        {
            Caption = 'Reported';
        }
        field(23; "Lecturer Names"; Text[250])
        {
            Caption = 'Lecturer Names';
        }
        field(24; User_ID; Code[50])
        {
            Caption = 'User_ID';
        }
        field(50001; "Original Score"; Decimal)
        {
            Caption = 'Original Score';
        }
        field(50002; "Last Edited By"; Code[50])
        {
            Caption = 'Last Edited By';
        }
        field(50003; "Last Edited On"; Date)
        {
            Caption = 'Last Edited On';
        }
        field(50004; Submitted; Boolean)
        {
            Caption = 'Submitted';
        }
        field(50005; "Submitted On"; Date)
        {
            Caption = 'Submitted On';
        }
        field(50006; "Submitted By"; Code[50])
        {
            Caption = 'Submitted By';
        }
        field(50007; Category; Code[50])
        {
            Caption = 'Category';
        }
        field(50008; Department; Code[50])
        {
            Caption = 'Department';
        }
        field(50009; "Original Contribution"; Decimal)
        {
            Caption = 'Original Contribution';
        }
        field(50012; "Semester Total"; Decimal)
        {
            Caption = 'Semester Total';
        }
        field(50013; "Attachment Unit"; Boolean)
        {
            Caption = 'Attachment Unit';
        }
        field(50014; "Re-Take"; Boolean)
        {
            Caption = 'Re-Take';
        }
        field(50015; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
        }
        field(50016; "Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
        }
        field(50017; "Cancelled Date"; Date)
        {
            Caption = 'Cancelled Date';
        }
        field(50018; "Academic Year"; Code[50])
        {
            Caption = 'Academic Year';
        }
        field(50019; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(50020; "GPA Points"; Decimal)
        {
            Caption = 'GPA Points';
        }
        field(50021; "Credit Hours"; Decimal)
        {
            Caption = 'Credit Hours';
        }
        field(50023; "Edit Count"; Integer)
        {
            Caption = 'Edit Count';
        }
        field(50024; "Counted Occurances"; Integer)
        {
            Caption = 'Counted Occurances';
        }
        field(50025; "Unit Registration Exists"; Boolean)
        {
            Caption = 'Unit Registration Exists';
        }
        field(50026; "Number of Occurances"; Integer)
        {
            Caption = 'Number of Occurances';
        }
        field(50027; "To Delete"; Boolean)
        {
            Caption = 'To Delete';
        }
        field(63020; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " "; // Add your option members here
        }
        field(63021; "Count Exam Occurances"; Integer)
        {
            Caption = 'Count Exam Occurances';
        }
        field(63022; "Count CAT Occurances"; Integer)
        {
            Caption = 'Count CAT Occurances';
        }
        field(63023; "Exam is Multiple"; Boolean)
        {
            Caption = 'Exam is Multiple';
        }
        field(63024; "CAT is Multiple"; Boolean)
        {
            Caption = 'CAT is Multiple';
        }
        field(63025; "Number of Resits"; Integer)
        {
            Caption = 'Number of Resits';
        }
        field(63026; "Number of Repeats"; Integer)
        {
            Caption = 'Number of Repeats';
        }
        field(63027; "Unit Name"; Text[150])
        {
            Caption = 'Unit Name';
        }
        field(63028; "Last Modified by"; Code[20])
        {
            Caption = 'Last Modified by';
        }
        field(63029; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
        }
        field(63030; "Last Modified Time"; Time)
        {
            Caption = 'Last Modified Time';
        }
        field(63031; "Update Type"; Code[100])
        {
            Caption = 'Update Type';
        }
    }

    keys
    {
        key(PK; Programme, Stage, Unit, Semester, "Student No.", Exam)
        {
            Clustered = true;
        }
    }
}
