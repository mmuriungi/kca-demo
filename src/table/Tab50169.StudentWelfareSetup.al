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
        field(3; "Leave Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Leave Nos';
            TableRelation = "No. Series";
        }
        field(4; "Counseling Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Counseling Nos';
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
