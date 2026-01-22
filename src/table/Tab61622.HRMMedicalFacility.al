#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61622 "HRM-Medical Facility"
{
    DrillDownPageId = "Medical Facilities";
    LookupPageId = "Medical Facilities";
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Facility Name"; Text[50])
        {
        }
        field(3; Contacts; Text[50])
        {
        }
        field(4; Location; Text[50])
        {
        }
        field(5; "Facility Type"; Option)
        {
            OptionMembers = ,FrontLine;
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

