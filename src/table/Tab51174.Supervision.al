table 51174 "Supervision "
{
    Caption = 'Supervision ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }
        field(2; "Supervision Category"; Option)
        {
            Caption = 'Supervision Category';
            OptionMembers = "",Masters,PhD;
        }
        field(3; "No. Of Successfully supervised"; Integer)
        {
            Caption = 'No. Of Successfully supervised';
        }
        field(4; "No. Of Ongoing Supervision "; Integer)
        {
            Caption = 'No. Of Ongoing Supervision ';
        }
    }
    keys
    {
        key(PK; "Job Application No", "Supervision Category")
        {
            Clustered = true;
        }
    }
}
