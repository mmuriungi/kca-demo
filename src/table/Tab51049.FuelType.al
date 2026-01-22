table 51049 "Fuel Type"
{
    LookupPageId = "Fuel Type List";
    DrillDownPageId = "Fuel Type List";
    Caption = 'Fuel Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Fuel Code"; Code[65])
        {
            Caption = 'Fuel Code';
        }
        field(2; "Fuel Name"; Code[67])
        {
            Caption = 'Fuel Name';
        }
    }
    keys
    {
        key(PK; "Fuel Code")
        {
            Clustered = true;
        }
    }
}
