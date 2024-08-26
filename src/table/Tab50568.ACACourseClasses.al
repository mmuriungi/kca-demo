table 50568 "ACA-Course Classes"
{
    DrillDownPageID = "ACA-Course Classes";
    LookupPageID = "ACA-Course Classes";

    fields
    {
        field(1; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; "Code"; Code[20])
        {
        }
        field(4; Description; Text[150])
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

