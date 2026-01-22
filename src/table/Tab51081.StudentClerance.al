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
        //"Department Cleared"
        field(8; "Department Cleared"; Boolean)
        {
            Caption = 'Department Cleared';
        }
        //"School Cleared"
        field(9; "School Cleared"; Boolean)
        {
            Caption = 'School Cleared';
        }
        //"Department Cleared Name"
        field(10; "Department Cleared Name"; Text[200])
        {
            Caption = 'Department Cleared Name';
        }
        //"School Cleared Name"
        field(11; "School Cleared Name"; Text[200])
        {
            Caption = 'School Cleared Name';
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
