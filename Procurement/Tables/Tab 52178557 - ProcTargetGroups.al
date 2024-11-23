table 52178557 "Proc-Target Groups"
{
    Caption = 'Proc-Target Groups';
    DataClassification = ToBeClassified;
    LookupPageId = "Proc-Target Groups";
    DrillDownPageId = "Proc-Target Groups";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
