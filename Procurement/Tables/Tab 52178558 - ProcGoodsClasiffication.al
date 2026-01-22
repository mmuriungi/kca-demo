table 52178558 "Proc-Goods Clasiffication"
{
    Caption = 'Proc-Goods Clasiffication';
    DataClassification = ToBeClassified;
    LookupPageId = "Proc-Goods Classification";
    DrillDownPageId = "Proc-Goods Classification";

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
