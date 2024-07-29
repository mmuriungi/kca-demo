table 54355 NonRangedResults
{
    Caption = 'NonRangedResults';
    DataClassification = ToBeClassified;
    LookupPageId = NonRangedResults;
    DrillDownPageId = NonRangedResults;

    fields
    {
        field(1; "result Code"; Code[40])
        {
            Caption = 'result Code';
        }
        field(2; "result Name"; Code[60])
        {
            Caption = 'result Name';
        }

    }
    keys
    {
        key(PK; "result Code", "result Name")
        {
            Clustered = true;
        }
    }
}
