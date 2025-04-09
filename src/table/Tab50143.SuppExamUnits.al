table 51353 "Supp. Exam Units"
{
    Caption = 'Supp. Exam Units';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Semester; Code[25])
        {
            Caption = 'Semester';
        }
        field(2; Programme; Code[25])
        {
            Caption = 'Programme';
        }
        field(3; "Unit Code"; Code[25])
        {
            Caption = 'Unit Code';
        }
        field(4; "Lecturer Code"; Code[25])
        {
            Caption = 'Lecturer Code';
        }
    }
    keys
    {
        key(PK; Semester,Programme)
        {
            Clustered = true;
        }
    }
}
