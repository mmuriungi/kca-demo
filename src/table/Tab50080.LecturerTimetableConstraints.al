table 50080 "Lecturer Timetable Constraints"
{
    Caption = 'Lecturer Timetable Constraints';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Semester; Code[25])
        {
            Caption = 'Semester';
        }
        field(2; "Lecturer No."; Code[25])
        {
            Caption = 'Lecturer No.';
            TableRelation = "HRM-Employee C" where(Lecturer = const(true));
        }
        field(3; "Constraint Type"; Option)
        {
            Caption = 'Constraint Type';
            OptionMembers = " ",Exempt,Allow;
        }
        field(4; "Day of The week"; Enum "Day of Week")
        {
            Caption = 'Day of The week';
        }
    }
    keys
    {
        key(PK; Semester, "Lecturer No.", "Constraint Type", "Day of The week")
        {
            Clustered = true;
        }
    }
}
