table 50047 "ACA-Hostel No Series"
{
    Caption = 'ACA-Hostel No Series';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary key"; Integer)
        {
            Caption = 'Primary key';
        }
        field(2; "Sub Store Nos"; Code[20])
        {
            Caption = 'Sub Store Nos';
            TableRelation = "No. Series"."Code";
        }
    }
    keys
    {
        key(PK; "Primary key")
        {
            Clustered = true;
        }
    }
}
