table 51360 "Survey Student Groups"
{
    Caption = 'Survey Student Groups';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Survey Code"; Code[25])
        {
            Caption = 'Survey Code';
        }
        field(2; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
    }
    keys
    {
        key(PK; "Survey Code","Year of Study")
        {
            Clustered = true;
        }
    }
}
