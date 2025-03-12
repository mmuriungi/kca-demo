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
        field(2; "Maximum Students per class"; Integer)
        {
            Caption = 'Maximum Students per class';
        }
        field(3; "Maximum Students per Exam"; integer)
        {
            Caption = 'Maximum Students per Exam';
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
