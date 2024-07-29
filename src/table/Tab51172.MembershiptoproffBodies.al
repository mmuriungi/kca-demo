table 51172 "Membership to proff Bodies"
{
    Caption = 'Membership to proff Bodies';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }
        field(2; "Name of the body"; Code[60])
        {
            Caption = 'Name of the body';
        }
        field(3; "Period of Membership"; Code[150])
        {
            Caption = 'Period of Membership';
        }
    }
    keys
    {
        key(PK; "Job Application No")
        {
            Clustered = true;
        }
    }
}
