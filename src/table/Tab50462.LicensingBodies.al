table 50462 "Licensing Bodies"
{
    Caption = 'Licensing Bodies';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }
        field(2; "licensing Body"; Code[60])
        {
            Caption = 'licensing Body';
        }
        field(3; "License Number "; Code[68])
        {
            Caption = 'License Number ';
        }
        field(4; "license period(from)"; Date)
        {
            Caption = 'license period(from)';
        }
        field(5; "license period (To)"; Date)
        {
            Caption = 'license period (To)';
        }

    }
    keys
    {
        key(PK; "Job Application No", "License Number ")
        {
            Clustered = true;
        }
    }
}
