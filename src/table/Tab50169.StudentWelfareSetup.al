table 50169 "Student Welfare Setup"
{
    Caption = 'Student Welfare Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Club/Society Nos"; Code[20])
        {
            Caption = 'Club/Society Nos';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
