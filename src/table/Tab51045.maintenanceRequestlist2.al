table 51045 "maintenance Request list2"
{
    Caption = ' maintenance Request';
    DataClassification = ToBeClassified;
    LookupPageId = "maintenance Request lists";
    DrillDownPageId = "maintenance Request lists";

    fields
    {
        field(1; "Code"; Code[60])
        {
            Caption = 'Code';
        }
        field(2; " Maintenance Descriptions"; Code[100])
        {
            Caption = ' Maintenance Descriptions';
        }
    }
    keys
    {
        key(PK; "Code", " Maintenance Descriptions")
        {
            Clustered = true;
        }
    }
}
