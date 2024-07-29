table 52040 "std Fee penalties Line"
{
    Caption = 'std Fee penalties';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(4; "Semester Code"; Code[20])
        {
            Caption = 'Semester Code';
        }
        field(5; Balance; Decimal)
        {
            Caption = 'Balance';
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(7; Penalty; Decimal)
        {
            Caption = 'Penalty';
        }
        field(8; "Student Name"; text[100])
        {

        }
        field(9; Description; text[200])
        {

        }
    }
    keys
    {
        key(PK; "Line No.", "Document No.", "Semester Code")
        {
            Clustered = true;
        }
    }
}
