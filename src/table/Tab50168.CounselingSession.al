table 50168 "Counseling Session"
{
    Caption = 'Counseling Session';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Session No."; Code[20])
        {
            Caption = 'Session No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer where("Customer Type" = CONST(Student));
        }
        field(3; "Counselor No."; Code[20])
        {
            Caption = 'Counselor No.';
            TableRelation = Employee;
        }
        field(4; "Session Date"; Date)
        {
            Caption = 'Session Date';
        }
        field(5; "Issue Description"; Text[250])
        {
            Caption = 'Issue Description';
        }
        field(6; Recommendations; Text[250])
        {
            Caption = 'Recommendations';
        }
        field(7; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
        }
    }

    keys
    {
        key(PK; "Session No.")
        {
            Clustered = true;
        }
    }
}
