table 50119 "Prequalification Categories"
{
    Caption = 'Prequalification Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Document No."; code[20])
        {

        }
    }
    keys
    {
        key(PK; "Category Code")
        {
            Clustered = true;
        }
    }
}
