table 66683 "ACA-2ndSuppExam Fail Reasons"
{
    fields
    {
        field(1; "Student No."; Code[20])
        {
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
        key(Key1; "Student No.", "Graduation Academic Year", "Reason Code")
        {
            Clustered = true;
        }
    }
}