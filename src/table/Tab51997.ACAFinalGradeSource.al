table 51997 "ACA-Final Grade Source"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Exam Catregory"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Grade"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Pass"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Remarks"; text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Missing CAT"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Missing Exam"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Override Transcript Comments"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Missed Both CAT & Exam"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Less Courses"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; "Academic Year", "Exam Catregory", "Total Score", Grade, "Missing CAT", "Missing Exam", "Missed Both CAT & Exam")
        {
            Clustered = true;
        }
        key(Key1; "Missing Exam")
        { }
    }

}