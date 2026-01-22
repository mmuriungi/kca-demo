table 50071 "ACA-SuppExam Fail Reasons"
{
    Caption = 'ACA-SuppExam Fail Reasons';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(2; "Graduation Academic Year"; Code[20])
        {

        }
        field(3; "Reason Code"; Code[50])
        {

        }
        field(4; "Reason Details"; Text[250])
        {

        }
    }
    keys
    {
        key(PK; "Student No.")
        {
            Clustered = true;
        }
    }
}
