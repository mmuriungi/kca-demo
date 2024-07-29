table 53061 "Meal-Proc. Central Setup"
{
    DrillDownPageID = "Meal-Proc. Central Setup";
    LookupPageID = "Meal-Proc. Central Setup";

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Customer Group,Sub-Group';
            OptionMembers = "Customer Group","Sub-Group";
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Processing Batch Serial"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; Type)
        {
        }
    }

    fieldgroups
    {
    }
}

