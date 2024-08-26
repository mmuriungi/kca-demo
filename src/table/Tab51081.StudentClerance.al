table 51081 "Student Clerance"
{
    Caption = 'Student Clerance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Clearance No"; Code[20])
        {
            Caption = 'Clearance No';
        }
        field(2; "Student No"; Code[20])
        {
            Caption = 'Student No';
        }
        field(3; "Student Name "; Text[200])
        {
            Caption = 'Student Name ';
        }
        field(4; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('DEPARTMENT'));
        }
        field(5; School; Code[20])
        {
            Caption = 'School';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('FACULTY'));
        }
        field(6; "Mobile No"; Text[13])
        {
            Caption = 'Mobile No';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,Pending,Approved,Cancelled,Posted;
        }
    }
    keys
    {
        key(PK; "Clearance No", "Student No")
        {
            Clustered = true;
        }
    }
}
