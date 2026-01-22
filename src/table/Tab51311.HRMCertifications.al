table 51311 "HRM-Certifications"
{
    Caption = 'HRM-Certifications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
        }
        field(3; "Type"; Text[50])
        {
            Caption = 'Type';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; Body; Text[50])
        {
            Caption = 'Body';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
        }
        field(7; Qualification; Text[50])
        {
            Caption = 'Qualification';
        }
    }
    keys
    {
        key(PK; "No.", "Employee Code")
        {
            Clustered = true;
        }
    }
}
