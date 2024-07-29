table 54347 "DAQA Setups"
{
    Caption = 'DAQA Setups';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {

        }
        field(2; "Orientation Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Lec TakeOff Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Exam Admin Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Lecturer Experience Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "Teaching Practice Nos"; code[20])
        {

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
