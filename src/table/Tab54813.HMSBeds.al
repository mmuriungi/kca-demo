table 54813 "HMS-Beds"
{
    LookupPageID = "HMS Beds";

    fields
    {
        field(1; "Ward No"; Code[20])
        {
            TableRelation = "HMS-Ward Setup"."Ward Code";
        }
        field(2; "Bed No"; Code[20])
        {
        }
        field(3; "Bed Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Ward No", "Bed No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

