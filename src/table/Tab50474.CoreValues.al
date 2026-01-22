/// <summary>
/// Table Core Values (ID 50044).
/// </summary>
table 50474 "Core Values"
{
    Caption = 'Core Values';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[500])
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
    fieldgroups
    {
        fieldgroup(dropdown; Code)
        {

        }
    }
}
