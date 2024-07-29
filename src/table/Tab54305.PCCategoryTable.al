table 54305 "PC Category Table"
{
    Caption = 'PC category Table';
    DataClassification = ToBeClassified;
    LookupPageId = "PC Category list";
    DrillDownPageId = "PC Category list";
    fields
    {
        field(1; "Code "; Code[20])
        {
            Caption = 'Code ';
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
        key(PK; "Code ")
        {
            Clustered = true;
        }
    }
}
