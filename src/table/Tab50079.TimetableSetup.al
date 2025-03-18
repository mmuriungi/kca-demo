table 50079 "Timetable Setup"
{
    Caption = 'Timetable Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; Code[10])
        {
            Caption = 'Pk';
        }
        field(2; "Maximum Students (STEM)"; Integer)
        {
            Caption = 'Maximum Students (STEM)';
        }
        field(3; "Maximum Students per Exam"; integer)
        {
            Caption = 'Maximum Students per Exam';
        }
        field(4; "Maximum Students (Non-STEM)"; integer)
        {
            Caption = 'Maximum Students (Non-STEM)';
        }
    }
    keys
    {
        key(PK; Pk)
        {
            Clustered = true;
        }
    }
}
