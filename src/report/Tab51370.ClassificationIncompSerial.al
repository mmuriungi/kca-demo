table 51370 "Classification Incomp. Serial"
{
    Caption = 'Classification Incomp. Serial';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            Caption = 'Student Number';
        }
        field(2; Serial; Integer)
        {
            Caption = 'Serial';
        }
    }
    keys
    {
        key(PK; "Student Number", Serial)
        {
            Clustered = true;
        }
    }
}
