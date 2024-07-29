table 54874 "HMS-Setup Lab Test"
{
    LookupPageID = "HMS-Setup Lab Test List";

    fields
    {
        field(1; "Code"; Code[120])
        {
            NotBlank = true;
        }
        field(2; Description; Text[130])
        {
            NotBlank = true;
        }
        field(3; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

